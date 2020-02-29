import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/core/validators.dart';
import 'package:flutter_architecture_template/data/datasources/firebase_auth_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart' show DebounceExtensions, MergeExtension;

part 'forgot_event.dart';
part 'forgot_state.dart';

@prod
@injectable
class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {
  final FirebaseAuthDataSource firebaseAuthDataSource;

  ForgotBloc({@required this.firebaseAuthDataSource});

  @override
  ForgotState get initialState => ForgotState.empty();

  @override
  Stream<ForgotState> transformEvents(
    Stream<ForgotEvent> events,
    Stream<ForgotState> Function(ForgotEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<ForgotState> mapEventToState(
    ForgotEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email);
    }
  }

  Stream<ForgotState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<ForgotState> _mapFormSubmittedToState(
    String email,
  ) async* {
    yield ForgotState.loading();
    try {
      await firebaseAuthDataSource.forgotPassword(email);
      yield ForgotState.success();
    } catch (_) {
      yield ForgotState.failure();
    }
  }
}
