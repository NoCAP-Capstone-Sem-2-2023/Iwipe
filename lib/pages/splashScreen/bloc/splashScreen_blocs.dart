import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwipe/pages/splashScreen/bloc/splashScreen_events.dart';
import 'package:iwipe/pages/splashScreen/bloc/splashScreen_states.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenState()) {
    on<SplashScreenEvent>((event, emit) {
      emit(SplashScreenState(page: state.page));
    });
  }
}
