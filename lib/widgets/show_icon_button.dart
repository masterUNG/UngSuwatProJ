// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungsuwatproj/utility/my_constant.dart';

class ShowIconButton extends StatelessWidget {
  final IconData iconData;
  final Function() tapFunc;
  const ShowIconButton({
    Key? key,
    required this.iconData,
    required this.tapFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: tapFunc,
      icon: Icon(
        iconData,
        color: MyConstant.active,
      ),
    );
  }
}
