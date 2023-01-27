class Project {
  String name;
  String des;
  String type;
  String? googleLink;
  String? githubLink;
  String? externalLink;

  Project({
    required this.name,
    required this.des,
    required this.type,
    this.githubLink,
    this.googleLink,
    this.externalLink,
  });
}
