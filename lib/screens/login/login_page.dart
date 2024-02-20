import 'package:google_solution_challenge/screens/forgot_password.dart';
import 'package:google_solution_challenge/screens/register_page.dart';
import 'package:google_solution_challenge/services/auth_service.dart';
import 'package:google_solution_challenge/screens/login/service/login_service.dart';
import 'package:google_solution_challenge/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int playPause = 0;
  final player = AudioPlayer();

  void sosWarning() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: Text(
            LocaleKeys.loginPageWhistle.tr(),
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  void registerUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              // autogroupe2pp7c9 (57P22SfybUb95vsn6xE2PP)
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 19),
                width: double.infinity,
                height: height * 0.32,
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: height * 0.17,
                          height: height * 0.17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(height * 0.10),
                            color: const Color(0xffffffff),
                            image: const DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage("assets/images/ring.png"),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3f000000),
                                offset: Offset(0, 4),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (playPause == 0) {
                                player.play(AssetSource("sossound.mp3"));
                                //player.stop();
                                sosWarning();
                                setState(() {
                                  playPause = 1;
                                });
                              } else {
                                player.stop();
                                setState(() {
                                  playPause = 0;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ])),
            const Text(
              "Earthquaker",
              style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 46.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15.0),
            Text(
              LocaleKeys.Login_Page_loginPage.tr(),
              style: const TextStyle(
                fontFamily: "Source Sans Pro",
                fontSize: 15.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey
              ),
            ),
            SizedBox(
              height: 30.0,
              width: 200.0,
              child: Divider(
                color: Colors.grey.shade200,
                thickness: 1.0,
              ),
            ),
            buildTextField(Icons.email, emailController, LocaleKeys.Login_Page_email.tr(), false),
            const SizedBox(
              height: 20.0,
            ),
            buildTextField(Icons.lock, passwordController, LocaleKeys.Login_Page_password.tr(), true),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage())),
                    child: Text(
                      LocaleKeys.Login_Page_forget_password.tr(),
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            buildButton(() async {
              await FirebaseUserAuthentication.signIn(
                email: emailController.text,
                password: passwordController.text,
                context: context,
              );
            }),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      LocaleKeys.Login_Page_or.tr(),
                      style: const TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => AuthService().signInWithGoogle(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 50.0,
                    child: Image.asset("assets/images/google.png"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.loginPageCreateAccount.tr(),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                GestureDetector(
                  onTap: registerUser,
                  child: Text(
                    LocaleKeys.loginPageSignUp.tr(),
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Padding buildButton(Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Container(
          width: 150.0,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(12.0)),
          child: Center(
            child: Text(
              LocaleKeys.loginPageSignIn.tr(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildTextField(
      IconData icon, final controller, String hintText, bool obscureText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey[500]),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
