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
    yield* event.map(

      emailChanged: (e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.email),
          authFailureOrSuccessOption: none() // Reset the response event with a safe null
        );
      }, 

      passwordChanged: (e) async* {
        yield state.copyWith(
          password: Password(e.password),
          authFailureOrSuccessOption: none()
        );
      }, 

      registerWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(_authFacade.registerWithEmailAndPassword);
      }, 

      signInWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(_authFacade.signInWithEmailAndPassword);
      },

      signInWithGooglePressed: (e) async* {
        yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none()
        );
        final failureOrSuccess = await _authFacade.signInWithGoogle();
        yield state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess)
        );
      });
  }

  /// Helper methot to avoid code duplication
  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function({
      @required EmailAddress emailAddress, 
      @required Password password
    }) forwardedCallFunction
  ) async* {
      
      Either<AuthFailure, Unit> failureOrSuccess;

      final isEmailValid = state.emailAddress.isValid();
      final isPasswordValid = state.password.isValid();
      
      if (isEmailValid && isPasswordValid) {
        
        yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none()
        );

        failureOrSuccess = await forwardedCallFunction(
            emailAddress: state.emailAddress, 
            password: state.password
          );
      }

      yield state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption: optionOf(failureOrSuccess)
      );
  }
}
