// ignore_for_file: use_key_in_widget_constructors

import 'package:eshhenily/shared/components/components.dart';
import 'package:eshhenily/shared/cubit/cubit.dart';
import 'package:eshhenily/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VodafoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'Vodafone'),
      body: defaultPage(
        context: context,
        items: [
          [
            'رصيد - كارت فكة\n# كود الشحن * 858 *',
            '*858*',
          ],
          [
            'دقائق لشبكة فودافون \n# كود الشحن * 1 * 858 *',
            '*858*1*',
          ],
          [
            'فليكسات\n# كود الشحن * 2 * 858 *',
            '*858*2*',
          ],
        ],
        img: 'assets/img/vodafone.png',
      ),
    );
  }
}
