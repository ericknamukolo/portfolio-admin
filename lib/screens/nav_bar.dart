import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portfolio_admin/constants/text.dart';
import 'package:portfolio_admin/providers/auth.dart';
import 'package:portfolio_admin/screens/skills/add_skill_screen.dart';
import 'package:portfolio_admin/screens/home/home_nav_screen.dart';
import 'package:portfolio_admin/widgets/custom_toast.dart';
import 'package:portfolio_admin/widgets/cutsom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/ad_units.dart';
import '../constants/colors.dart';
import '../constants/constants.dart';
import '../services/ad_manager.dart';
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
    if (widget.newMessageNotifcation) {
      _selectedIndex = 1;
    }
    super.initState();
  }

  void showAd(String adUnit) {
    AdManager.loadInterstitialAd(adUnit: adUnit);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menuItems = [
      {
        'name': 'About',
        'icon': Icons.info_outline_rounded,
        'tap': () async {
          Future.delayed(
            Duration.zero,
            () => showDialog(
              context: context,
              builder: (_) => Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('About App', style: kBodyTextStyleGrey),
                      SizedBox(height: 5),
                      Text.rich(
                        style: kBodyTextStyleGrey.copyWith(fontSize: 11),
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    'Portfolio Admin app is an app used to manage my '),
                            TextSpan(
                              text: 'Portfolio website.',
                              style: kBodyTextStyleGrey.copyWith(
                                  color: kPrimaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launchUrl(
                                    Uri.parse('https://ericknamukolo.com'),
                                    mode: LaunchMode.externalApplication),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        child: Text('Privacy Policy',
                            style: kBodyTextStyleGrey.copyWith(
                                color: kPrimaryColor)),
                        onPressed: () async {
                          await launchUrl(
                              Uri.parse(
                                  'https://portfolio-admin-privacy-p0licy.netlify.app'),
                              mode: LaunchMode.externalApplication);
                        },
                      ),
                      Text(
                          '${packageInfo!.appName} v${packageInfo!.version} #${packageInfo!.buildNumber} ${packageInfo!.installerStore ?? ''}',
                          style: kBodyTextStyleGrey.copyWith(fontSize: 9)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      },
      {
        'name': 'Log Out',
        'icon': Icons.logout_rounded,
        'tap': () => Auth.signOut(context: context),
      },
    ];
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
        action: PopupMenuButton(
          color: Colors.white,
          itemBuilder: (_) => menuItems
              .map(
                (data) => PopupMenuItem(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  height: 25,
                  child: Row(
                    children: [
                      Icon(data['icon'], color: kPrimaryColor, size: 20.0),
                      SizedBox(width: 10),
                      Text(
                        data['name'],
                        style: kBodyTextStyleGrey,
                      ),
                    ],
                  ),
                  onTap: data['tap'],
                ),
              )
              .toList(),
          child: IconButton(
            onPressed: null,
            icon: Icon(
              Iconsax.menu_15,
              color: Colors.white,
            ),
          ),
        ),
      ),
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
                onPressed: () => showAd(AdUnits.interTestAd),
              ),
              GButton(
                icon: Iconsax.message5,
                text: 'Messages',
                onPressed: () => showAd(AdUnits.interTestAd),
              ),
              GButton(
                icon: Iconsax.code_15,
                text: 'Skills',
                onPressed: () => showAd(AdUnits.interTestAd),
              ),
              GButton(
                icon: Iconsax.mobile_programming5,
                text: 'Projects',
                onPressed: () => showAd(AdUnits.interTestAd),
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
