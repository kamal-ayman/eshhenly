import 'package:eshhenily/shared/cubit/cubit.dart';
import 'package:eshhenily/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../ad_helper.dart';

void navigatorTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Future<void> showMyDialog(
    {required context, required type, required cubit}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Option'),
        content: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ListBody(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: [
                    defaultSelectButton(
                        icon: Icons.photo_camera_outlined,
                        cubit: cubit,
                        title: 'Camera',
                        id: 0),
                    defaultSelectButton(
                        icon: Icons.photo_outlined,
                        cubit: cubit,
                        title: 'Image',
                        id: 1),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('once'),
            onPressed: () {
              cubit.getImage(type: type);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('always'),
            onPressed: () {
              cubit.setAlways(cubit.last);
              cubit.getImage(type: type);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget defaultSelectButton({
  required AppCubit cubit,
  required String title,
  required IconData icon,
  required int id,
}) =>
    InkWell(
      onTap: () {
        cubit.selectButtonDialog(id: id);
      },
      child: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: cubit.select[id] == true ? Colors.blue : Colors.white,
              ),
              duration: Duration(milliseconds: 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon,
                      color:
                          cubit.select[id] == true ? Colors.white : Colors.grey,
                      size: 50),
                  SizedBox(width: 30),
                  Text(
                    title,
                    style: TextStyle(
                        color: cubit.select[id] == true
                            ? Colors.white
                            : Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget defaultPage({
  required context,
  required String img,
  required List<List<String>> items,
}) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  img,
                  width: 200,
                  height: 200,
                ),
              ],
            ),
            SizedBox(height: 20),
            for (int i = 0; i < items.length; i++)
              defaultButton(
                title: items[i][0],
                type: items[i][1],
                context: context,
              ),
          ],
        ),
        Center(
          child: Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                AppCubit.get(context).state is LoadingState,
            widgetBuilder: (context) =>
                Center(child: CircularProgressIndicator()),
            fallbackBuilder: (context) => Row(),
          ),
        ),

      ],
    ),
  );
}

Widget defaultButton({
  required context,
  required String title,
  required String type,
  bool restartDialogToDefault = false,
}) {
  var cubit = AppCubit.get(context);
  double _w = MediaQuery.of(context).size.width;

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
      onTap: () {
        if (restartDialogToDefault) {
          ShowToast('reset successfully', Colors.green);
          cubit.restartDialog();
        } else if (cubit.always != -1) {
          cubit.getImage(type: type);
        } else {
          showMyDialog(context: context, type: type, cubit: cubit);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            height: _w / 4,
            width: _w / 1,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff040039).withOpacity(.15),
                  blurRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(.6),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

ShowToast(msg, color) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );

AppBar CustomAppBar({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
    title: Text(
      '$title Page',
      style: TextStyle(
          color: Colors.black.withOpacity(.7),
          fontWeight: FontWeight.w600,
          letterSpacing: 1),
    ),
    leading: IconButton(
      splashColor: Colors.transparent,
      splashRadius: 20,
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black.withOpacity(.8),
      ),
      onPressed: () => Navigator.pop(context),
    ),
  );
}

// class GetAdClass {
//   InterstitialAd? interstitialAd;
//   RewardedAd? rewardedAd;
//
//   void getAd(context) {
//     var cubit = AppCubit.get(context);
//     RewardedAd.load(
//       adUnitId: AdHelper.rewardedAdUnitId,
//       request: AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (ad) {
//           ad.fullScreenContentCallback = FullScreenContentCallback(
//             onAdDismissedFullScreenContent: (ad) {
//                 ad.dispose();
//                 cubit.rewardedAd = null;
//                 cubit.loadRewardedAd();
//             },
//           );
//
//
//             cubit.rewardedAd = ad;
//
//         },
//         onAdFailedToLoad: (err) {
//           print('Failed to load a rewarded ad: ${err.message}');
//         },
//       ),
//     );
//
//
//
//   }
// }
