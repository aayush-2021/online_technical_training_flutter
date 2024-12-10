import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Account Screen",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              // Image widget
              // Image.asset(
              //   "assets/drawer_image.png",
              //   height: 200,
              //   width: 100,
              // ),

              Image.network(
                "https://lh3.googleusercontent.com/BrxLgA8jK07_fWYREr3hUvdK5DbkMM7HmlhveY9DG8foSvl_2X3GzTRz9ElWoGuPs6t3SvlL_XHx9zHvgKPaDhnx2a7GyT-Ix9Z6=w1064-v0",
                height: 200,
                width: 100,
              ),
              SvgPicture.asset("assets/home_icon.svg"),
            ],
          ),
        ),
      ),
    );
  }
}
