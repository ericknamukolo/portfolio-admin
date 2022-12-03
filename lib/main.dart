import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const Amour());
}

class Amour extends StatelessWidget {
  const Amour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => Discover()),
        // ChangeNotifierProvider(create: (context) => Profile()),
        // ChangeNotifierProvider(create: (context) => Crushes()),
        // ChangeNotifierProvider(create: (context) => NotiState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amor',
        theme: ThemeData(
          fontFamily: 'Montserrat',
        ),
        // builder: BotToastInit(),
        // navigatorObservers: [
        //   BotToastNavigatorObserver(),
        // ],
        // onGenerateRoute: generateRoute,
      ),
    );
  }
}
