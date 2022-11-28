import 'package:flutter_crud/db_helper/repository.dart';

import '../model/user.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }
  //save user
  saveUser(User user) async {
    return await _repository.insertData('Users', user.userMap());
  }

  //read all user
  readAllUsers() async {
    return await _repository.readData('Users');
  }

  updateUser(User user) async {
    return await _repository.updateData('Users', user.userMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('Users', userId);
  }
}
