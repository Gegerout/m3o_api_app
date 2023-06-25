import '../usecases/user_usecase.dart';

abstract class Repository {
  Future<UserUseCase?> loginUser(String email, String password);
  Future<bool> createUser(String email, String password, String username);
  Future<UserUseCase?> getUser();
}