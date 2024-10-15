import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/enviroment.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infraestructure/intraestructure.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post('/auth/login', data: {'email': email, 'password': password});

      final user = UserMapper.userJsonToEntity(response.data);

      return user;

    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw WrongCredentials();
      if(e.type == DioExceptionType.connectionTimeout) throw ConnectionTimeout();
      throw CustomError('Something when wrong', 1);
    } catch (e) {
      throw CustomError('Something when wrong', 1);
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
