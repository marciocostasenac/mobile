import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarefas/controle_tarefa.dart';
import 'package:tarefas/modelo_tarefa.dart';
//funcão principal, executa em primeiro lugar
void main(){
  runApp(Principal());
}
class Principal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //change notifier liga a visualização ao controle tarefa
    //quando houver alguma alteração no controle, altera a tela
    return ChangeNotifierProvider(
      create: (context) => Controle_tarefa(),
      child: MaterialApp(
        title: 'App de Tarefas',
        home: telaTarefas(),
        debugShowCheckedModeBanner: false,
      )
    );
  }

}
class telaTarefas extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra de navegação
      appBar: AppBar (
        title: const Text(
          'App de Tarefas',
          style: TextStyle (color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: listaTarefas(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          abrirJanelaCadastro(context);
        },
        child: Icon (Icons.add),
        ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
  void abrirJanelaCadastro(BuildContext context){
    //usado para controlar o textfiled(campo de inserção de texto editável)
    TextEditingController tarefaControle = TextEditingController();
    //exibir uma janela
    showDialog(
      context:context,
      builder:(BuildContext context){
        return AlertDialog(
          title: Text('Adicionar Tarefa'),
          content: TextField(
            controller:tarefaControle,
            decoration: InputDecoration(labelText: 'Titulo da tarefa'),
          ),

          actions: <Widget>[
            TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
              ),
              onPressed: () {
                 Navigator.pop(context);
              },
              child: Text('Cancelar',style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
              ),
               onPressed:(){
                Provider.of<Controle_tarefa>(context, listen: false)
                .adicionar(tarefaControle.text);
                Navigator.pop(context);
               },
               child: Text('Adicionar',style: TextStyle(color: Colors.white)),
            ),
          ],
        ); //AlertDialog   
       },
    );
  }

}

class listaTarefas extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    //para fazer algo com o controle_tarefa
    return Consumer<Controle_tarefa>(
      builder: (context, controle_tarefa, child){

        //constroi listas longos ou infinitas de acordo com a demanda
        return ListView.builder(
          //informando qual sera o tamanho de lista

        

        itemCount: controle_tarefa.tarefas.length,
        //constrói um item da lista por vez
        itemBuilder: (context, index) {
          Modelo_tarefa modelo_tarefa = controle_tarefa.tarefas[index];
          return ListTile(

            title: Text(modelo_tarefa.titulo),
            subtitle: Text(index.toString()),
            leading: Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.green,
              hoverColor: Colors.lightBlue,
            value:modelo_tarefa.completa,
            onChanged: (value) {
            Provider.of<Controle_tarefa>(context,listen:false)
            .concluir(index);
            },

          ),

          trailing: IconButton(
            icon: Icon(Icons.delete,color: Colors.red),
           onPressed: () {
            Provider.of<Controle_tarefa>(context, listen: false).remover(index);
           } ) ,
           
          );
            
          




        },
       ); 
      },
    );
  }
}