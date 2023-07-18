import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskapp/screens/login_screen/login_screen.dart';
import 'package:taskapp/screens/tabs/start_screen.dart';
import 'package:taskapp/screens/tabs/tabs_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GetStorage _getStorage = GetStorage();
  @override
  initState(){
    openNextPage(context);
    super.initState();
  }

 openNextPage(BuildContext context){
   Timer(const Duration(milliseconds: 2000), (){
     if(_getStorage.read('token') == null || _getStorage.read('token') == ''){
       Navigator.pushReplacementNamed(context, StartScreen.id);
     }else{
       Navigator.pushReplacementNamed(context, TabsScreen.id);
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
