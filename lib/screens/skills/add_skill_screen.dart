import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio_admin/constants/text.dart';
import 'package:portfolio_admin/providers/skill/skills.dart';
import 'package:portfolio_admin/widgets/custom_button.dart';
import 'package:portfolio_admin/widgets/custom_loading.dart';
import 'package:portfolio_admin/widgets/custom_text_field.dart';
import 'package:portfolio_admin/widgets/custom_toast.dart';
import 'package:portfolio_admin/widgets/cutsom_app_bar.dart';

import '../../constants/colors.dart';

class AddSkillScreen extends StatefulWidget {
  static const routeName = '/add-skill-screen';
  const AddSkillScreen({super.key});

  @override
  State<AddSkillScreen> createState() => _AddSkillScreenState();
}

class _AddSkillScreenState extends State<AddSkillScreen> {
  final _name = TextEditingController();
  final _des = TextEditingController();
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  File? _icon;

  Future<void> getDp() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    File imageTemp = File(pickedImage.path);
    setState(() {
      _icon = imageTemp;
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _des.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isLoading ? CustomLoading() : null,
      appBar: CustomAppBar(title: 'Add Skill', showLeading: true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                getDp();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10.0),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _icon == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text('Icon', style: kBodyTextStyleWhite),
                        ],
                      )
                    : Image.file(
                        _icon!,
                      ),
              ),
            ),
            CustomTextField(
              hint: 'Name',
              preIcon: Iconsax.code_15,
              data: _name,
            ),
            CustomTextField(
              hint: 'Description',
              preIcon: Icons.description_rounded,
              data: _des,
            ),
            const Spacer(),
            CustomButton(
              btnText: 'Add Skill',
              isLoading: _isLoading,
              click: () async {
                try {
                  setState(() => _isLoading = true);
                  await Skills.addSkill(_icon!, _name.text, _des.text);
                  setState(() => _isLoading = false);
                  Navigator.of(context).pop();
                } catch (e) {
                  BotToast.showCustomNotification(
                      toastBuilder: (context) =>
                          CustomToast(message: e.toString(), type: 'error'));
                  setState(() => _isLoading = false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
