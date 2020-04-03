class TrainingCourse {
  String carType;
  String drivingLicense;
  String carForm;
  String idPhoto;
  String ibanPhoto;
  DateTime startDate;
  DateTime endDate;
  double cost;
  String trainerID;

  TrainingCourse(this.carType, this.drivingLicense, this.carForm, this.idPhoto,
      this.ibanPhoto, this.startDate, this.endDate, this.cost, this.trainerID);


  TrainingCourse.fromJson(Map <String, dynamic> jsonObject)
  {
this.carType = jsonObject['carType'];
this.drivingLicense = jsonObject['drivingLicense'];
this.carForm = jsonObject['carForm'];
this.idPhoto = jsonObject['idPhoto'];
this.ibanPhoto = jsonObject['ibanPhoto'];
this.startDate = jsonObject['startDate'];
this.endDate = DateTime.parse(jsonObject['endDate']);
this.cost = jsonObject['cost'];
this.trainerID = jsonObject['trainerID'];
  }
}
