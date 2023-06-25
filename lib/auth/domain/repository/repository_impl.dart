import '../usecases/user_usecase.dart';

abstract class Repository {
  Future<UserUseCase?> loginUser(String email, String password);
}