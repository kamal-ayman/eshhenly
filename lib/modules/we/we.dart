// ignore_for_file: use_key_in_widget_constructors

import 'package:eshhenily/shared/components/components.dart';
import 'package:eshhenily/shared/cubit/cubit.dart';
import 'package:eshhenily/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'We'),
      body: defaultPage(
        context: context,
        items: [
          [
            'رصيد - كارت فكة\n# كود الشحن * 555 *',
            '*555*',
          ],
          [
            'إنترنت فقط\n# كود الشحن * 599 *',
            '*599*',
          ],
          [
            'وحدات فقط\n# كود الشحن * 566 *',
            '*566*',
          ],
        ],
        img: 'assets/img/we.png',
      ),
    );
  }
}
