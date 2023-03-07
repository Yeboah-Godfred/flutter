import 'dart:convert';

import 'package:flutter/material.dart';
import 'bored.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Bored? bored;

  String boredactivity = "";
  String boredtype = "";
  num? boredparticipants;
  num? boredprice;
  String boredlink = "";
  String boredkey = "";
  num? boredaccessibility;

  fetchBored() async {
    Uri url = Uri.parse('https://www.boredapi.com/api/activity');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;

      bored = Bored.fromJason(body);

      setState(() {
        boredactivity = bored!.activity;
        boredtype = bored!.type;
        boredparticipants = bored!.participants;
        boredprice = bored!.price;
        boredlink = bored!.link;
        boredkey = bored!.key;
        boredaccessibility = bored!.accessibility;
      });
    } else {
      String notFound = "NOT FOUND";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 227, 69, 142),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Feeling Bored?",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              fontFamily: 'Monospace'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  """KEY : $boredkey \n\nPARTICIPANTS : $boredparticipants \n 
PRICE : \$$boredprice \n\nACCESSIBILITY : $boredaccessibility \n\nTYPE : $boredtype
\n LINK : $boredlink""",
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Times New Roman',
                      color: Color.fromARGB(255, 250, 248, 248)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(255, 248, 245, 245), width: 4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ACTIVITY : $boredactivity",
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        height: 60,
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          fetchBored();
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
