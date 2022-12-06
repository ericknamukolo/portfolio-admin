class Skill {
  String id;
  String name;
  String des;
  String iconUrl;
  bool isHidden;
  DateTime date;

  Skill({
    required this.date,
    required this.id,
    required this.des,
    required this.iconUrl,
    required this.isHidden,
    required this.name,
  });
}
