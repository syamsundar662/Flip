import 'package:flip/data/models/user_model/user_model.dart';

abstract class UserRepository {
  void userAuthDataCollection(UserModel user);
  Future<UserModel?> fetchDataByUser(String uid);
  Future<List<UserModel>> searchUsersByUsername(String username);
}
