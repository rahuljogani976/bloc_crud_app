import 'package:bloc_crud_app/bloc/bloc/crud_bloc.dart';
import 'package:bloc_crud_app/bloc/bloc/crud_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_text.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);
  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _note = TextEditingController();
  bool toggleSwitch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Add Todo".toUpperCase(),style: const TextStyle(fontSize: 15,color: Colors.white)),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 25),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomText(text: 'Title',),
              TextFormField(
                controller: _title,
              ),
              const SizedBox(height: 15),
              const CustomText(text: 'Description'),
              TextFormField(controller: _description),
              const SizedBox(height: 15),
              const CustomText(text: 'Note'),
              TextFormField(controller: _note),
              const SizedBox(height: 15),
              const CustomText(text: 'Important'),
              Center(
                child: Switch(
                  value: toggleSwitch,
                  onChanged: (newVal) {
                    setState(() {
                      toggleSwitch = !toggleSwitch;
                    });
                  },
                ),
              ),
              BlocBuilder<CrudBloc, CrudState>(
                builder: (context, state) {
                  return Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent, foregroundColor: Colors.white),
                        onPressed: () {
                          if (_title.text.isNotEmpty &&
                              _description.text.isNotEmpty && _note.text.isNotEmpty) {
                            context.read<CrudBloc>().add(
                              AddTodoEvent(
                                title: _title.text,
                                isImportant: toggleSwitch,
                                number: 0,
                                description: _description.text,
                                note: _note.text,
                                createdTime: DateTime.now(),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text("todo added successfully"),
                            ));
                            context.read<CrudBloc>().add(const FetchTodos());
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "title and description fields must not be blank"
                                      .toUpperCase()),
                            ));
                          }
                        },
                        child: const Text('Add Todo')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
