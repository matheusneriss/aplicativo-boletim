import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gcm_app/model/Pessoa.dart';

class AbaPessoasVG extends StatefulWidget {
  const AbaPessoasVG({Key? key}) : super(key: key);
  @override
  _AbaPessoasVGState createState() => _AbaPessoasVGState();
}

class _AbaPessoasVGState extends State<AbaPessoasVG> {
  Future<List<Pessoa>> _recuperarContatos() async {
    FirebaseFirestore database = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await database.collection("Pessoas")
        .where('excluido', isEqualTo: false).get();

    List<Pessoa> _listaPessoas = [];


    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data() as Map<String, dynamic>;
      Pessoa pessoa = Pessoa();
      pessoa.datadenasicmento = dados["Data de nascimento"];
      pessoa.cor = dados["Cor"];
      pessoa.logradouro = dados["Logradouro"];
      pessoa.bairro = dados["Bairro"];
      pessoa.numero = dados["Numero"];
      pessoa.celular = dados["Celular"];
      pessoa.nomedopai = dados["Nome do pai"];
      pessoa.nomedamae = dados["Nome da mãe"];
      pessoa.cep = dados["Cep"];
      pessoa.profissao = dados["Profissao"];
      pessoa.ufrg = dados["Uf do rg"];
      pessoa.numcnh = dados["CNH"];
      pessoa.catcnh = dados["Categoria da cnh"];
      pessoa.examecnh = dados["Exame CNH"];
      pessoa.nome = dados["Nome"];
      pessoa.estadoNascimento = dados["Estado de Nascimento"];
      pessoa.municipio = dados["Municipio"];
      pessoa.naturalidade = dados["Naturalidade"];
      pessoa.Uf = dados["Uf"];
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
                    Navigator.pushNamed(context, "/dadospessoasVG",
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



