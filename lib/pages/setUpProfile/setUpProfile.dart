import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/pages/setUpProfile/setUpProfileController.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwipe/pages/setUpProfile/setUpProfileWidget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/values/colors.dart';
import '../commonWidget.dart';
import 'bloc/setUpProfileBloc.dart';
import 'bloc/setUpProfileevent.dart';
import 'bloc/setUpProfilestate.dart';

class SetUpProfile extends StatefulWidget {
  const SetUpProfile({Key? key}) : super(key: key);

  @override
  State<SetUpProfile> createState() => _setUpProfileState();
}

class _setUpProfileState extends State<SetUpProfile> {
  String? selectedImagePath;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImagePath = image.path;
      });
    }
  }

  Future<void> _requestPermission() async {
    PermissionStatus? readStatus;

    if (Platform.isIOS) {
      readStatus = await Permission.photos.request();
    } else if (Platform.isAndroid) {
      readStatus = await Permission.storage.request();
    }

    if (readStatus?.isGranted == true) {
      _pickImage();
    } else if (readStatus?.isDenied == true ||
        readStatus?.isPermanentlyDenied == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Permissions error'),
                content:
                    Text('Please enable permissions from settings to continue'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: Text('Open Settings'),
                    onPressed: () {
                      openAppSettings();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    //Restrieve data from Register page
    final Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final String username = args['username']!;
    final String email = args['email']!;
    final String password = args['password']!;

    return BlocBuilder<SetupProfileBloc, SetUpProfileState>(
        builder: (context, state) {
      return Stack(children: [
        Container(
          color: const Color.fromRGBO(241, 241, 241, 1),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Color.fromRGBO(241, 241, 241, 1),
              appBar: buildAppBar("Register"),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          child: reusableText(
                              "Enter details to complete create an account")),
                    ),
                    GestureDetector(
                      onTap: () {
                        _requestPermission();
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          child: Center(
                            child: Container(
                              width: 130.w,
                              height: 130.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                image: DecorationImage(
                                  image: selectedImagePath != null
                                      ? FileImage(File(selectedImagePath!))
                                          as ImageProvider<Object>
                                      : AssetImage("assets/icons/headpic.png")
                                          as ImageProvider<Object>,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 6.w),
                                  child: Container(
                                    width: 25.w,
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryElement,
                                      // Setting red background color
                                      borderRadius: BorderRadius.circular(5.w),
                                    ),
                                    child: Image(
                                      image:
                                          AssetImage("assets/icons/edit 2.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20.h),
                        padding: EdgeInsets.only(left: 25.w, right: 25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reusableText("First Name"),
                            buildTextField(
                                "Enter Your First name", "firstName", "user",
                                (value) {
                              context
                                  .read<SetupProfileBloc>()
                                  .add(RegisterFirstnameChanged(value));
                            }),
                            reusableText("Last Name"),
                            buildTextField(
                                "Enter Your Last Name", "lastName", "user",
                                (value) {
                              context
                                  .read<SetupProfileBloc>()
                                  .add(RegisterLastNameChanged(value));
                            }),
                          ],
                        )),
                    buildButton("Next", true, () {
                      SetUpProfileController(context: context).handleEmailReg(
                          username, email, password, selectedImagePath,
                          (bool value) {
                        setState(() {
                          isLoading = value;
                        });
                      }, () => mounted);
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
        isLoading ? buildLoadingIndicator() : Container(),
      ]);
    });
  }
}
