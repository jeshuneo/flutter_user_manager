import 'package:equatable/equatable.dart';

abstract class AddUserState extends Equatable {
  const AddUserState();

  @override
  List<Object> get props => [];
}

class AddUserInitial extends AddUserState {}

class AddUserLoading extends AddUserState {}

class AddUserSuccess extends AddUserState {}

class AddUserError extends AddUserState {
  final String message;

  const AddUserError(this.message);

  @override
  List<Object> get props => [message];
}
