import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import '../../core/database/database.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final db = Modular.get<Database>();

                final connection = await db.openConnection();

                connection.writeTxn((isar) {
                  var project = Project();

                  project.name = 'Projeto Teste';
                  project.status = ProjectStatus.finalizado;

                  return connection.projects.put(project);
                });
              },
              child: Text('Cadastrar'),
            ),
          ],
        ));
  }
}
