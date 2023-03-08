import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class NotiCategory {
  String? id;
  String name;
  bool isSelected;

  NotiCategory({
    this.id,
    required this.name,
    this.isSelected = false,
  });

  factory NotiCategory.fromJson(Map<String, dynamic> json) =>
      _$NotiCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$NotiCategoryToJson(this);
}
