import 'package:bloc_crud_app/models/todo.dart';
import 'package:equatable/equatable.dart';

abstract class CrudEvent extends Equatable {
  const CrudEvent();
}

class AddTodoEvent extends CrudEvent {
  final String title;
  final bool isImportant;
  final int number;
  final String description;
  final DateTime createdTime;
  final String note;
  final String rememberTask;

  const AddTodoEvent(
      {required this.title,
        required this.isImportant,
        required this.number,
        required this.description,
        required this.createdTime,
        required this.note,
        required this.rememberTask,
      });

  @override
  List<Object?> get props =>
      [title, isImportant, number, description, createdTime,note,rememberTask];
}

class UpdateTodo extends CrudEvent {
  final Todo todo;
  const UpdateTodo({required this.todo});
  @override
  List<Object?> get props => [todo];
}

class FetchTodos extends CrudEvent {
  const FetchTodos();

  @override
  List<Object?> get props => [];
}

class FetchSpecificTodo extends CrudEvent {
  final int id;
  const FetchSpecificTodo({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteTodo extends CrudEvent {
  final int id;
  const DeleteTodo({required this.id});
  @override
  List<Object?> get props => [id];
}
