import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';
import 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  final UserRepository _repository;

  AddUserCubit(this._repository) : super(AddUserInitial());

  Future<void> addUser({
    required String name,
    required String email,
    required String gender,
    required String status,
  }) async {
    emit(AddUserLoading());
    try {
      final user = UserModel(
        name: name,
        email: email,
        gender: gender,
        status: status,
      );
      await _repository.createUser(user);
      emit(AddUserSuccess());
    } catch (e) {
      emit(AddUserError(e.toString()));
    }
  }

  void reset() {
    emit(AddUserInitial());
  }
}
