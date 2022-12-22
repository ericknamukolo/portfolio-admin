class Work {
  String company;
  String position;
  String country;
  String empType;
  String state;
  String? siteUrl;
  String startDate;
  String? createdDate;
  String workDone;
  String? endDate;
  bool worksHere;
  bool isHidden;

  Work({
    required this.company,
    required this.position,
    required this.country,
    required this.empType,
    required this.state,
    this.createdDate,
    this.siteUrl,
    required this.startDate,
    required this.workDone,
    this.endDate,
    this.worksHere = false,
    this.isHidden = false,
  });
}
