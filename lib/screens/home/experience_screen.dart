import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portfolio_admin/models/work.dart';
import 'package:portfolio_admin/screens/home/add_experience_screen.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../constants/text.dart';
import '../../providers/works.dart';
import '../../widgets/custom_toast.dart';
import '../../widgets/cutsom_app_bar.dart';
import 'package:bot_toast/bot_toast.dart';

import '../../widgets/work/work_card.dart';

class ExperienceScreen extends StatefulWidget {
  static const routeName = '/experience-screen';
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() => _isLoading = true);
      try {
        await Provider.of<Works>(context, listen: false).fetchWorkData();

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
    return Scaffold(
      appBar: CustomAppBar(title: 'Work Experience', showLeading: true),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        onPressed: () =>
            Navigator.of(context).pushNamed(AddExperienceScreen.routeName),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: kPrimaryColor, size: 50.0),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Consumer<Works>(
                  builder: (context, work, _) => Column(
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
                            Text('Work Experience', style: kTitleTextStyle),
                            SizedBox(height: 5),
                            Text(2.toString(), style: kTitleTextStyle),
                          ],
                        ),
                      ),
                      ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          // skills.skills
                          //     .sort((a, b) => a.date.compareTo(b.date));
                          return WorkCard(
                            work: Work(
                              createdDate: DateTime.now().toIso8601String(),
                              isHidden: false,
                              company: 'MTN Zambia',
                              position: 'Accountant',
                              country: 'Zambia',
                              empType: 'Full - Time',
                              state: 'Lusaka',
                              startDate: DateTime.now().toIso8601String(),
                              workDone:
                                  'some stuff#other stuff#even more random stufffbberhgito-0yjh-tjhotht tjt-hnt-0hnth tht0hnth-t0',
                              worksHere: true,
                            ),
                          );
                        }),
                        itemCount: 2,
                        shrinkWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
