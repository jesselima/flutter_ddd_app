import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

/// This module is made do allow us to register and expose external implementation
/// like third party libraries and
@registerModule
abstract class FirebaseInjectableModule {

    @lazySingleton
    GoogleSignIn get googleSignin => GoogleSignIn();

    @lazySingleton
    FirebaseAuth get firebaseAuth => FirebaseAuth.instance;


}