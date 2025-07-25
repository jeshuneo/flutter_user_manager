import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/errors/failures.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserRepository {
  late final ApiService _apiService;
  late final Dio _dio;

  UserRepository() {
    _dio = Dio();
    _dio.options.headers['Authorization'] = 'Bearer ${ApiConstants.token}';
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    _apiService = ApiService(_dio);
  }

  Future<List<UserModel>> getUsers() async {
    try {
      return await _apiService.getUsers();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Server error occurred');
    }
  }

  Future<UserModel> createUser(UserModel user) async {
    try {
      return await _apiService.createUser(user);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Failed to create user');
    }
  }
}