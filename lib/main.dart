import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gcm_app/Rotas.dart';
import 'package:gcm_app/telas/Home.dart';


    const primaryColor = Color(0xFF092757);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Aplicativo GCM",
    home: Home(),
    theme: ThemeData(
      primaryColor: primaryColor,
    ),    initialRoute: "/",
    onGenerateRoute: Rotas.gerarRotas,
    debugShowCheckedModeBanner: false,
  ));
}
