import 'package:blood_donor/Application/googleAuth.dart';
import 'package:blood_donor/Application/reposotory/rep.dart';
import 'package:blood_donor/Application/router.dart';
import 'package:blood_donor/Presentation/home.dart';
import 'package:blood_donor/Presentation/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GoogleAuthService>(
            create: (_) => GoogleAuthService(FirebaseAuth.instance)),
        Provider<Repository>(
            create: (_) => Repository(FirebaseFirestore.instance)),
        StreamProvider(
            create: (context) =>
            context.read<GoogleAuthService>().authStateChanges)
      ],
      child:  MaterialApp(
        onGenerateRoute: ZRouter.onGenerateRoute,
        title: 'Donor App',
        debugShowCheckedModeBanner: false,
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return Home();
    } else {
      return Loginscreen();
    }
  }
}
