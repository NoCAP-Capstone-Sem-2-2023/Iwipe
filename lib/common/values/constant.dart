import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstant {
  static const String STORAGE_DEVICE_OPEN_FIRST_TIME =
      'STORAGE_DEVICE_OPEN_FIRST_TIME';
  static const String STORAGE_USER_PROFILE = 'STORAGE_USER_PROFILE';
  static const String STORAGE_USER_ID = 'USER_ID';
  static String MasterAPITOKEN = dotenv.env['MASTER_API_TOKEN']!;
  static String domain = dotenv.env['DOMAIN']!;
  static String paypalClientId = dotenv.env['paypalClientId']!;
  static String paypalSecret = dotenv.env['paypalSecret']!;
  static String courseID = '3';
  static String roleID = '5';
}
