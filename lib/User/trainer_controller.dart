import 'package:drivecoach/trainingcourse/trining_course.dart';
import 'trainer_model.dart';
class TrainerController{

  TrainerModel _trinerModel;

  TrainerController(this._trinerModel);

  void addCourse(TrainingCourse trainingCourse) {
    this._trinerModel.trainingCourse.add(trainingCourse);
  }

  bool update() {}

  bool deleteCourse(TrainingCourse trainingCourse) {
    this._trinerModel.trainingCourse.remove(trainingCourse);

  }
  }
