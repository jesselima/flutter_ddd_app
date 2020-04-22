import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutterdddapp/domain/core/errors.dart';
import 'package:flutterdddapp/domain/core/failures.dart';


@immutable
abstract class ValueObject<T> {

  const ValueObject();
  
  // Either<Failure, Success>
  Either<ValueFailure<T>, T> get value;

  /// It with return the value of the Right side if it remains unchanged. Or return an UnexpectedValueError. 
  /// Throws [UnexpectedValueError] containing a [ValueFailure]
  T getOrCrash() {
    return value.fold(
       (f) => throw UnexpectedValueError(f),  // Left
       id                                     // Right. "(r) =>  r". It was replaced for the Identity Function "id"
     );
  }

  bool isValid() => value.isRight(); // <---

  // toString, equals, hashCode...

  @override
  bool operator == (Object object) {
    if (identical(this, object)) return true;
  
    return object is ValueObject<T> && object.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value(value: $value)';
}
