import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gcm_app/model/Pessoa.dart';
import 'package:gcm_app/model/Viatura.dart';

class AbaPessoas extends StatefulWidget {
  const AbaPessoas({Key? key}) : super(key: key);
  @override
  _AbaPessoasState createState() => _AbaPessoasState();
}

class _AbaPessoasState extends State<AbaPessoas> {
  Future<List<Pessoa>> _recuperarContatos() async {
    FirebaseFirestore database = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await database.collection("Pessoas")
        .where('excluido', isEqualTo: false).get();

    List<Pessoa> _listaPessoas = [];


    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data() as Map<String, dynamic>;
      Pessoa pessoa = Pessoa();
      pessoa.nome = dados["Nome"];
      pessoa.cpf = dados["CPF"];
      pessoa.rg = dados["RG"];
      pessoa.telefone = dados["Telefone"];
      _listaPessoas.add(pessoa);
    }
    return _listaPessoas;
  }

  @override
  Widget build(BuildContext context) {
    List<Pessoa> listaItens = [];
    return FutureBuilder<List<Pessoa>>(
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
                Pessoa pessoa = listaItens[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/dadospessoas",
                        arguments: pessoa);
                  },
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.blueAccent,
                    margin: EdgeInsets.all(13),
                    borderOnForeground: true,
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                      title: Text(
                        'Nome: ' +  pessoa.nome,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Cpf: ' + pessoa.cpf,
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



