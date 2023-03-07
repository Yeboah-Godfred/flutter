class Bored {
  String activity;
  String type;
  num participants;
  num price;
  String link;
  String key;
  num accessibility;

  Bored({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.link,
    required this.key,
    required this.accessibility,
  });

  factory Bored.fromJason(Map<String, dynamic> bore) {
    return Bored(
      activity: bore['activity'],
      type: bore['type'],
      participants: bore['participants'],
      price: bore['price'],
      link: bore['link'],
      key: bore['key'],
      accessibility: bore['accessibility']
    );
  }
}
