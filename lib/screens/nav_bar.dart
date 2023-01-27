import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portfolio_admin/constants/text.dart';
import 'package:portfolio_admin/providers/auth.dart';
import 'package:portfolio_admin/screens/skills/add_skill_screen.dart';
import 'package:portfolio_admin/screens/home/home_nav_screen.dart';
import 'package:portfolio_admin/widgets/cutsom_app_bar.dart';
import '../constants/colors.dart';
import 'messages/message_nav_screen.dart';
import 'projects/add_project_screen.dart';
import 'skills/skills_nav_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  final bool newMessageNotifcation;
  const HomeScreen({this.newMessageNotifcation = false, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  String getAppBarName() {
    String name = '';
    if (_selectedIndex == 0) {
      name = 'Home';
    } else if (_selectedIndex == 1) {
      name = 'Messages';
    } else if (_selectedIndex == 2) {
      name = 'Skills';
    } else {
      name = 'Projects';
    }
    return name;
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeNavScreen(),
    MessageNavScreen(),
    SkillsNavScreen(),
    SizedBox(),
  ];

  @override
  void initState() {
    //   PushNotification.inititialize(context);
    if (widget.newMessageNotifcation) {
      _selectedIndex = 1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedIndex == 2 || _selectedIndex == 3
          ? FloatingActionButton(
              backgroundColor: kSecondaryColor,
              onPressed: () {
                if (_selectedIndex == 2) {
                  Navigator.of(context).pushNamed(AddSkillScreen.routeName);
                } else if (_selectedIndex == 3) {
                  Navigator.of(context).pushNamed(AddProjectScreen.routeName);
                }
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      appBar: CustomAppBar(
          title: getAppBarName(),
          showNotification: true,
          showLeading: true,
          action: IconButton(
              onPressed: () => Auth.signOut(context: context),
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ))),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: GNav(
            textStyle: kBodyTextStyleGrey.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: kPrimaryColor,
            iconSize: 20,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: kSecondaryColor,
            tabs: [
              GButton(
                icon: Iconsax.home5,
                text: 'Home',
              ),
              GButton(
                icon: Iconsax.message5,
                text: 'Messages',
              ),
              GButton(
                icon: Iconsax.code_15,
                text: 'Skills',
              ),
              GButton(
                icon: Iconsax.mobile_programming5,
                text: 'Projects',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
