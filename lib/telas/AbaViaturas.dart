import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gcm_app/model/Viatura.dart';

class AbaViaturas extends StatefulWidget {
  const AbaViaturas({Key? key}) : super(key: key);
  @override
  _AbaViaturasState createState() => _AbaViaturasState();
}

class _AbaViaturasState extends State<AbaViaturas> {
  Future<List<Viatura>> _recuperarContatos() async {
    FirebaseFirestore database = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await database.collection("Guardas")
        .where('excluido', isEqualTo: false).get();

    List<Viatura> _listaUsuarios = [];

    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data() as Map<String, dynamic>;
      Viatura viatura = Viatura();
      viatura.marca = dados["Marca"];
      viatura.modelo = dados["Modelo"];
      viatura.numeroviatura = dados["Número da viatura"];
      viatura.placa = dados["Placa"];
      _listaUsuarios.add(viatura);
      _listaUsuarios.sort((a,b) => a.modelo.toLowerCase().compareTo(b.modelo.toLowerCase()));
    }
    return _listaUsuarios;
  }

  @override
  Widget build(BuildContext context) {
    List<Viatura> listaItens = [];
    return FutureBuilder<List<Viatura>>(
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
                Viatura viatura = listaItens[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/dadosguardas",
                        arguments: viatura);
                  },
                  child: Card(
                    elevation: 8,
                    shadowColor: Color(0xFF1BC0C5),
                    margin: EdgeInsets.all(10),
                    borderOnForeground: true,
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                      title: Text(
                        'Nome: ' +  viatura.modelo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'QRA: ' + viatura.marca,
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



