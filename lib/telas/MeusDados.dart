import 'package:flutter/material.dart';

class Meusdados extends StatefulWidget {
  const Meusdados({Key? key}) : super(key: key);

  @override
  State<Meusdados> createState() => _MeusdadosState();
}

class _MeusdadosState extends State<Meusdados> {

  TextEditingController _controllerNome = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(
        "Meus Dados") ,),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Carregando
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(
                      'https://uploads.metropoles.com/wp-content/uploads/2022/05/09154316/foto-Neymar-PSG-08052022-600x400.jpg',),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          child: Text(
                            "Câmera",
                          ),
                      onPressed: (){},
                      ),
                      FlatButton(
                        child: Text(
                          "Galeria",
                        ),
                        onPressed: (){},
                      ),
                    ],
                  ),
                  Padding(
                      padding:EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: _controllerNome,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 20),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Nome",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32))
                            )
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: RaisedButton(
                      child: Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Color.fromARGB(255, 6, 134, 49),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)
                      ),
                      onPressed: () {
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
