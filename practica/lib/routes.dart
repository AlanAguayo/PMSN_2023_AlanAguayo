import 'package:flutter/material.dart';
import 'package:practicauno/screens/about_us_screen.dart';
import 'package:practicauno/screens/account_screen.dart';
import 'package:practicauno/screens/dashboard_screen.dart';
import 'package:practicauno/screens/event_screen.dart';
import 'package:practicauno/screens/popular_movies_screen.dart';
import 'package:practicauno/screens/register_screen.dart';
import 'package:practicauno/screens/login_screen.dart';

import 'screens/games_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    "/register": (BuildContext context) => RegisterScreen(),
    "/login": (BuildContext context) => const LoginScreen(),
    "/dashboard": (BuildContext context) => const DashboardScreen(),
    "/event": (BuildContext context) => const EventScreen(),
    "/popular": (BuildContext context) => const PopularMoviesScreen(),
    "/games": (BuildContext context) => const GamesScreen(),
    "/account": (BuildContext context) => const AccountScreen(),
    "/about": (BuildContext context) => const AboutUsScreen(),
  };
}
