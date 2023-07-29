import 'constants.dart';
class AdUnits {
  static String interTestAd = 'ca-app-pub-3940256099942544/1033173712';
  static String appOpenTestAd = 'ca-app-pub-3940256099942544/3419835294';
  static String interWorkAd = devMode ? interTestAd : 'ca-app-pub-4667865994695089/4024750159';
  static String interNotiAd = devMode ? interTestAd : 'ca-app-pub-4667865994695089/5638318379';
  static String appOpen = devMode ? appOpenTestAd : 'ca-app-pub-4667865994695089/7159283607';
}
