import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gcm_app/model/Boletim.dart';

class AbaBoletinsAprovados extends StatefulWidget {
  const AbaBoletinsAprovados({Key? key}) : super(key: key);
  @override
  _AbaBoletinsAprovadosState createState() => _AbaBoletinsAprovadosState();
}

class _AbaBoletinsAprovadosState extends State<AbaBoletinsAprovados> {
  Future<List<Boletim>> _recuperarContatos() async {
    FirebaseFirestore database = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await database.collection("Boletim")
        .where('Status', isEqualTo: "Pendente aprovação").get();

    List<Boletim> _listaUsuarios = [];

    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data();
      var dadosmap = dados as Map<String, dynamic>;
      Boletim  boletim = Boletim();
      boletim.numbo = dados["Número do BO"];
      boletim.status = dados["Status"];
      _listaUsuarios.add(boletim);
    }
    return _listaUsuarios;
  }

  @override
  Widget build(BuildContext context) {
    List<Boletim> listaItens = [];
    return FutureBuilder<List<Boletim>>(
      future: _recuperarContatos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                listaItens = snapshot.data!;
                Boletim boletim = listaItens[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/dadosguardas",
                        arguments: boletim);
                  },
                  child: Card(
                    elevation: 8,
                    shadowColor: Color(0xFF1BC0C5),
                    margin: EdgeInsets.all(10),
                    borderOnForeground: true,
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                      title: Text(
                        'Número do BO:' +  boletim.numbo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Status do boletim:' + boletim.status,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }
}



