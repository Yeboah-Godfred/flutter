class Dog {
  String message;
  String status;

  Dog({required this.message, required this.status});

  factory Dog.fromJason(Map<String, dynamic> dogs) {
    return Dog(
      message: dogs['message'],
      status: dogs['status']);
  }
}
