// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_string_interpolations

import 'package:eshhenily/modules/etsalat/etsalat.dart';
import 'package:eshhenily/modules/orange/orange.dart';
import 'package:eshhenily/modules/setting/setting.dart';
import 'package:eshhenily/modules/vodafone/vodafone.dart';
import 'package:eshhenily/modules/we/we.dart';
import 'package:eshhenily/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:animations/animations.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../ad_helper.dart';
import '../../shared/components/components.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  // final GetAdClass _getAdClass = GetAdClass();
  RewardedAd? _rewardedAd;


  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _rewardedAd = null;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
    // _getAdClass.getAd(context);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: -30, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _controller.forward();
  }

  @override
  void dispose() {
    // _getAdClass.rewardedAd!.dispose();
    // _getAdClass.interstitialAd!.dispose();

    _controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(_w / 17, _w / 20, 0, _w / 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Eshhenly',
                          style: TextStyle(
                            fontSize: 27,
                            color: Colors.black.withOpacity(.6),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.credit_card_outlined,
                          size: 24,
                          color: Colors.black.withOpacity(.5),
                        ),
                      ],
                    ),
                    SizedBox(height: _w / 35),
                    Text(
                      'Choose the type of the phone number.',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              homePageCardsGroup(
                image: 'assets/img/we.png',
                title2: 'Orange',
                context: context,
                title: 'We',
                route2: OrangeScreen(),
                route: WeScreen(),
                image2: 'assets/img/orange.png',
              ),
              homePageCardsGroup(
                context: context,
                title: 'Etsalat',
                image: 'assets/img/etsalat.png',
                route: EtsalatScreen(),
                title2: 'vodafone',
                image2: 'assets/img/vodafone.png',
                route2: VodafoneScreen(),
              ),
              SizedBox(height: _w / 20),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, _w / 9.5, _w / 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SettingScreen();
                        },
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(99)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                      child: Container(
                        height: _w / 8.5,
                        width: _w / 8.5,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.05),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.settings,
                            size: _w / 17,
                            color: Colors.black.withOpacity(.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          blurTheStatusBar(context),

        ],
      ),
    );
  }

  Widget homePageCardsGroup({
    required String title,
    required BuildContext context,
    required Widget route,
    required String title2,
    required Widget route2,
    required String image,
    required String image2,
  }) {
    double _w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: _w / 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          homePageCard(
            context: context,
            title: title,
            image: image,
            route: route,
          ),
          homePageCard(
              context: context, title: title2, image: image2, route: route2),
        ],
      ),
    );
  }

  Widget homePageCard({
    required String title,
    required BuildContext context,
    required Widget route,
    required String image,
  }) {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            _rewardedAd?.show(
              onUserEarnedReward: (_, reward) {
                // HapticFeedback.lightImpact();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return route;
                //     },
                //   ),
                // );
              },
            );

          },
          child: OpenContainer(
            closedBuilder: (_, openContainer) {
              return Container(
                padding: EdgeInsets.all(15),
                height: _w / 2,
                width: _w / 2.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff040039).withOpacity(.15),
                      blurRadius: 99,
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(),
                    Container(
                      height: _w / 5,
                      width: _w / 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset('$image'),
                      ),
                    ),
                    Text(
                      title,
                      maxLines: 4,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(),
                  ],
                ),
              );
            },
            openColor: Colors.white,
            closedElevation: 10.0,
            closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            closedColor: Colors.white,
            openBuilder: (_, closeContainer) {
              _rewardedAd?.show(
                onUserEarnedReward: (_, reward) {
                },
              );

              return route;
            },
          ),
        ),
      ),
    );
  }

  Widget blurTheStatusBar(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
        child: Container(
          height: _w / 18,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
