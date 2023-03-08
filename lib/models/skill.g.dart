// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Skill _$SkillFromJson(Map<String, dynamic> json) => Skill(
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as String?,
      des: json['des'] as String,
      img: json['img'] as String,
      hidden: json['hidden'] as bool,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'des': instance.des,
      'img': instance.img,
      'hidden': instance.hidden,
      'date': instance.date.toIso8601String(),
    };
