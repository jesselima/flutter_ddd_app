part of 'sign_in_form_bloc.dart';

@freezed
abstract class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    @required EmailAddress emailAddress,
    @required Password password,
    @required bool showErrorMessages,
    @required bool isSubmitting,
    @required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,

  }) = _SignInFormState;

  // Factory for the initial state
  factory SignInFormState.initial() => SignInFormState(
      emailAddress: null, 
      password: null, 
      showErrorMessages: null, 
      isSubmitting: null, 
      authFailureOrSuccessOption: null
    );

}