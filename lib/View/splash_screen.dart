import 'dart:async';

import 'package:covidapp/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  //In Flutter, TickerProviderStateMixin is used when you want to create animations.,Specifically, it provides a Ticker, which is like a heartbeat that ticks every frame (usually 60 times per second). This "tick" drives your animation forward.
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(); //repeat helps in repeating the animated controller till the duration of the animated controller
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement( //navigator.push replacement helps in move the app to the main mobile home screen rather than the splashing effect
        context,
        MaterialPageRoute(builder: (context) => WorldStates()),
      ),
    ); //After 5 seconds, it navigates to another screen (WorldStates).
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller
        .dispose(); // once our screen is loaded completely we dispose the controller to make sure that it is not connected with some other page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //SafeArea protects your UI from being overlapped by system UI.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 200,
                width: 200,
                child: const Center(
                  child: Image(image: AssetImage('images/virus.png')),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ), //builder  Lets you build UI dynamically
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),//This line adds vertical space (around 8% of the screen height) between two widgets in your splash screen:
            /*
            * |--------------------------------------|
|          Rotating Image              |
|                                      |
| ← SizedBox (8% height of screen) →   |
|                                      |
|      COVID-19 TRACKER APP Text       |
|--------------------------------------|
*/
            const Align(
              alignment: Alignment.center,
              child: Text(
                'COVID-19\nTRACKER APP',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
