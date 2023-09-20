import 'package:flutter/cupertino.dart';
import 'package:iwipe/common/services/storageService.dart';
import 'package:firebase_core/firebase_core.dart';

class Global{
  static late StorageService storageService;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    storageService = await StorageService().init();
  }
}
