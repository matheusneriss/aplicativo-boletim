import 'package:flutter/material.dart';
import 'AbaBoletinsReprovados.dart';

class BoletinslistagemReprovados extends StatefulWidget {
  const BoletinslistagemReprovados({Key? key}) : super(key: key);

  @override
  State<BoletinslistagemReprovados> createState() => _BoletinslistagemReprovadosState();
}

class _BoletinslistagemReprovadosState extends State<BoletinslistagemReprovados> {
  String Title = "Boletins Reprovados";
  bool  searchEnabled = false;
  TextEditingController _pesquisa = TextEditingController();

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
          IconButton(
              icon: Icon( searchEnabled? Icons.close : Icons. search_rounded),
              onPressed: (){
                _switchSearchBarState();
              }
          ),
        ],
      ),
      body: Container(
          child:AbaBoletinsReprovados()
      ),
    );
  }
}
