import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterdddapp/domain/feature/auth/auth_failure.dart';
import 'package:flutterdddapp/domain/feature/auth/value_objects.dart';

abstract class IAuthFacade {

  // To use Either in the void functions we use Unit instead "void".
  // If the function return some specific type in the Either Right
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

}