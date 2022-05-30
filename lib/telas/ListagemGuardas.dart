import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AbaGuardas.dart';

class Guardaslistagem extends StatefulWidget {
  const Guardaslistagem({Key? key}) : super(key: key);

  @override
  State<Guardaslistagem> createState() => _GuardaslistagemState();
}

class _GuardaslistagemState extends State<Guardaslistagem> {
  String Title = "Listagem dos Guardas";
  bool  searchEnabled = false;
  TextEditingController _pesquisa = TextEditingController();

  _switchSearchBarState(){
    setState((){
      searchEnabled = !searchEnabled;
    }

    );
  }
  //  _pesquisadados(){
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   Query query = db.collection("Guardas");
  //   query = query.where("nome", isEqualTo: _pesquisa);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF092757),
          title: !searchEnabled ? Text(Title) :
          TextField(
            controller: _pesquisa,
            style:  new TextStyle(
              color:  Colors.white,
            ),
            decoration: new InputDecoration(
              border: InputBorder.none,
                hintText: "Pesquisar",
              hintStyle: new TextStyle(color: Colors.white)
            ),
          ),
          actions: [
            // IconButton(
            //     icon: Icon(Icons. search_rounded),
            //     onPressed: _pesquisadados
            //
            // ),
            IconButton(
                icon: Icon( searchEnabled? Icons.close : Icons. search_rounded),
                onPressed: (){
                  _switchSearchBarState();
                }
            ),
          ],
        ),
      body: Container(
        child:AbaContatos()
      ),
    );
  }
}
