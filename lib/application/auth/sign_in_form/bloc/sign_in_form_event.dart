part of 'sign_in_form_bloc.dart';


@freezed
abstract class SignInFormEvent with _$SignInFormEvent {
  
  const factory SignInFormEvent.emailChanged(String email) = EmailChanged; 
  const factory SignInFormEvent.passwordChanged(String password) = PasswordChanged; 

  const factory SignInFormEvent.registerWithEmailAndPasswordPressed(String password) = 
    RegisterWithEmailAndPasswordPressed; 
  
  const factory SignInFormEvent.signInWithEmailAndPasswordPressed(String password) = 
    SignInWithEmailAndPasswordPressed; 
  
  const factory SignInFormEvent.signInWithGooglePressed(String password) = 
    RegisterWithEmailAndPasswordPressed; 
}
