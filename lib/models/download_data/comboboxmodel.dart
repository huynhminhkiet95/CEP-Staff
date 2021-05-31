
class ComboboxModel {
  int serverId;
  String groupId;
  String groupText;
  String itemId;
  String itemText;

  ComboboxModel({this.serverId, this.groupId, this.groupText, this.itemId, this.itemText});

  ComboboxModel.fromJson(Map<String, dynamic> json) {
    if(json["ServerID"] is int)
      this.serverId = json["ServerID"];
    if(json["GroupID"] is String)
      this.groupId = json["GroupID"];
    if(json["GroupText"] is String)
      this.groupText = json["GroupText"];
    if(json["ItemID"] is String)
      this.itemId = json["ItemID"];
    if(json["ItemText"] is String)
      this.itemText = json["ItemText"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["ServerID"] = this.serverId;
    data["GroupID"] = this.groupId;
    data["GroupText"] = this.groupText;
    data["ItemID"] = this.itemId;
    data["ItemText"] = this.itemText;
    return data;
  }

  factory ComboboxModel.fromMap(Map<String, dynamic> json) =>
      new ComboboxModel(
          serverId: json["server_id"], 
          groupId: json["group_id"], 
          groupText: json["group_text"],
          itemId: json["item_id"],
          itemText: json["item_text"],
          );
}