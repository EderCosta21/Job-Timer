import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          // ignore: prefer_const_constructors
          gradient: LinearGradient(
            // ignore: prefer_const_literals_to_create_immutables
            colors: [
              const Color(0XFF009289),
              const Color(0XFF0167B2),
            ],
          ),
        ),
        child: Center(
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
