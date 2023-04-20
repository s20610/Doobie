import 'package:doobie/firebase_options.dart';
import 'package:doobie/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor primaryColor = MaterialColor(AppColors.primaryColorInt, AppColors.primaryColorSwatch);
    MaterialColor secondaryColor = MaterialColor(AppColors.secondaryColorInt, AppColors.secondaryColorSwatch);
    MaterialColor accentColor = MaterialColor(AppColors.accentColorInt, AppColors.accentColorSwatch);
    return MaterialApp(
      title: 'Doobie',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: primaryColor,
        focusColor: accentColor,
        secondaryHeaderColor: secondaryColor,

      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                if(user != null){
                  if(user.emailVerified){
                    return const NotesView();
                  }else{
                    return const VerifyEmailView();
                  }
                }else{
                  return const LoginView();
                }
                return const Text('Done');
              default:
                return const CircularProgressIndicator();
            }
          }),
    );
  }
}
