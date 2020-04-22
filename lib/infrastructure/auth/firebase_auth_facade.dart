// Native Dependencies
import 'package:dartz/dartz.dart';
// Third Party Dependencies
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
// Aplication Implementations
import 'package:flutterdddapp/domain/feature/auth/auth_failure.dart';
import 'package:flutterdddapp/domain/feature/auth/i_auth_facade.dart';
import 'package:flutterdddapp/domain/feature/auth/value_objects.dart';

class FirebaseAuthFacade implements IAuthFacade {

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(
    this._firebaseAuth, 
    this._googleSignIn
  );

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    @required EmailAddress emailAddress, 
    @required Password password
  }) async {

    // We nedd to extract the email/ásswrod from the value objects. 
    final emailAddressString = emailAddress.getOrCrash();
    final passwordString = emailAddress.getOrCrash();

    try {

      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressString, 
        password: passwordString
      );
      // To mean that nothing wrong happened. 
      // the registerWithEmailAndPassword() doe not retunr anything;
      return right(unit); 

    } on PlatformException catch (e) {
      // The exception should not consider 
      if(e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }


  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress, 
    @required Password password
  }) async {

       // We nedd to extract the email/ásswrod from the value objects. 
    final emailAddressString = emailAddress.getOrCrash();
    final passwordString = emailAddress.getOrCrash();

    try {

      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressString, 
        password: passwordString
      );
      // To mean that nothing wrong happened. 
      // the registerWithEmailAndPassword() doe not retunr anything;
      return right(unit); 

    } on PlatformException catch (e) {
      // The exception should not consider 
      if(e.code == "ERROR_WRONG_PASSWORD" || 
         e.code == "ERROR_USER_NOT_FOUND") {
        return left(const AuthFailure.emailAlreadyInUse());
      } else { 
        return left(const AuthFailure.serverError());
      }
    }

  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    
    final googleUser = await _googleSignIn.signIn();
    
    if (googleUser == null) {
      return left(AuthFailure.cancelledByUser());
    }

    final googleAuthentication = await googleUser.authentication;

    final authCredential = GoogleAuthProvider.getCredential(
      idToken: googleAuthentication.idToken, 
      accessToken: googleAuthentication.accessToken
    );

    // Or use try catch
    await _firebaseAuth
            .signInWithCredential(authCredential)
            .then(        (r) => right(unit))
            .catchError(  (e) => left(const AuthFailure.serverError()));
    
  }
}