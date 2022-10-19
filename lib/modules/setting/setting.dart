// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:eshhenily/shared/components/components.dart';
import 'package:eshhenily/shared/cubit/cubit.dart';
import 'package:eshhenily/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Settings',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            defaultButton(
              restartDialogToDefault: true,
              type: '',
              title: 'reset to default',
              context: context,
            ),
            Spacer(),
            TextButton(onPressed: (){
              launch('https://www.linkedin.com/in/kamal-ayman/');
            }, child: const Text('Click here to visit my account.', style: TextStyle(fontSize: 18),)),
            Text(
              'Made by kamal ayman\nphone number : 01201250706',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),

          ],
        ),
      ),
    );
  }
}
