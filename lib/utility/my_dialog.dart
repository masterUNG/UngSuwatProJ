// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungsuwatproj/utility/my_constant.dart';
import 'package:ungsuwatproj/widgets/show_image.dart';
import 'package:ungsuwatproj/widgets/show_text.dart';
import 'package:ungsuwatproj/widgets/show_text_button.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> normalDialog({
    required String title,
    required String subTitle,
    String? label1,
    String? label2,
    Function()? pressFunc1,
    Function()? pressFunc2,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: const SizedBox(
            width: 80,
            child: ShowImage(
              path: 'images/account.png',
            ),
          ),
          title: ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(text: subTitle),
        ),
        actions: [
          (label1 != null) && (pressFunc1 != null)
              ? ShowTextButton(label: label1, pressFunc: pressFunc1)
              : const SizedBox(),
          (label2 != null) && (pressFunc2 != null)
              ? ShowTextButton(label: label2, pressFunc: pressFunc2)
              : const SizedBox(),
          ShowTextButton(
            label: 'Cancel',
            pressFunc: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
