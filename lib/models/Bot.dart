class Bot {
  String name;
  String description;
  String date;
  List<String> knowledge; // Thêm thuộc tính knowledge

  Bot({
    required this.name,
    required this.description,
    required this.date,
    required this.knowledge, // Yêu cầu khởi tạo knowledge
  });
}
