import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:validatorless/validatorless.dart';

class ProjectRegisterPage extends StatefulWidget {
  final ProjectRegisterController controller;

  const ProjectRegisterPage({super.key, required this.controller});

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _estimateEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _estimateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        switch (state) {
          case ProjectRegisterStatus.success:
            AsukaSnackbar.success('Projeto salvo com sucesso').show();
            Navigator.pop(context);
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert('Erro ao salvar o projeto').show();
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Criar novo projeto',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameEC,
                    decoration: InputDecoration(
                      label: Text('Nome do projeto'),
                    ),
                    validator: Validatorless.required('Nome obrigat??rio'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _estimateEC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Estimativa de horas'),
                    ),
                    validator: Validatorless.multiple([
                      Validatorless.required('Estimativa obrigar??ria'),
                      Validatorless.number('S?? permitido somente n??mero')
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // BlocSelector<ProjectRegisterController, ProjectRegisterStatus,
                  //     bool>(
                  //   bloc: widget.controller,
                  //   selector: (state) => state == ProjectRegisterStatus.loading,
                  //   builder: (context, showLoading) {
                  //     return Visibility(
                  //       visible: showLoading,
                  //       child: Center(
                  //         child: CircularProgressIndicator.adaptive(),
                  //       ),
                  //     );
                  //   },
                  // ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 49,
                    child: ButtonWithLoader<ProjectRegisterController,
                        ProjectRegisterStatus>(
                      bloc: widget.controller,
                      selector: (state) =>
                          state == ProjectRegisterStatus.loading,
                      onPressed: () async {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;

                        if (formValid) {
                          final name = _nameEC.text;
                          final estimate = int.parse(_estimateEC.text);

                          await widget.controller.register(name, estimate);
                        }
                      },
                      label: 'Salvar',
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
