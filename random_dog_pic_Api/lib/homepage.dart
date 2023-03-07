import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dog.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Dog? dog;
  String dogmessage = "";
  String dogstatus = "";

  fetchDog() async {
    Uri url = Uri.parse("https://dog.ceo/api/breeds/image/random");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;

      dog = Dog.fromJason(body);

      setState(() {
        dogmessage = dog!.message;
        dogstatus = dog!.status;
      });
    } else {
      print("NOT FOUND");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 230, 140),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text(
          "Favorite Dog",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 140,
              foregroundImage: NetworkImage(dogmessage),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Status : $dogstatus",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: () async {
                await fetchDog();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Fetch Dog",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        height: 50,
        color: Colors.blue,
      ),
    );
  }
}
