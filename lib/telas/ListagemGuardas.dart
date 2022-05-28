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

  _switchSearchBarState(){
    setState((){
      searchEnabled = !searchEnabled;
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF092757),
          title: !searchEnabled ? Text(Title) :
          TextField(
            style:  new TextStyle(
              color:  Colors.white,
            ),
            decoration: new InputDecoration(
              border: InputBorder.none,
              prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: "Pesquisar",
              hintStyle: new TextStyle(color: Colors.white)
            ),
          ),
          actions: [
            IconButton(
              icon: Icon( searchEnabled? Icons.close : Icons.search),
              onPressed: _switchSearchBarState,
            )
          ],
        ),
      body: Container(
        child:AbaContatos()
      ),
    );
  }
}
