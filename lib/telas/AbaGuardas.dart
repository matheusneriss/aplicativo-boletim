import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/Usuario.dart';

class AbaContatos extends StatefulWidget {
  const AbaContatos({Key? key}) : super(key: key);
  @override
  _AbaContatosState createState() => _AbaContatosState();
}

class _AbaContatosState extends State<AbaContatos> {
  Future<List<Usuario>> _recuperarContatos() async {
    FirebaseFirestore database = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await database.collection("Guardas").get();

    List<Usuario> _listaUsuarios = [];

    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data();
      var dadosmap = dados as Map<String, dynamic>;
      Usuario usuario = Usuario();
      usuario.email = dadosmap["email"];
      usuario.nome = dadosmap["nome"];
      usuario.urlImagem = dadosmap["urlImagem"];

      _listaUsuarios.add(usuario);
    }
    return _listaUsuarios;
  }

  @override
  Widget build(BuildContext context) {
    List<Usuario> listaItens = [];
    return FutureBuilder<List<Usuario>>(
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
                // Map<String, dynamic> data =
                //     snapshot.data! as Map<String, dynamic>;
                // listaItens = data as List<Usuario>;
                Usuario usuario = listaItens[index];
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    borderOnForeground: true,
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                      leading: CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage: usuario.urlImagem != null
                              ? NetworkImage(usuario.urlImagem.toString())
                              : null),
                      title: Text(
                        usuario.nome,
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



