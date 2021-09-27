import 'package:flutter/material.dart';
import 'package:riyasewana/styles.dart';
import 'package:flutter_animator/flutter_animator.dart';

@override
void initState() {}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            color: DefaultColor,
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Pulse(
                  preferences: AnimationPreferences(
                      offset: Duration(seconds: 1),
                      autoPlay: AnimationPlayStates.Loop),
                  child: Container(
                    alignment: const Alignment(0.0, 0.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 400,
                      width: 300,
                    ),
                  ),
                ),
                FadeInRightBig(
                  child: Container(
                    alignment: const Alignment(0.0, 1.3),
                    child: Image.asset(
                      'assets/images/splashWatermark.png',
                      height: 400,
                      width: 300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
