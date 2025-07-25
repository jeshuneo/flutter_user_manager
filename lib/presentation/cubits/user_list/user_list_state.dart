import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<UserModel> users;

  const UserListLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserListError extends UserListState {
  final String message;

  const UserListError(this.message);

  @override
  List<Object> get props => [message];
}
