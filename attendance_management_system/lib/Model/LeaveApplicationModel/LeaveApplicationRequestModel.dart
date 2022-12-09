class LeaveApplicationRequestModel {
  String? leaveApplicationID;
  String? userID;
  String? type;
  String? duration;
  String? description;
  String? fromDate;
  String? toDate;
  String? status;

  LeaveApplicationRequestModel(
      {this.leaveApplicationID,this.type,this.duration,this.description,this.userID, this.fromDate, this.toDate, this.status});

  LeaveApplicationRequestModel.fromSnapShot(json) {
    leaveApplicationID=json.id;
    type=json['Type'];
    duration=json['Duration'];
    description=json['Description'];
    userID = json['UserID'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    status = json['Status'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeaveApplicationID'] = this.leaveApplicationID;
    data['Type'] = this.type;
    data['Duration'] = this.duration;
    data['Description'] = this.description;
    data['UserID'] = this.userID;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['Status'] = this.status;
    return data;
  }
}