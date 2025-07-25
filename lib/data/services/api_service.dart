import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../core/constants/api_constants.dart';
import '../models/user_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(ApiConstants.users)
  Future<List<UserModel>> getUsers();

  @POST(ApiConstants.users)
  Future<UserModel> createUser(@Body() UserModel user);
}
