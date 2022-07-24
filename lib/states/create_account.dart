// ignore_for_file: avoid_print, sort_child_properties_last

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungsuwatproj/models/amp_model.dart';
import 'package:ungsuwatproj/models/distric_model.dart';
import 'package:ungsuwatproj/models/province_model.dart';
import 'package:ungsuwatproj/utility/my_constant.dart';
import 'package:ungsuwatproj/utility/my_dialog.dart';
import 'package:ungsuwatproj/widgets/show_form.dart';
import 'package:ungsuwatproj/widgets/show_icon_button.dart';
import 'package:ungsuwatproj/widgets/show_image.dart';
import 'package:ungsuwatproj/widgets/show_progress.dart';
import 'package:ungsuwatproj/widgets/show_text.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  File? file;

  var provinceModels = <ProvinceModel>[];
  ProvinceModel? chooseProvinceModel;

  var ampModels = <AmpModel>[];
  AmpModel? chooseAmpModel;

  var districModels = <DistricModel>[];
  DistricModel? districModel;

  double? lat, lng;

  @override
  void initState() {
    super.initState();
    readAllProvince();
    allowLocation();
  }

  Future<void> allowLocation() async {
    bool locationServiceEnable;
    LocationPermission locationPermission;

    locationServiceEnable = await Geolocator.isLocationServiceEnabled();
    if (locationServiceEnable) {
      // Open Location Service
      locationPermission = await Geolocator.checkPermission();
      //เช็คว่า ไม่อนุญาติไหม ?
      if (locationPermission == LocationPermission.deniedForever) {
        MyDialog(context: context).normalDialog(
            label2: 'ExitApp',
            pressFunc2: () {
              exit(0);
            },
            title: 'ไม่อนุญาติแสดงพิกัด',
            subTitle: 'กรุณาอนุญาติแสดงพิกัดด้วย คะ');
      }

      if (locationPermission == LocationPermission.denied) {
        // ยังไม่รู้ว่าจะอนุญาติหรือไม่

        locationPermission = await Geolocator.requestPermission();
        if ((locationPermission != LocationPermission.always) &&
            (locationPermission != LocationPermission.whileInUse)) {
          //ไม่่อนุญาติ
          MyDialog(context: context).normalDialog(
              label2: 'ExitApp',
              pressFunc2: () {
                exit(0);
              },
              title: 'ไม่อนุญาติแสดงพิกัด',
              subTitle: 'กรุณาอนุญาติแสดงพิกัดด้วย คะ');
        } else {
          // อนุญาติ
          findLatLng();
        }
      } else {
        // อนุญาต ตลอดไป หรือ บางครั้ง
        findLatLng();
      }
    } else {
      // Off Location Service
      MyDialog(context: context).normalDialog(
          label2: 'Goto OpenService',
          pressFunc2: () {
            exit(0);
          },
          title: 'Off Location Service',
          subTitle: 'กรุณาเปิด Location Service ด้วย คะ');
    }
  }

  Future<void> findLatLng() async {
    Position position = await findPosition();
    setState(() {
      lat = position.latitude;
      lng = position.longitude;
      print('lat = $lat, lng = $lng');
    });
  }

  Future<Position> findPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  Future<void> readDistricWhereIdAmp({required String idAmp}) async {
    if (districModels.isNotEmpty) {
      districModels.clear();
      districModel = null;
    }

    String pathApiDistric =
        'https://www.androidthai.in.th/flutter/getDistriceByAmphure.php?isAdd=true&amphure_id=$idAmp';
    await Dio().get(pathApiDistric).then((value) {
      // print('ตำบล ==> $value');
      for (var element in json.decode(value.data)) {
        DistricModel districModel = DistricModel.fromMap(element);
        districModels.add(districModel);
      }
      setState(() {});
    });
  }

  Future<void> readAmpWhrerIdProvince({required String idProvince}) async {
    if (ampModels.isNotEmpty) {
      ampModels.clear();
      chooseAmpModel = null;
    }

    String pathApiAmp =
        'https://www.androidthai.in.th/flutter/getAmpByProvince.php?isAdd=true&province_id=$idProvince';
    await Dio().get(pathApiAmp).then((value) {
      // print('value อำเภอ ===>> $value');
      for (var element in json.decode(value.data)) {
        AmpModel ampModel = AmpModel.fromMap(element);
        ampModels.add(ampModel);
      }
      setState(() {});
    });
  }

  Future<void> readAllProvince() async {
    String pathApiProvince =
        'https://www.androidthai.in.th/flutter/getAllprovinces.php';
    await Dio().get(pathApiProvince).then((value) {
      // print('value province ==> $value');
      for (var element in json.decode(value.data)) {
        ProvinceModel provinceModel = ProvinceModel.fromMap(element);
        provinceModels.add(provinceModel);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: newAppBar(),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return ListView(
          children: [
            newImage(boxConstraints, context: context),
            makeCenter(
              boxConstraints,
              widget: ShowForm(
                hint: 'ชื่อ:',
                iconData: Icons.fingerprint,
                changeFunc: (p0) {},
              ),
            ),
            makeCenter(
              boxConstraints,
              widget: ShowForm(
                hint: 'บ้านเลขที่:',
                iconData: Icons.home_outlined,
                changeFunc: (p0) {},
              ),
            ),
            makeCenter(
              boxConstraints,
              size: boxConstraints.maxWidth * 0.9,
              widget: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4)),
                child: provinceModels.isEmpty
                    ? const ShowProgress()
                    : Column(
                        children: [
                          DropdownButton<dynamic>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            hint: ShowText(
                              text: 'โปรดเลือกจังหวัด',
                              textStyle: MyConstant().h3lightStyle(),
                            ),
                            value: chooseProvinceModel,
                            items: provinceModels
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: ShowText(text: e.name_th),
                                    value: e,
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                chooseProvinceModel = value;
                                readAmpWhrerIdProvince(
                                    idProvince: chooseProvinceModel!.id);
                              });
                            },
                          ),
                          chooseProvinceModel == null
                              ? const SizedBox()
                              : ampModels.isEmpty
                                  ? const ShowProgress()
                                  : DropdownButton<dynamic>(
                                      hint: ShowText(
                                        text: 'โปรดเลือกอำเภอ',
                                        textStyle: MyConstant().h3lightStyle(),
                                      ),
                                      value: chooseAmpModel,
                                      items: ampModels
                                          .map(
                                            (e) => DropdownMenuItem(
                                              child: ShowText(text: e.name_th),
                                              value: e,
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          chooseAmpModel = value;
                                          readDistricWhereIdAmp(
                                              idAmp: chooseAmpModel!.id);
                                        });
                                      },
                                    ),
                          chooseAmpModel == null
                              ? const SizedBox()
                              : districModels.isEmpty
                                  ? const ShowProgress()
                                  : DropdownButton<dynamic>(
                                      hint: ShowText(
                                        text: 'โปรดเลือกตำบล',
                                        textStyle: MyConstant().h3lightStyle(),
                                      ),
                                      value: districModel,
                                      items: districModels
                                          .map(
                                            (e) => DropdownMenuItem(
                                              child: ShowText(
                                                  text:
                                                      '${e.name_th} (${e.zip_code})'),
                                              value: e,
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          districModel = value;
                                        });
                                      },
                                    ),
                        ],
                      ),
              ),
            ),
            makeCenter(
              boxConstraints,
              widget: ShowForm(
                hint: 'Email:',
                iconData: Icons.email_outlined,
                changeFunc: (p0) {},
              ),
            ),
            makeCenter(
              boxConstraints,
              widget: ShowForm(
                hint: 'Password:',
                iconData: Icons.lock_outline,
                changeFunc: (p0) {},
              ),
            ),
            // makeCenter(
            //   boxConstraints,
            //   size: boxConstraints.maxWidth * 0.9,
            //   widget: Container(
            //     margin: const EdgeInsets.symmetric(vertical: 16),
            //     decoration: BoxDecoration(
            //         border: Border.all(),
            //         borderRadius: BorderRadius.circular(4)),
            //     height: boxConstraints.maxWidth * 0.9,
            //     child: lat == null
            //         ? const ShowProgress()
            //         : GoogleMap(
            //             initialCameraPosition: CameraPosition(
            //               target: LatLng(lat!, lng!),
            //               zoom: 16,
            //             ),
            //             onMapCreated: (controller) {},
            //           ),
            //   ),
            // ),
          ],
        );
      }),
    );
  }

  Row makeCenter(BoxConstraints boxConstraints,
      {required Widget widget, double? size}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size ?? boxConstraints.maxWidth * 0.6,
          child: widget,
        ),
      ],
    );
  }

  Row newImage(BoxConstraints boxConstraints, {required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          width: boxConstraints.maxWidth * 0.6,
          height: boxConstraints.maxWidth * 0.6,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: file == null
                    ? ShowImage(path: 'images/account.png')
                    : CircleAvatar(
                        radius: boxConstraints.maxWidth * 0.3,
                        backgroundImage: FileImage(file!),
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: ShowIconButton(
                  iconData: Icons.add_a_photo_outlined,
                  tapFunc: () {
                    MyDialog(context: context).normalDialog(
                        label1: 'Camera',
                        pressFunc1: () {
                          Navigator.pop(context);
                          processTakePhoto(source: ImageSource.camera);
                        },
                        label2: 'Gallery',
                        pressFunc2: () {
                          Navigator.pop(context);
                          processTakePhoto(source: ImageSource.gallery);
                        },
                        title: 'แหล่งกำเนิดภาพ ?',
                        subTitle: 'กรุณา Tap Camera หรือ Gallery');
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  AppBar newAppBar() {
    return AppBar(
      centerTitle: true,
      title: ShowText(
        text: 'Create New Account',
        textStyle: MyConstant().h2Style(),
      ),
      elevation: 0,
      foregroundColor: MyConstant.dark,
      backgroundColor: Colors.white,
    );
  }

  Future<void> processTakePhoto({required ImageSource source}) async {
    print('processWork');
    var result = await ImagePicker().pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (result != null) {
      setState(() {
        file = File(result.path);
      });
    }
  }
}
