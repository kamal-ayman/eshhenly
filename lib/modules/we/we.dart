import 'package:eshhenily/shared/components/components.dart';
import 'package:eshhenily/shared/cubit/cubit.dart';
import 'package:eshhenily/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'We Page',
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
            title: [
              'رصيد - كارت فكة\n# كود الشحن * 555 *',
              'إنترنت فقط\n# كود الشحن * 599 *',
              'وحدات فقط\n# كود الشحن * 566 *',
            ],
            cubit: cubit,
            type: [
              '*555*',
              '*599*',
              '*566*',
            ],
            img: 'assets/img/we.png', state: state,
          ),
        );
      },
    );
  }
}
