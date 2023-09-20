import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/common/values/constant.dart';
import 'package:iwipe/pages/profile/Settings/bloc/settingsBloc.dart';
import 'package:iwipe/pages/profile/Settings/bloc/settingsState.dart';
import 'package:iwipe/pages/profile/Settings/widget/setingWidget.dart';

import '../../../global.dart';
import '../../App/bloc/appBlocs.dart';
import '../../App/bloc/appEvent.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  void logOut() {
    context.read<AppBloc>().add(TriggerAppEvent(0));
    Global.storageService.remove(AppConstant.STORAGE_USER_TOKEN_KEY);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppbar(),
      body: SingleChildScrollView(child:
          BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        return Container(
          child: Column(
            children: [
              SettingBTN(context, logOut),
            ],
          ),
        );
      })),
    );
  }
}
