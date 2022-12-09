import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/LeaveApplicationModel/LeaveApplicationRequestModel.dart';

class LeaveApplicationRepo{
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  Future<int> sendLeaveApplication(LeaveApplicationRequestModel requestModel) async{
    try{
      await firebaseFirestore.collection("tbl_LeaveApplication").doc().set(requestModel.toSnapShot());
      return 200;
    }catch(e){
      return 400;
    }
  }
  Future<int> updateLeaveApplication(LeaveApplicationRequestModel requestModel) async{
    try{
      await firebaseFirestore.collection('tbl_LeaveApplication').doc(requestModel.leaveApplicationID).update(requestModel.toSnapShot());
      return 200;
    }catch(e){
      return 400;
    }
  }
  Future<List<LeaveApplicationRequestModel>> getAllLeaveApplication() async{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_LeaveApplication").get();
    List<LeaveApplicationRequestModel> list=querySnapshot.docs.map((e) => LeaveApplicationRequestModel.fromSnapShot(e)).toList();
    return list;
  }
  Future<List<LeaveApplicationRequestModel>> getAllLeaveApprovalEventByUserID(String? id) async{
    List<LeaveApplicationRequestModel> list=[];
    try{
      QuerySnapshot querySnapshot=await firebaseFirestore.collection('tbl_LeaveApplication').get();
      list = querySnapshot.docs.map((data) =>
          LeaveApplicationRequestModel.fromSnapShot(data)).toList();
      list.where((element) => element.userID==id).toList();
      return list;
    }on FirebaseException catch(e){
      return list;
    }
  }
}