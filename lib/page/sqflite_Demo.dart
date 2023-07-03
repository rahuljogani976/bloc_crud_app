import 'package:bloc_crud_app/bloc/bloc/crud_bloc.dart';
import 'package:bloc_crud_app/bloc/bloc/crud_event.dart';
import 'package:bloc_crud_app/page/add_todo.dart';
import 'package:bloc_crud_app/page/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SqFliteDemo extends StatefulWidget {
  const SqFliteDemo({Key? key}) : super(key: key);

  @override
  State<SqFliteDemo> createState() => _SqFliteDemoState();
}

class _SqFliteDemoState extends State<SqFliteDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        title: const Text('Bloc App'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const AddTodoPage()));
        },
      ),
      body: BlocBuilder<CrudBloc, CrudState>(
        builder: (context, state) {
          if (state is CrudInitial) {
            context.read<CrudBloc>().add(const FetchTodos());
          }
          if (state is DisplayTodos) {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  Center(
                    child: Text(
                      'ADD A TODO',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  state.todo.isNotEmpty
                      ? Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(8),
                      itemCount: state.todo.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            context.read<CrudBloc>().add(
                                FetchSpecificTodo(id: state.todo[i].id!));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) =>
                                const DetailsPage()),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            child: Card(
                              elevation: 10,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      state.todo[i].title.toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    subtitle:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8),
                                        Text(
                                          state.todo[i].description.toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          state.todo[i].note.toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              context
                                                  .read<CrudBloc>()
                                                  .add(DeleteTodo(
                                                  id: state
                                                      .todo[i].id!));
                                              ScaffoldMessenger.of(
                                                  context)
                                                  .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    content:
                                                    Text("deleted todo"),
                                                  ));
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      : const Text(''),
                ]),
              ),
            );
          }
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
