import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceRequestModel {
  String? attendanceID;
  String? date;
  String? status;
  String? userID;
  String? userName;

  AttendanceRequestModel(
      {this.attendanceID, this.date, this.status, this.userID,this.userName});

  AttendanceRequestModel.fromSnapShot(DocumentSnapshot json) {
    attendanceID = json.id;
    date = json['Date'];
    status = json['Status'];
    userID = json['UserID'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['Status'] = this.status;
    data['UserID'] = this.userID;
    return data;
  }
}