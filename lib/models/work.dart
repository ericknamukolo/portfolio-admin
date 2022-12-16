class Work {
  String company;
  String position;
  String country;
  String empType;
  String state;
  String siteUrl;
  String startDate;
  String workDone;
  String? endDate;
  bool worksHere;

  Work({
    required this.company,
    required this.position,
    required this.country,
    required this.empType,
    required this.state,
    required this.siteUrl,
    required this.startDate,
    required this.workDone,
    this.endDate,
    this.worksHere = false,
  });
}
