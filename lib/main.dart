import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walletSync/screens/auth_screen.dart';
import 'package:walletSync/screens/main_screen.dart';
import 'firebase_options.dart'; // Assuming you have this file for Firebase configuration
import 'package:flutter_dotenv/flutter_dotenv.dart';

final firebaseauth = FirebaseAuth.instance;

void main() async {
  await dotenv.load(fileName: "API_KEYS.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: StreamBuilder(
          stream: firebaseauth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainScreen();
            }
            return const AuthScreen();
          },
        ),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: const Color.fromARGB(225, 47, 37, 37),
          ),
          textTheme: GoogleFonts.latoTextTheme(),
        ),
      );
}
