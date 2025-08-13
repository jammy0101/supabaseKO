import 'package:flutter/material.dart';
import 'package:supa2/pages/account_page.dart';
import 'package:supa2/pages/home.dart';
import 'package:supa2/pages/login_page.dart';
import 'package:supa2/pages/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://aqdltvlruqefgswwvbdh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFxZGx0dmxydXFlZmdzd3d2YmRoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ5MTg1ODIsImV4cCI6MjA3MDQ5NDU4Mn0.aMfQk3nQGdFkbBR_Hlp1nBFubXPua8eFPFewYSc27D4',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
    initialRoute: '/',
      routes: {
        '/' : (context) => SplashPage(),
        '/login' : (context) => LoginPage(),
        '/account_page' : (context) => CreateAccountPage(),
        '/home' : (context) => Home(),
      },
    );
  }

}
extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme
            .of(this)
            .colorScheme
            .error
            : Theme
            .of(this)
            .snackBarTheme
            .backgroundColor,
      ),
    );
  }
}
