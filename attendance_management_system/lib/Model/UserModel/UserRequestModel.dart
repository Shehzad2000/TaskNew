
import 'package:attendance_management_system/Repo/UserRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRequestModel {
  String? userID;
  String? name;
  String? email;
  String? password;
  String? gender;
  String? path;
  var image;
  bool? isAdmin;
  String? registerationDate;
  int? status;

  UserRequestModel(
      {this.userID,
        this.name,
        this.email,
        this.path,
        this.password,
        this.gender,
        this.image,
        this.isAdmin,
        this.registerationDate,
        this.status});

  UserRequestModel.fromSnapShot(DocumentSnapshot json) {
    userID = json.id;
    name = json['Name'];
    email = json['Email'];
    password = json['Password'];
    gender = json['Gender'];
    image = json['Image'];
    isAdmin = json['IsAdmin'];
    registerationDate = json['RegisterationDate'];
    status = json['Status'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = this.userID;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Gender'] = this.gender;
    data['Image'] = this.image;
    data['IsAdmin'] = this.isAdmin;
    data['RegisterationDate'] = this.registerationDate;
    data['Status'] = this.status;
    return data;
  }
}