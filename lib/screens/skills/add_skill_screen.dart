import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portfolio_admin/providers/skill/skills.dart';
import 'package:portfolio_admin/widgets/custom_button.dart';
import 'package:portfolio_admin/widgets/custom_text_field.dart';
import 'package:portfolio_admin/widgets/custom_toast.dart';
import 'package:portfolio_admin/widgets/cutsom_app_bar.dart';

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

  @override
  void dispose() {
    _name.dispose();
    _des.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Skill', showLeading: true),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
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
              click: () async {
                try {
                  await Skills.addSkill(_name.text, _des.text);
                } catch (e) {
                  BotToast.showCustomNotification(
                      toastBuilder: (context) =>
                          CustomToast(message: e.toString(), type: 'error'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
