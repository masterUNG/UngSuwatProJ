// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ungsuwatproj/utility/my_constant.dart';

class ShowForm extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final Function(String) changeFunc;
  final bool? obSecu;
  final TextInputType? inputType;
  const ShowForm({
    Key? key,
    required this.hint,
    required this.iconData,
    required this.changeFunc,
    this.obSecu,
    this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(top: 16),
      child: TextFormField(
        keyboardType: inputType ?? TextInputType.text,
        obscureText: obSecu ?? false,
        onChanged: changeFunc,
        style: MyConstant().h3Style(),
        decoration: InputDecoration(fillColor: Colors.white.withOpacity(0.75),
          filled: true,
          suffixIcon: Icon(
            iconData,
            color: MyConstant.dark,
          ),
          hintText: hint,
          hintStyle: MyConstant().h3lightStyle(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.dark),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.light),
          ),
        ),
      ),
    );
  }
}
