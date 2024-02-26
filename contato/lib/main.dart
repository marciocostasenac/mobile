import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main(){
  runApp(const Contato());
}

class Contato extends StatelessWidget{
  //necessário para inicializar a widget, passa para a classe pai
  const Contato({super.key});
  
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
   title: 'Fluter Demo',
   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
   useMaterial3: true,
   ),
   home: const Principal(title:'Contato Pessoal'),
   );// MaterialApp
   
  }
}

class Principal extends StatefulWidget {
  //passa parâmetros informações para dentro da classe
  const Principal({super.key, required this.title});

  final String title;
  //cria um estado que vai se referir a classe _PrincipalEstado
  @override
  State<Principal> createState() => _PrincipalEstado();
}
 //classe _PrincipalEstado herdando o Estado - Estado: vai ficar atualizando
 class _PrincipalEstado extends State<Principal> {
 final foto = const CircleAvatar( 
   backgroundImage: NetworkImage(
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT57egHeLZcExcR6NwPWBVY7UMKLw2bRzWYdQ&usqp=CAUhttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT57egHeLZcExcR6NwPWBVY7UMKLw2bRzWYdQ&usqp=CAUhttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT57egHeLZcExcR6NwPWBVY7UMKLw2bRzWYdQ&usqp=CAU"),
   radius: 150,
   ); // CircleAvatar
   final nome = const Text(
    
    'Marcio Costa',
    style: TextStyle(fontSize: 30),
    textAlign: TextAlign.center,
    ); // Text

    final obs = const Text(
      'Programador Full Stack Senac',
      style: TextStyle(fontSize: 20, color: Colors.blue),
      textAlign: TextAlign.center,
    ); //Text
    
    final email = IconButton(
    icon: const Icon(Icons.mail) ,
    color: Colors.blue,
    onPressed: () {
      launchUrl(Uri(
          scheme: 'mailto',
          path:'marcio.9957@aluno.pr.senac.br',
          queryParameters: {
            'subject': 'Assunto do email',
            'body': 'Corpo do Email',
          }
        ));
      
    }
    );
      final telefone = IconButton(
    icon: const Icon(Icons.phone),
    color: Colors.blue,
    onPressed: () {
      launchUrl(Uri(scheme: 'tel', path: '+5544974009708'));
    },
  );

  final sms = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.sms),
    onPressed: () {
      launchUrl(Uri(scheme: 'sms', path: '+5544974009708'));
    },
  );

  final site = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.open_in_browser),
    onPressed: () {
      launchUrl(Uri.parse(
          'https://www.linkedin.com/in/luiz-gustavo-francisco-7ba970186/'));
    },
  );

  final whatsapp = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.wechat),
    onPressed: () {
      launchUrl(Uri.parse('https://api.whatsapp/+554497009708'));
    },
  );

  final mapa = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.map),
    onPressed: () {
      launchUrl(Uri.parse('https://maps.app.goo.gl/ALo7WacLyQ28ugY37'));
    },
  );



  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        'Aplicativo de Contato',
        style: TextStyle(color: Colors.white),
        ) ,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
        icon: Icon(Icons.account_circle, color: Colors.white),
        onPressed:() {} ,
        ),
      ),
      //organizar em coluna
      body: Column(
      //alinhar conteúdo no centro - acima/abaixo
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        foto,nome,obs,
        //criando linha
        Text('Olá Mundo'),
        // criando linha
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            email,
              telefone,
              sms,
              site,
              whatsapp,
              mapa,
          ],
          //botões do aplicativo
        )//row

      ],
    ),
    );//Scaffold
   }

 }
  


