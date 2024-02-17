import 'package:google_solution_challenge/screens/intro_screens/intro_screen_1.dart';
import 'package:google_solution_challenge/screens/intro_screens/intro_screen_2.dart';
import 'package:google_solution_challenge/screens/intro_screens/intro_screen_3.dart';
import 'package:google_solution_challenge/screens/intro_screens/intro_screen_4.dart';
import 'package:google_solution_challenge/screens/login/auth_login.dart';
import 'package:google_solution_challenge/screens/login/service/login_service.dart';
import 'package:google_solution_challenge/screens/onboardingscreen.dart';
import 'package:google_solution_challenge/translations/codegen_loader.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';

int? initScreen = 0;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt("initScreen");
  await preferences.setInt("initScreen", 100);
  await Firebase.initializeApp( // İnitializing firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        saveLocale: true,
        assetLoader: const CodegenLoader(),
        child: MyApp()
    ),);
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseUserAuthentication>(
            create: (_) => FirebaseUserAuthentication(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) =>
          context.read<FirebaseUserAuthentication>().authState,
          initialData: null,
        ),
        //ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: const Color(0xffff7800)),
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 300) {
                return const AuthPage();
                //return const Intro_Wear();
              } else {
                return const AuthPage();
              }
            },
          ),
        ),
      ),
    );
  }


}
