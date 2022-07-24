import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ungsuwatproj/states/create_account.dart';
import 'package:ungsuwatproj/utility/my_constant.dart';
import 'package:ungsuwatproj/widgets/show_button.dart';
import 'package:ungsuwatproj/widgets/show_form.dart';
import 'package:ungsuwatproj/widgets/show_image.dart';
import 'package:ungsuwatproj/widgets/show_text.dart';
import 'package:ungsuwatproj/widgets/show_text_button.dart';

class Authen extends StatelessWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return Container(
          decoration: MyConstant().bgMainBox(),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
            behavior: HitTestBehavior.opaque,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newHead(boxConstraints),
                  newContent(
                    boxConstraints,
                    widget: ShowForm(
                      hint: 'Email:',
                      iconData: Icons.email_outlined,
                      changeFunc: (String value) {},
                      inputType: TextInputType.emailAddress,
                    ),
                  ),
                  newContent(
                    boxConstraints,
                    widget: ShowForm(
                      hint: 'Password:',
                      iconData: Icons.lock_outline,
                      changeFunc: (String value) {},
                      obSecu: true,
                    ),
                  ),
                  newContent(
                    boxConstraints,
                    widget: ShowButton(
                      label: 'Login',
                      pressFunc: () {},
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ShowText(text: 'No Accont ? '),
                      ShowTextButton(
                        label: 'Create Account',
                        pressFunc: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccount(),));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  SizedBox newContent(BoxConstraints boxConstraints, {required Widget widget}) {
    return SizedBox(
      width: boxConstraints.maxWidth * 0.6,
      child: widget,
    );
  }

  SizedBox newHead(BoxConstraints boxConstraints) {
    return SizedBox(
      width: boxConstraints.maxWidth * 0.6,
      child: Row(
        children: [
          newLogo(boxConstraints),
          ShowText(
            text: 'Login:',
            textStyle: MyConstant().h1Style(),
          ),
        ],
      ),
    );
  }

  Container newLogo(BoxConstraints boxConstraints) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: boxConstraints.maxWidth * 0.1,
      child: const ShowImage(),
    );
  }
}
