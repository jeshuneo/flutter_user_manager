import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/user_repository.dart';
import 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  final UserRepository _repository;

  UserListCubit(this._repository) : super(UserListInitial());

  Future<void> loadUsers() async {
    emit(UserListLoading());
    try {
      final users = await _repository.getUsers();
      emit(UserListLoaded(users));
    } catch (e) {
      emit(UserListError(e.toString()));
    }
  }

  void refreshUsers() {
    loadUsers();
  }
}
