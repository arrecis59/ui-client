import 'package:flutter/material.dart';
import 'package:ui_client/src/pages/login_page.dart';
import 'package:ui_client/src/pages/register_page.dart';

getApplicationRoutes(){
  return<String, WidgetBuilder>{
    '/'         :  (BuildContext context) => LoginPage(),
    'register'  :  (BuildContext context) => RegisterPage()
  };
}