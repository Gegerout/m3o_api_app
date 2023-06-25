import 'package:m30_api_app/auth/data/data_sources/remote_data.dart';
import 'package:m30_api_app/auth/domain/repository/repository_impl.dart';
import 'package:m30_api_app/auth/domain/usecases/user_usecase.dart';

class DataRepository extends Repository {
  @override
  Future<UserUseCase?> loginUser(String email, String password) async {
    final data = await RemoteData().loginUser(email, password);
    if(data != null) {
      final usecase = UserUseCase(data);
      return usecase;
    }
    else {
      return null;
    }
  }

  @override
  Future<bool> createUser(String email, String password, String username) async {
    final data = await RemoteData().createUser(email, password, username);
    return data;
  }

}