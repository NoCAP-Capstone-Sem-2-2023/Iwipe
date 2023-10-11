import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/values/constant.dart';
import '../../global.dart';
import '../commonWidget.dart';

class IDValidationPage extends StatefulWidget {
  @override
  _IDValidationPageState createState() => _IDValidationPageState();
}

class _IDValidationPageState extends State<IDValidationPage> {
  String? selectedIDType;
  File? selectedImage;
  bool isLoading = false;
  SharedPreferences? _sharedPreferences;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
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
          content: Text('Please enable permissions from settings to continue'),
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
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });

    String? userId = Global.storageService.getUserID();

    String? downloadURL;
    if (selectedImage != null) {
      File file = selectedImage!;
      try {
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref('IDCapture/$userId/image')
            .putFile(file);

        downloadURL = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print("Failed to upload image: $e");
      }
    }
    if (downloadURL != null && userId != null) {
      await updateIDValidation(userId, downloadURL, selectedIDType);
      updateLocalIDValidation(downloadURL, selectedIDType);
    } else {
      print("Download URL or User ID is null");
    }

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context, true);
  }

  Future<void> updateIDValidation(
      String userId, String idValidationUrl, String? selectedIDType) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(userId).update({
        'IDValidation': selectedIDType,
        'documentLink': idValidationUrl,
      });
    } catch (e) {
      print("Failed to update IDValidation in Firestore: $e");
    }
  }

  Future<void> updateLocalIDValidation(
      String idValidationUrl, String? selectedIDType) async {
    Map<String, dynamic>? userProfile = getUserProfile();
    if (userProfile != null) {
      userProfile['IDValidation'] = selectedIDType;
      userProfile['documentLink'] = idValidationUrl;
      await Global.storageService.setString(
        AppConstant.STORAGE_USER_PROFILE,
        jsonEncode(userProfile),
      );
    }
  }

  Map<String, dynamic>? getUserProfile() {
    Map<String, dynamic>? userProfile = Global.storageService.getUserProfile();
    if (userProfile == null) {
      return null;
    }
    return userProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('ID Validation'),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select ID Type:'),
                  DropdownButton<String>(
                    value: selectedIDType,
                    items: ['Driver License', 'Passport', 'ID Card']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedIDType = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _requestPermission(),
                    child: Text('Capture/Upload Photo'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          height: 200,
                          width: 200,
                        )
                      : Text('No image selected'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _submit(),
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
