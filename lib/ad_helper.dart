const bool test = true;

class AdHelper {
  static String get rewardedAdUnitId {
    if (test) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else {
      return 'ca-app-pub-7136012509023664/4549260388';
    }
  }

  static String get interstitialAdUnitId{
    if (test){
      return 'ca-app-pub-3940256099942544/1033173712';
    }else{
      return 'ca-app-pub-7136012509023664/9467341304';
    }
  }
}
