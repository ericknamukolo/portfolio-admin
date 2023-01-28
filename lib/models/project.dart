import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Project {
  String name;
  File coverImg;
  String des;
  String type;
  List<XFile> images;
  String? googleLink;
  String? githubLink;
  String? externalLink;

  Project({
    required this.name,
    required this.des,
    required this.type,
    required this.images,
    required this.coverImg,
    this.githubLink,
    this.googleLink,
    this.externalLink,
  });
}
