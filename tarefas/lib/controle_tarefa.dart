
import 'package:flutter/material.dart';
import 'package:tarefas/modelo_tarefa.dart';

// change notifier comunica todos widgets que houve mudança
class Controle_tarefa extends ChangeNotifier {
  //criando lista de tarefas
  List<Modelo_tarefa> tarefas = [];

  //adicionar uma nova tarefa
  void adicionar(String conteudo) {
    tarefas.add(Modelo_tarefa(titulo: conteudo));
    notifyListeners();
  }

//remover tarefa
void remover(int id){
  tarefas.removeAt(id);
  notifyListeners();
}

//método para concluir uma tarefa ou não
void concluir(int id){
  tarefas[id].completa = !tarefas[id].completa;
  notifyListeners();
}


}