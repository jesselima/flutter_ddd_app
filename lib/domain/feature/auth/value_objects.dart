import 'package:dartz/dartz.dart';

import 'package:flutterdddapp/domain/core/failures.dart';
import 'package:flutterdddapp/domain/core/value_objects.dart';
import 'package:flutterdddapp/domain/core/value_validators.dart';


class EmailAddress extends ValueObject<String> {
  
  // Either<Failure, Success>
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value); // ._ Makes the constructor private
}


class Password extends ValueObject<String> {
  
  // Either<Failure, Success>
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    assert(input != null);
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value); // ._ Makes the constructor private
}


