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
    QuerySnapshot querySnapshot = await database.collection("Guardas")
        .where('excluido', isEqualTo: false).get();

    List<Usuario> _listaUsuarios = [];

    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data();
      var dadosmap = dados as Map<String, dynamic>;
      Usuario usuario = Usuario();
      usuario.qra = dados["nome de guerra"];
      usuario.nome = dados["nome"];
      usuario.cpf = dados["cpf"];
      usuario.celular = dados["celular"];
      usuario.celular = dados["celular"];
      usuario.matricula = dados["matricula"];
      usuario.datanascimento = dados["data de nascimento"];
      usuario.email = dados["email"];


      usuario.urlImagem = dadosmap["urlImagem"];

      _listaUsuarios.add(usuario);
      _listaUsuarios.sort((a,b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
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
                Usuario usuario = listaItens[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/dadosguardas",
                    arguments: usuario);
                  },
                  child: Card(
                    elevation: 8,
                    shadowColor: Color(0xFF1BC0C5),
                    margin: EdgeInsets.all(10),
                    borderOnForeground: true,
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                      leading: CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage: usuario.urlImagem != null
                              ? NetworkImage(usuario.urlImagem.toString())
                              : null),
                      title: Text(
                       'Nome: ' +  usuario.nome,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'QRA: ' + usuario.qra,
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



