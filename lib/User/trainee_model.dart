import 'user_model.dart';

class TraineeModel extends UserModel {
  TraineeModel(String id, String firstName, String lastName, String email,
      String passWord, String phone)
      : super(id, firstName, lastName, email, passWord, phone);
}
