import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:portfolio_admin/constants/constants.dart';
part 'skill.g.dart';

@JsonSerializable()
class Skill {
  String? id;
  String name;
  String des;
  String img;
  bool hidden;
  DateTime date;

  Skill({
    required this.date,
    this.id,
    required this.des,
    required this.img,
    required this.hidden,
    required this.name,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
  Map<String, dynamic> toJson() => _$SkillToJson(this);

  static List<Skill> fromMap(Map<dynamic, dynamic> dataList) {
    List<Skill> _loadedSkills = [];
    dataList.forEach((id, element) {
      String rawJson = jsonEncode(element);
      Skill skill = Skill.fromJson(jsonDecode(rawJson));
      skill.id = id;
      _loadedSkills.add(skill);
    });
    return _loadedSkills;
  }
}
