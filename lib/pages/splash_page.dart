// import 'package:flutter/material.dart';
// import 'package:supa2/main.dart';
// import 'package:supa2/pages/account_page.dart';
// import 'package:supa2/pages/login_page.dart';
//
// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});
//
//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> {
//
//   @override
//   void initState() {
//     super.initState();
//     _redirect();
//   }
//
//   Future<void> _redirect()async{
//     await Future.delayed(Duration.zero);
//     final session =  supabase.auth.currentSession;
//
//     if(session != null){
//       //Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage()));
//       Navigator.pushNamed(context, '/home');
//     }else{
//      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
//       Navigator.pushNamed(context, '/login');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Splash Screen'),
//       ),
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supa2/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() {
    // Small splash delay (like your Firebase example)
    Timer(const Duration(seconds: 2), () {
      final session = supabase.auth.currentSession;

      if (session != null) {
        // ✅ User is logged in → Go to Home
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // ❌ User is not logged in → Go to Login
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
