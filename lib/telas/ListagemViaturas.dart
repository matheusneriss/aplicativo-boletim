import 'package:flutter/material.dart';
import 'AbaViaturas.dart';

class Viaturaslistagem extends StatefulWidget {
  const Viaturaslistagem({Key? key}) : super(key: key);

  @override
  State<Viaturaslistagem> createState() => _GuardaslistagemState();
}

class _GuardaslistagemState extends State<Viaturaslistagem> {
  String Title = "Listagem das Viaturas";
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
          child:AbaViaturas()
      ),
    );
  }
}
