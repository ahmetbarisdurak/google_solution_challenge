import 'package:google_solution_challenge/navbar/navbar.dart';
import 'package:google_solution_challenge/screens/home.dart';
import 'package:google_solution_challenge/screens/profile/profile_screen.dart';
import 'package:google_solution_challenge/screens/information_screen/information.dart';
import 'package:get/get.dart';

class AppPage {
  static List<GetPage> routes = [
    GetPage(name: navbar, page: () => const NavBar()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: information, page: () => const InformationScreen())
  ];

  static String navbar = "/";
  static String home = "/home";
  static String profile = "/profile";
  static String information = "/information";

  static getNavBar() => navbar;
  static getHome() => home;
  static getProfile() => profile;
  static getInformation() => information;
}
