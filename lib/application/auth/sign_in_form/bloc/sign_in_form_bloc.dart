import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutterdddapp/domain/feature/auth/auth_failure.dart';
import 'package:flutterdddapp/domain/feature/auth/i_auth_facade.dart';
import 'package:flutterdddapp/domain/feature/auth/value_objects.dart';
import 'package:meta/meta.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

part 'sign_in_form_bloc.freezed.dart';


class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {

  // We neetd the AuthFacade inside the Bloc. The Bloc constuctor must to recieve this.
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade);


  @override
  SignInFormState get initialState => SignInFormState.initial();

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
