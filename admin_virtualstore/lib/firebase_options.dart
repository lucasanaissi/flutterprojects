// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBp9ju6ImpljXkQJ8OY4_G5rFdmZXbVKa0',
    appId: '1:272792613352:android:36334690cdd9589167345d',
    messagingSenderId: '272792613352',
    projectId: 'virtualstoreinflutter',
    storageBucket: 'virtualstoreinflutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5Tffi0ejCIFdDr4i1ssS5SlHCE1qKGYM',
    appId: '1:272792613352:ios:f103c70a398220fb67345d',
    messagingSenderId: '272792613352',
    projectId: 'virtualstoreinflutter',
    storageBucket: 'virtualstoreinflutter.appspot.com',
    iosClientId: '272792613352-vf661cmp67eerbbkg47djskd3uaq7hgp.apps.googleusercontent.com',
    iosBundleId: 'br.com.jaco.admin',
  );
}