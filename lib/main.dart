// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unnecessary_null_comparison, deprecated_member_use

import 'package:eshhenily/shared/bloc_observer.dart';
import 'package:eshhenily/shared/cubit/cubit.dart';
import 'package:eshhenily/shared/cubit/states.dart';
import 'package:eshhenily/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  int always = -1;

  always = CacheHelper.getData(key: 'always');
  if (null == always) {
    always = -1;
    await CacheHelper.setData(key: 'always', value: always);
  }
  runApp(HomeCart(always));
}

class HomeCart extends StatelessWidget {
  final int always;

  HomeCart(this.always);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..setAlways(always),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyCustomUI(),
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              elevation: 10,
              centerTitle: true,
              shadowColor: Colors.black.withOpacity(.5),
            ),
          ),
        ),
      ),
    );
  }
}
