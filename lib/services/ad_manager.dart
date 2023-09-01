import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:portfolio_admin/constants/ad_units.dart';

import '../constants/constants.dart';
import '../widgets/custom_toast.dart';

class AdManager {
  static void loadInterstitialAd({required String adUnit}) {
    InterstitialAd.load(
      adUnitId: adUnit,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) async {
          InterstitialAd loadedAd = ad;
          await loadedAd.show();
        },
        onAdFailedToLoad: (ad) {
          Toast.showToast(message: ad.message, type: ToastType.error);
        },
      ),
    );
  }

  static void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: AdUnits.appOpen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) async {
        AppOpenAd loadedAd = ad;
        await loadedAd.show();
      }, onAdFailedToLoad: (ad) {
        Toast.showToast(message: ad.message, type: ToastType.error);
      }),
      orientation: AppOpenAd.orientationPortrait,
    );
  }
}
