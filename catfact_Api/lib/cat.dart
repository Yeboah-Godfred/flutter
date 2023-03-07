class Cats {
  String fact;
  num length;

  Cats({required this.fact, required this.length});

  factory Cats.fromJason(Map<String, dynamic> cat) {
    return Cats(
      fact: cat['fact'],
      length: cat['length']);
  }
}
