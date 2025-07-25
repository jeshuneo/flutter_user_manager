

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_manager/data/models/user_model.dart';
import 'package:user_manager/data/repositories/user_repository.dart';
import 'package:user_manager/presentation/cubits/user_list/user_list_cubit.dart';
import 'package:user_manager/presentation/cubits/user_list/user_list_state.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  const testUser = UserModel(
      id: 1,
      name: 'Test User',
      email: 'test@example.com',
      gender: 'male',
      status: 'active',
    );
  group('UserListCubit', () {
    late UserListCubit userListCubit;
    late MockUserRepository mockRepository;

    setUp(() {
      mockRepository = MockUserRepository();
      userListCubit = UserListCubit(mockRepository);
    });

    test('initial state is UserListInitial', () {
      expect(userListCubit.state, UserListInitial());
    });

    blocTest<UserListCubit, UserListState>(
      'emits [UserListLoading, UserListLoaded] when loadUsers is successful',
      build: () {
        when(
          () => mockRepository.getUsers(),
        ).thenAnswer((_) async => [testUser]);
        return userListCubit;
      },
      act: (cubit) => cubit.loadUsers(),
      expect: () => [
        UserListLoading(),
        const UserListLoaded([testUser]),
      ],
    );
  });
}
