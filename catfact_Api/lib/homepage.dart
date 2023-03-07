import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Cats? cats;
  String catfact = "";
  num? catlength;

  fetchCats() async {
    Uri url = Uri.parse("https://catfact.ninja/fact");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;

      cats = Cats.fromJason(body);

      setState(() {
        catfact = cats!.fact;
        catlength = cats!.length;
      });
    } else {
      String notFound = "NOT FOUND";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "FACT!",
          style: TextStyle(
              fontFamily: 'Audiowide',
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "FACT LENGTH : $catlength",
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Monospace',
                  color: Colors.white),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "          DID YOU KNOW? \n\n $catfact",
                  style: const TextStyle(
                      fontSize: 30,
                      fontFamily: 'calibri',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar: const BottomAppBar(
        height: 50,
        color: Colors.orange,
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await fetchCats();
        },
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.refresh,
          color: Colors.black,
          size: 50,
        ),
      ),
    );
  }
}
