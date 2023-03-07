class Jokes {
  String type;
  String setup;
  String punchline;
  num id;

  Jokes({required this.type,required this.setup,required this.punchline,required this.id});

  factory Jokes.fromJason(Map<String, dynamic> joking) {
    return Jokes(
        type: joking['type'],
        setup: joking['setup'],
        punchline: joking['punchline'],
        id: joking['id']);
  }
}