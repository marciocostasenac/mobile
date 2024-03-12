 import 'dart:convert';

import 'package:flutter/material.dart';
 import 'package:http/http.dart' as http;

void main(){
  runApp(Principal());

}

class Principal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: 'Aplicação com API',
     theme: ThemeData(primarySwatch: Colors.blue),
     home:home(),
     );
    // TODO: implement build
    
  }

}

class home extends StatefulWidget{
  @override
  home_state createState() => home_state();
}
class home_state extends State<home>{
//permite manipular o texto dentro do campo input
TextEditingController controleTexto = TextEditingController();
String conteudo = '';
String imagem = '';
//future retorna valor no futuro - async método assícrono
Future<void> buscar() async {
 String entrada = controleTexto.text;
 String url = 'https://pt.wikipedia.org/api/rest_v1/page/summary/$entrada';

 final resposta = await http.get(Uri.parse(url));
// se a busca estiver certa
 if(resposta.statusCode == 200) {
  Map<String, dynamic> dado = json.decode(resposta.body);
  setState(() {
    conteudo = dado['extract'];
    imagem =  dado ['originalimage'] ['source'];
  });
  
}else {
  //se houver um erro
  conteudo = 'Nada foi encontrado!';
  imagem = '';
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        'Aplicativo com API',
        style: TextStyle(color: Colors.white)
        ),
      backgroundColor: Colors.indigo,
      ),//appBar
      body: Stack(
        children:[
          //representa a imagem fundo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://www.shutterstock.com/shutterstock/photos/2200138025/display_1500/stock-photo-modern-black-blue-abstract-background-minimal-color-gradient-dark-web-banner-geometric-shape-2200138025.jpg'),
                fit: BoxFit.cover,
            ),
          ),
        ),
        //2 - construção do card
        Padding(
          padding: const EdgeInsets.all(56.0),
          child: Center(
            child: Card(
              color: Color.fromARGB(131, 255, 255, 255),
             elevation: 5.0,
             child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                 

                 Row(
                  children: <Widget>[
                 Expanded(
                  child: TextField(
                    controller:controleTexto,
                    decoration: const InputDecoration(
                      labelText:'Digite o texto',
                    )
                  )
                 ),//Expanded
                 

                  ElevatedButton(
                  onPressed:buscar,
                  child: const Icon(Icons.search,color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(Colors.indigo),
                  )
                ),// ElevatedButton
              ],
            ),
                
                 const SizedBox(height: 20.0),

                
                  const SizedBox(height:20.0),
                 const Text(
                  'Resultado',
                 style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Text(conteudo, style: TextStyle(fontSize:16.0)),
                  const SizedBox(height: 20),
                  if(imagem.isNotEmpty)

                  GestureDetector(
                    onTap:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=> 
                           ImagemTelaInteira(imagemParametro:imagem),
                          ),// MaterialPageRoute 
                        );
                      
                    },
                  
                    child:Center (
                      child: Hero(
                        tag: imagem,
                        child: ClipRRect(
                         borderRadius: BorderRadius.circular (10.0), 
                    child: Image.network(imagem, height: 150,))
                    ),
                    ),
                  ),
                   
              
                ], 
              ),
                 
                
              ),
             )
            ),
          ),
        
        ],
      ),
    );
   
  }
}
class ImagemTelaInteira extends StatelessWidget{
  final String imagemParametro;

  ImagemTelaInteira({ required this.imagemParametro});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: imagemParametro,
          child: Image.network(imagemParametro),
        ),
      ),
    );
  
  }
  
}