// This class is made to properly crash the app due to the application reach some incorret state. 
// This incorrect state can 
import 'package:flutterdddapp/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation = "Encountered a ValueFailure at an unrecoverable point. Terminating.";
    return Error.safeToString("$explanation Failure was: $valueFailure");
  }
}