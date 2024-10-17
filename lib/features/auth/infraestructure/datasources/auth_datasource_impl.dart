import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/enviroment.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infraestructure/intraestructure.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await  dio.get('/auth/check-status', options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        },
      ));

      final user = UserMapper.userJsonToEntity(response.data);

      return user;
      
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Invalid token');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post('/auth/login', data: {'email': email, 'password': password});

      final user = UserMapper.userJsonToEntity(response.data);

      return user;

    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message'] ?? 'User or Password Incorrect');
      }
      if(e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Timeout reached');
      } 
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
