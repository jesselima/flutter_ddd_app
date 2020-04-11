import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'email_address.freezed.dart';

@immutable
class EmailAddress {
  
  // Either<Failure, Success>
  final Either<ValueFailure<String>, String> value;


  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value); // ._ Makes the constructor private

  // toString, equals, hashCode...

  @override
  bool operator ==(Object object) {
    if (identical(this, object)) return true;
  
    return object is EmailAddress && object.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'EmailAddress(value: $value)';
}


Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  // Maybe not the most robust way of email validation but it's good enough
  const emailRegex =  r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  if(RegExp(emailRegex).hasMatch(input)) {
      return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}


// Creating a value failure with 
@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {

  const factory ValueFailure.invalidEmail({
    @required T failedValue,
  }) = InvalidEmail<T>;

  const factory ValueFailure.shortPassword({
    @required T failedValue,
  }) = ShortPassword<T>;
}


// Testing the use of the function sample
void showingTheEmailAddressOrFailure() {
  
  final emailAdress = EmailAddress("jhgdshdtyew");

  // This one way to get the value
  String emailText = emailAdress.value.fold(
    (left) => "Failure happened, more precisely: $left", 
    (right) => right
  );

  // This is anotehr way - WE DO NOT HAVE ACCESS TO THE FAILURE
  String emailText2 = emailAdress.value.getOrElse(() => "SOMETHING WENT WRONG");

}
