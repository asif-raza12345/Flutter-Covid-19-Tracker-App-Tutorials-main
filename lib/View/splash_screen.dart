import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math'as math;
import '../worldstatescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>  Navigator.push(context, MaterialPageRoute(builder: (context)=> const WorldststeScrreen()))
    );
  }
  @override
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child:AnimatedBuilder(
                animation: controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Image(image: AssetImage('images/virus.png'),),
                  ),
                ),
                builder: (BuildContext context, Widget? child ){
                  return Transform.rotate(
                      angle: controller.value * 2 *math.pi,
                    child: child,
                  );
                },

              ),
            ),
            const SizedBox(height: 40,),
            const Align(
              alignment: Alignment.center,
              child: Text("Covid_19\n Tracker App",style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),),
            )
          ],
        )
      ),
    );
  }
}
