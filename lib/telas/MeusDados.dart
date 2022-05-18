import 'package:flutter/material.dart';

class Meusdados extends StatefulWidget {
  const Meusdados({Key? key}) : super(key: key);

  @override
  State<Meusdados> createState() => _MeusdadosState();
}

class _MeusdadosState extends State<Meusdados> {
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
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}
