import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/Services/database_service.dart';
import 'package:todo_list/Services/oauth2_authentication_service.dart';
import '../models/tasks_data.dart';

import 'Screens/signin_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
    */
    return ChangeNotifierProvider<TasksData>(
      create: (context) => TasksData(DatabaseService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SigninPage(context.read<Oauth2AuthenticationService>()),
      ),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User>();
//
//     if (firebaseUser != null) {
//       return HomeScreen(firebaseUser);
//     }
//     return SignInPage();
//   }