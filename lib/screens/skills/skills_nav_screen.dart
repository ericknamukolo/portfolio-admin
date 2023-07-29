import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_admin/providers/skills.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../constants/text.dart';
import '../../widgets/custom_loading_indicator.dart';
import '../../widgets/custom_toast.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/skills/skill_card.dart';

class SkillsNavScreen extends StatefulWidget {
  const SkillsNavScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SkillsNavScreen> createState() => _SkillsNavScreenState();
}

class _SkillsNavScreenState extends State<SkillsNavScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() => _isLoading = true);
      try {
        await Provider.of<Skills>(context, listen: false).fetchSkills();

        setState(() => _isLoading = false);
      } catch (e) {
        Toast.showToast(message: e.toString(), type: ToastType.error);
        setState(() => _isLoading = false);
      }
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CustomLoading()
        : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 15),
              child: Consumer<Skills>(
                builder: (context, skills, _) => Column(
                  children: [
                    ScreenTitle(
                        data: skills.skills.length.toString(), title: 'Skills'),
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          Divider(color: kGreyColor),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        skills.skills.sort((a, b) => a.date.compareTo(b.date));
                        return SkillCard(skill: skills.skills[index]);
                      }),
                      itemCount: skills.skills.length,
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
