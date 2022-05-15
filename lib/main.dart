import 'package:flutter/material.dart';
import 'package:gcm_app/Rotas.dart';
import 'package:gcm_app/telas/Home.dart';

void main() => runApp(MaterialApp(
      title: "Aplicativo GCM",
      home: Home(),
      initialRoute: "/",
      onGenerateRoute: Rotas.gerarRotas,
      debugShowCheckedModeBanner: false,
    ));
