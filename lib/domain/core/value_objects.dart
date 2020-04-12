import 'package:dartz/dartz.dart';
import 'package:flutterdddapp/domain/core/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';


@immutable
abstract class ValueObject<T> {

  const ValueObject();
  
  // Either<Failure, Success>
  Either<ValueFailure<T>, T> get value;

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
