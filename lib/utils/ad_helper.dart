import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    // tes
    // if (Platform.isAndroid) {
    //   return 'ca-app-pub-3940256099942544/6300978111';
    // } else if (Platform.isIOS) {
    //   return 'ca-app-pub-3940256099942544/2934735716';
    // } else {
    //   throw UnsupportedError('Unsupported platform');
    // }
    // ori
    if (Platform.isAndroid) {
      return 'ca-app-pub-8720658881637782/2198131739';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8720658881637782/2476391383';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

// static String get interstitialAdUnitId {
//   if (Platform.isAndroid) {
//     return '<YOUR_ANDROID_INTERSTITIAL_AD_UNIT_ID>';
//   } else if (Platform.isIOS) {
//     return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
//   } else {
//     throw UnsupportedError('Unsupported platform');
//   }
// }
//
// static String get rewardedAdUnitId {
//   if (Platform.isAndroid) {
//     return '<YOUR_ANDROID_REWARDED_AD_UNIT_ID>';
//   } else if (Platform.isIOS) {
//     return '<YOUR_IOS_REWARDED_AD_UNIT_ID>';
//   } else {
//     throw UnsupportedError('Unsupported platform');
//   }
// }
}
