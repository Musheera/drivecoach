
class RequestCourse {
  String traineeID;
  DateTime now = DateTime.now();

  RequestCourse(this.traineeID);


RequestCourse.fromJson(Map<String, dynamic> jsonObject){
  this.traineeID = jsonObject['traineeID'];

}
}
