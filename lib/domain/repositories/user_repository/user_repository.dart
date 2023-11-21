import 'package:flip/domain/models/user_model/user_model.dart';

abstract class UserRepository {
  void userAuthDataCollection(UserModel user);
  Future<UserModel?> fetchDataByUser(String uid);
}
