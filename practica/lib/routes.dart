import 'package:flutter/material.dart';
import 'package:practicauno/screens/dashboard_screen.dart';
import 'package:practicauno/screens/register_screen.dart';
import 'package:practicauno/screens/login_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    "/register": (BuildContext context) => RegisterScreen(),
    "/login": (BuildContext context) => const LoginScreen(),
    "/dashboard": (BuildContext context) => const DashboardScreen(),
  };
}
