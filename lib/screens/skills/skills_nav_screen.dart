import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_admin/providers/skills.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/text.dart';
import '../../widgets/custom_toast.dart';
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
        BotToast.showCustomNotification(
            duration: Duration(seconds: 5),
            toastBuilder: (context) =>
                CustomToast(message: e.toString(), type: 'error'));
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
        ? Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: kPrimaryColor, size: 50.0),
          )
        : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 15),
              child: Consumer<Skills>(
                builder: (context, skills, _) => Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff000000).withOpacity(0.12),
                            blurRadius: 6.0,
                            offset: const Offset(0.0, 3.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Skills', style: kTitleTextStyle),
                          SizedBox(height: 5),
                          Text(skills.skills.length.toString(),
                              style: kTitleTextStyle),
                        ],
                      ),
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
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
