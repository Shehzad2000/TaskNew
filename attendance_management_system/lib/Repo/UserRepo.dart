


import 'dart:io';

import 'package:attendance_management_system/Model/SharedPreferences/GetCounts.dart';
import 'package:attendance_management_system/Model/UserModel/UserRequestModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/SharedPreferences/SharedPreference.dart';

class UserRepo{
  final FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage=FirebaseStorage.instance;

  QuerySnapshot? querySnapshot;
  DocumentSnapshot? documentSnapshot;
UploadTask? _uploadTask;
  Future<int> signUp(UserRequestModel? requestModel) async{
    var myFile = File(requestModel!.path.toString());
    try{
      if(requestModel.image!=null){
      var snapshot =await  firebaseStorage.ref().child("Images/${requestModel.image}").putFile(myFile);
      var downloadUrl = await snapshot.ref.getDownloadURL();
     requestModel.image=downloadUrl;
      }
      await firebaseFirestore.collection("tbl_User").doc().set(requestModel.toSnapShot());
      return 200;
    }on FirebaseException catch(e){
      return 400;
    }
  }
  Future<int> signIn(UserRequestModel requestModel) async{
    try{
      querySnapshot=await firebaseFirestore.collection('tbl_User').where("Email",isEqualTo: requestModel.email).where("Password",isEqualTo: requestModel.password).get();
      if(querySnapshot!.docs.length>0){

       checkAdmin(querySnapshot!.docs[0].id);
       SharedPreference.isEventCall=true;
      }
      return 200;
    }on FirebaseException catch(e){
      return 400;
    }
  }
  Future<List<UserRequestModel>?> getAllUserDetails() async{
    try{
      querySnapshot=await firebaseFirestore.collection("tbl_User").get();
      List<UserRequestModel> list=querySnapshot!.docs.map((e) => UserRequestModel.fromSnapShot(e)).toList();

      return list;
    }catch(e){
     return null;
    }
  }
  Future<UserRequestModel?> getUserDetail(String? id) async{
    UserRequestModel? model;
    try{
      documentSnapshot=await firebaseFirestore.collection("tbl_User").doc(id).get();
      String image=await getImageUrl(documentSnapshot!["Image"]);
      model = UserRequestModel.fromSnapShot(documentSnapshot!);
      model.image = image;

    }catch(e){}
    return model;
  }




  Future<int> updateUserDetail(UserRequestModel requestModel) async{
    var myFile = File(requestModel.path.toString());
    try{
      if(requestModel.image!=null){
        var snapshot =await  firebaseStorage.ref().child("Images/${requestModel.image}").putFile(myFile);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        requestModel.image=downloadUrl;
      }
      await firebaseFirestore.collection("tbl_User").doc(requestModel.userID).update(requestModel.toSnapShot());
    getUserDetail(requestModel.userID);
      return 200;
    }on FirebaseException catch(e){
      return 400;
    }
  }
  Future<int> removeUser(String? id) async{
    try{
      await firebaseFirestore.collection("UserRegisteration").doc(id).delete();
      return 200;
    }on FirebaseException catch(e){
      return 400;
    }
  }


static Future<String> getImageUrl(String imgURL) async{
   //find your link in your storage console like this screenshot https://i.imgur.com/gW35HJk.png
   String? image;
    if(imgURL!="") {
      image=await firebaseStorage.refFromURL(imgURL).getDownloadURL();
    } else {
      image="";
    }
    return image;

}

  void checkAdmin(String uID) async{
 try{
   DocumentSnapshot snapshot=await firebaseFirestore.collection("tbl_User").doc(uID).get();
   UserRequestModel userRequestModel=UserRequestModel.fromSnapShot(snapshot);
   if(userRequestModel.isAdmin==true){
     SharedPreference.isAdmin=true;
   }
   SharedPreference.saveString("userID", uID);
 }on FirebaseException catch(e){
print(e);
 }
  }

}