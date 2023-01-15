class NotiObj {
  String id;
  String title;
  String? ip;
  String body;
  String category;
  String device;
  DateTime date;

  NotiObj({
    required this.id,
    required this.title,
    required this.body,
     this.ip,
    required this.category,
    required this.date,
    required this.device,
  });
}
