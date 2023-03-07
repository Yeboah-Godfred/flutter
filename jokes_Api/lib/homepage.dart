import 'dart:convert';

import 'package:flutter/material.dart';
import 'jokesclass.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Jokes? jokes;
  String joketype = "";
  String jokepunchline = "";
  String jokesetup = "";
  num? jokeid;

  fetchJoke() async {
    Uri url = Uri.parse("https://official-joke-api.appspot.com/random_joke");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;

      setState(() {
        jokes = Jokes.fromJason(body);
        jokesetup = jokes!.setup;
        joketype = jokes!.type;
        jokeid = jokes!.id;
        jokepunchline = jokes!.punchline;
      });
    } else {
      print("Not Found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          "Crack Jokes",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w600,
              fontFamily: 'Monospace'),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ID : $jokeid",
              style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "TYPE  : $joketype",
              style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "JOKE: \n $jokesetup ",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "PUNCHLINE  :\n $jokepunchline",
                style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        height: 50,
        color: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          await fetchJoke();
        },
        child: const Icon(
          Icons.refresh,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
