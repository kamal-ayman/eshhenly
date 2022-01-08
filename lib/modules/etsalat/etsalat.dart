// ignore_for_file: use_key_in_widget_constructors

import 'package:eshhenily/shared/components/components.dart';
import 'package:eshhenily/shared/cubit/cubit.dart';
import 'package:eshhenily/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EtsalatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Etsalat Page',
              style: TextStyle(
                  color: Colors.black.withOpacity(.7),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black.withOpacity(.8),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: defaultPage(
            context: context,
            items: [
              [
                'رصيد - كارت فكة\n#كود الشحن * 556 *',
                '*556*',
              ],
              [
                'ميكسات\n#كود الشحن * 1 * 556 *',
                '*556*1*',
              ],
              [
                'دقائق\n#كود الشحن * 2 * 556 *',
                '*556*2*',
              ],
              [
                'ميجابايتس\n#كود الشحن * 3 * 556 *',
                '*556*3*',
              ],
              [
                'نت سوشيال\n#كود الشحن * 5 * 556 *',
                '*556*3*',
                '*556*5*',
              ],
              [
                'نت فيديو\n#كود الشحن * 7 * 556 *',
                '*556*7*',
              ],
              [
                'لشحن الكارت مرة أخرى\n#كود الشحن * 332 *',
                '*332*',
              ],
            ],
            cubit: cubit,
            img: 'assets/img/etsalat.png',
            state: state,
          ),
        );
      },
    );
  }
}
