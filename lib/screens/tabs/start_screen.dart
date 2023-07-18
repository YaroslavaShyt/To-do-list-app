import 'package:flutter/material.dart';
import 'package:taskapp/constants/font_styling.dart';
import 'package:taskapp/screens/login_screen/login_screen.dart';

class StartScreen extends StatelessWidget {
  static const id = 'start_screen';
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/img.png'),
              Image.asset('assets/images/triangle_lines.png'),
              Image.asset(
                    'assets/images/task_list.png',
                    height: 350,
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Wrap(
              children: [
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Manage ', style: FontStyling.nunitoBlack),
                      TextSpan(text: 'your task and ', style: FontStyling.nunitoBold),
                      TextSpan(text: 'ideas ', style: FontStyling.nunitoBold),
                    ],
                  ),
                ),
                const Text('quickly', style: FontStyling.nunitoBold),
                Image.asset(
                    'assets/images/bulb.png',
                  height: 90,
                )
              ],
            )
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 50),
        width: 150,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30)
        ),
        child: FloatingActionButton(
          elevation: 0,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Start', style: FontStyling.nunitoBlackWhite,),
              SizedBox(width: 5,),
              Icon(size: 40,
                  Icons.arrow_forward)
            ],
          ),
          onPressed: (){
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          },
        ),
      ),
    );
  }
}
