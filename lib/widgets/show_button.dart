// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungsuwatproj/utility/my_constant.dart';
import 'package:ungsuwatproj/widgets/show_text.dart';

class ShowButton extends StatelessWidget {
  final String label;
  final Function() pressFunc;
  const ShowButton({
    Key? key,
    required this.label,
    required this.pressFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: MyConstant.primary),
          onPressed: pressFunc,
          child: ShowText(
            text: label,
            textStyle: MyConstant().h3WhiteStyle(),
          )),
    );
  }
}
