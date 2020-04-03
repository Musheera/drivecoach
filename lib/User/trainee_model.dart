import 'user_model.dart';
import 'package:drivecoach/trainingcourse/request_course.dart';

class TraineeModel extends UserModel {
  TraineeModel(String id, String firstName, String lastName, String email,
      String passWord, String phone)
      : super(id, firstName, lastName, email, passWord, phone) {}

  TraineeModel.fromJson(Map<String, dynamic> jsonObject)
      : super(jsonObject['id'], jsonObject['firstName'], jsonObject['lastName'],
            jsonObject['email'], jsonObject['passWord'], jsonObject['phone']);
}
