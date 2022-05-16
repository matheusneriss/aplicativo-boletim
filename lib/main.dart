import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gcm_app/Rotas.dart';
import 'package:gcm_app/telas/Home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Aplicativo GCM",
    home: Home(),
    initialRoute: "/",
    onGenerateRoute: Rotas.gerarRotas,
    debugShowCheckedModeBanner: false,
  ));
}
