import 'user_model.dart';
import 'package:drivecoach/trainingcourse/trining_course.dart';

class TrainerModel extends UserModel {
  String licensePhoto;
  List<TrainingCourse> trainingCourse;

  TrainerModel(String id, String firstName, String lastName, String email,
      String passWord, String phone, List <TrainingCourse> trainingCourse)
      : super(id, firstName, lastName, email, passWord, phone) {
    this.licensePhoto = licensePhoto;
    this.trainingCourse = trainingCourse;
  }
  
  TrainerModel.fromJson (Map<String, dynamic> jsonObject):super(jsonObject['id'], jsonObject['firstName'], jsonObject['lastName'],
  jsonObject['email'], jsonObject['passWord'], jsonObject['phone']){
    TrainingCourse.fromJson(jsonObject['trainingCourse']);
    this.licensePhoto = jsonObject['licensePhoto'];
  }
}
