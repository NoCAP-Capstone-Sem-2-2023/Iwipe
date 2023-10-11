import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'id_event.dart';
part 'id_state.dart';

class IdBloc extends Bloc<IdEvent, IdState> {
  IdBloc() : super(IdInitial()) {
    on<IdEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
