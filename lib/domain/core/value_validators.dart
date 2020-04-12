import 'package:dartz/dartz.dart';
import 'package:flutterdddapp/domain/core/failures.dart';


Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  // Maybe not the most robust way of email validation but it's good enough
  const regex =  r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  if(RegExp(regex).hasMatch(input)) {
      return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {

  const regex =  "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!()#%&@\^\$\*\-\&])(?=.{8,})";
    // The RegEx above validate:
    // ^	              The password string will start this way
    // (?=.*[a-z])	    The string must contain at least 1 lowercase alphabetical character
    // (?=.*[A-Z])	    The string must contain at least 1 uppercase alphabetical character
    // (?=.*[0-9])	    The string must contain at least 1 numeric character
    // (?=.*[!@#$%^&*])	The string must contain at least one special character, but we are escaping reserved RegEx characters to avoid conflict
    // (?=.{8,})	      The string must be eight characters or longer
    // 

  if(RegExp(regex).hasMatch(input)) {
      return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}