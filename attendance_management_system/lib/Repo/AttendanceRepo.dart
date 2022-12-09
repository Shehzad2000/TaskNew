import 'package:attendance_management_system/Model/AttendanceModel/AttendanceModel.dart';
import 'package:attendance_management_system/Model/SharedPreferences/GetCounts.dart';
import 'package:attendance_management_system/Model/SharedPreferences/SharedPreference.dart';
import 'package:attendance_management_system/Model/UserModel/UserRequestModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AttendanceRepo{

  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

  Future<int> addAttendance(AttendanceRequestModel requestModel) async{
    try{
      await firebaseFirestore.collection("tbl_Attendance").doc().set(requestModel.toSnapShot());
      return 200;
    }catch(e){
      return 400;
    }
  }

  Future<int> updateAttendance(AttendanceRequestModel requestModel) async{
    try{
      await firebaseFirestore.collection("tbl_Attendance").doc(requestModel.attendanceID).update(requestModel.toSnapShot());
      return 200;
    }catch(e){
      return 400;
    }
  }

  Future<int> deleteAttendance(String? id) async{
    try{
      await firebaseFirestore.collection("tbl_Attendance").doc(id).delete();
      return 200;
    }catch(e){
      return 400;
    }
  }

  Future<AttendanceRequestModel?> getAttendance(String? id) async{
    AttendanceRequestModel? requestModel;
    try{
      DocumentSnapshot documentSnapshot=await firebaseFirestore.collection("tbl_Attendance").doc(id).get();
      requestModel=AttendanceRequestModel.fromSnapShot(documentSnapshot);
      return requestModel;
    }catch(e){
      return null;
    }
  }

  Future<List<AttendanceRequestModel>> GetAllAttendanceByUserID(String? uID) async{
   QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_Attendance").get();
   List<AttendanceRequestModel> list=querySnapshot.docs.map((e) => AttendanceRequestModel.fromSnapShot(e)).toList();
   var data=list.where((a) => a.userID == uID).toList();
   getCounts(data, uID);
   for(var item in data){
     DocumentSnapshot documentSnapshot=await firebaseFirestore.collection("tbl_User").doc(item.userID).get();
      UserRequestModel userRequestModel=UserRequestModel.fromSnapShot(documentSnapshot);
    item.userName=userRequestModel.name;
   }

  return data;
  }
  Future<List<AttendanceRequestModel>?> fetchReportOfUser(String? uID, String? fromDate,String? toDate) async{
    String? StartDate=fromDate;
    String? EndDate=toDate;
    var startindex;
    var endindex;
    List<AttendanceRequestModel> newList=[];
    QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_Attendance").where("UserID",isEqualTo: uID).get();
    List<AttendanceRequestModel> list=querySnapshot.docs.map((e) => AttendanceRequestModel.fromSnapShot(e)).toList();
    for(var item in list){
      if(item.date==StartDate){
       startindex=list.indexOf(item);
      }else if(item.date==EndDate){
        endindex=list.indexOf(item);
      }
      if(startindex!=null&&endindex!=null){
        for(int i=endindex;i<=startindex;i++){
          newList.add(list[i]);
        }
        getCounts(newList, uID);
      }

     /* DocumentSnapshot documentSnapshot=await firebaseFirestore.collection("tbl_User").doc(item.userID).get();
      UserRequestModel userRequestModel=UserRequestModel.fromSnapShot(documentSnapshot);
      item.userName=userRequestModel.name;*/
    }
    return list;
  }
  Future<List<AttendanceRequestModel>?> GetAllAttendance() async{
   try{
     QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_Attendance").get();
     List<AttendanceRequestModel> list=querySnapshot.docs.map((e) => AttendanceRequestModel.fromSnapShot(e)).toList();
     for(var item in list){
       DocumentSnapshot documentSnapshot=await firebaseFirestore.collection("tbl_User").doc(item.userID).get();
       UserRequestModel userRequestModel=UserRequestModel.fromSnapShot(documentSnapshot);
       item.userName=userRequestModel.name;
     }
     return list;
   }on FirebaseException catch(e){
     return null;
   }
  }
void checkData() async{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_Attendance").get();
    List<AttendanceRequestModel> list=querySnapshot.docs.map((e) => AttendanceRequestModel.fromSnapShot(e)).toList();
    for(var item in list){
     if(item.date==DateFormat('dd/MM/yyyy').format(DateTime.now())){
       SharedPreference.check=false;
     }

    }
}
void getCounts(list,uID) async{
  var total=list.where((a) => a.userID == uID).toList();
  var Present=list.where((a) => a.status == "Present").toList();
  var Absent=list.where((a) => a.status == "Absent").toList();
  var Leave=list.where((a) => a.status == "Leave").toList();
GetCounts.uID=uID;
  GetCounts.TotalEntries=total.length;
  GetCounts.PresentCount=Present.length;
  GetCounts.AbsentCount=Absent.length;
  GetCounts.LeaveCount=Leave.length;
  GetCounts.percentage=(GetCounts.PresentCount/GetCounts.TotalEntries)*100;
 var gradecheck=GetCounts.percentage;
 if(gradecheck>=75){
   GetCounts.Grade="A";
 }else if(gradecheck>=55){
   GetCounts.Grade="B";
 }else if(gradecheck>=35){
   GetCounts.Grade="C";
 }else {
     GetCounts.Grade="D";
   }
  }
}