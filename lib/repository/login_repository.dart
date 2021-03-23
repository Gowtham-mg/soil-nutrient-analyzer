import 'package:soilnutrientanalyzer/app_response.dart';
import 'package:soilnutrientanalyzer/model/user.dart';

abstract class AuthRepository {
  Future<AppResponse<User>> signIn(String email, String password);
  Future<AppResponse<User>> signUp(String email, String password);
  Future<AppResponse<User>> googleAuth();
}
