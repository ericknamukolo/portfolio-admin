import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portfolio_admin/constants/text.dart';
import 'package:portfolio_admin/providers/auth.dart';
import 'package:portfolio_admin/widgets/cutsom_app_bar.dart';

import '../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

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
    SizedBox(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: getAppBarName(),
          action: IconButton(
              onPressed: () => Auth.signOut(context: context),
              icon: Icon(Icons.logout_rounded))),
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
