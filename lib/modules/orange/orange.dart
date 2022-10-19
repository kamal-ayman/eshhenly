// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:eshhenily/shared/components/components.dart';
import 'package:eshhenily/shared/cubit/cubit.dart';
import 'package:eshhenily/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrangeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'Orange'),
      body: defaultPage(
        context: context,
        items: [
          [
            'رصيد - كارت فكة\n# كود الشحن * 102 #',
            '#102*',
          ],
          [
            'وحدات لكل الشبكات\n# كود الشحن 1 * 102 #',
            '#102*1*',
          ],
          [
            'ميجابايتس\n# كود الشحن * 2 * 102 #',
            '#102*2*',
          ]
        ],
        img: 'assets/img/orange.png',
      ),
    );
  }
}
