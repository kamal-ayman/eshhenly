// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:eshhenily/shared/cubit/cubit.dart';
import 'package:eshhenily/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigatorTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Future<void> showMyDialog({
  required context,
  required type,
}) async {
  AppCubit cubit = AppCubit.get(context);
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
              cubit.getCode(type: type);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('always'),
            onPressed: () {
              cubit.setAlways(cubit.last);
              cubit.getCode(type: type);
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
  required AppCubit cubit,
  required String img,
  required List<String> title,
  required List<String> type,
  required state,
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
            for (int i = 0; i < title.length; i++)
              defaultButton(
                  type: type[i],
                  title: title[i],
                  context: context,
                  cubit: cubit,
                  restartDialogToDefault: false),
          ],
        ),

      ],
    ),
  );
}

Widget defaultButton({
  required AppCubit cubit,
  required context,
  required String title,
  required String type,
  required bool restartDialogToDefault,
}) {
  double _w = MediaQuery.of(context).size.width;

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
      onTap: () {
        if (restartDialogToDefault) {
          ShowToast('done restart to default', Colors.green);
          cubit.restartDialog();
        } else if (cubit.always != -1) {
          cubit.getCode(type: type);
        } else {
          showMyDialog(context: context, type: type);
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
                  blurRadius: 99,
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
    timeInSecForIosWeb: 6,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0);
