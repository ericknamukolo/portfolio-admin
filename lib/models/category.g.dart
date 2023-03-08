// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotiCategory _$NotiCategoryFromJson(Map<String, dynamic> json) => NotiCategory(
      id: json['id'] as String?,
      name: json['name'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$NotiCategoryToJson(NotiCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isSelected': instance.isSelected,
    };
