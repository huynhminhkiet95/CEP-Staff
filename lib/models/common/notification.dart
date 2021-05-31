class NotificationModel {
  int id;
  int type;
  String title;
  String message;
  String platform;
  String createdate;
  int isRead;
  String issuedate;
  String receiver;

  NotificationModel(
      {this.id,
      this.title,
      this.type,
      this.message,
      this.platform,
      this.createdate,
      this.isRead,
      this.issuedate,
      this.receiver});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'message': message,
      'platform': platform,
      'createdate': createdate,
      'issuedate': issuedate,
      'userid': receiver,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      new NotificationModel(
        id: json["ReqId"] as int,
        type: json["TemplateId"],
        title: json["RequestTitle"],
        message: json["RequestMessage"],
        platform: '',
        createdate: getCreateDate(json["RequestDate"]),
        isRead: loadStatus(json["FinalStatusMessage"] ?? ''),
        issuedate: json["RequestDate"],
        receiver: json["Receiver"],
      );

  // factory NotificationModel.fromJson(Map<String, dynamic> json) =>
  //     new NotificationModel(
  //       id: json["id"] as int,
  //       type: json["type"],
  //       message: json["message"],
  //       platform: json["platform"],
  //       createdate: json["createdate"],
  //       isRead: json["isRead"],
  //       issuedate: json["issuedate"],
  //       fleetid: json["fleetid"],
  //       userid: json["userid"],
  //     );
}

int loadStatus(String status) {
  switch (status.toUpperCase()) {
    case 'NEW':
     case '':
      return 0;
    default:
      return 1;
  }
}

String getCreateDate(String date) {
  if(date != null && date.length > 19){
    return date.substring(0, 16);
  }
  return date;
}
