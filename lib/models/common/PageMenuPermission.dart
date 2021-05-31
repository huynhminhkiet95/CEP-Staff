class PageMenuPermission {
  String menuId;
  String menuName;
  String pageId;
  String pageName;
  String isGroup;
  String prerentsMenu;
  String systemID;
  String icon;
  String component;
  bool delete;
  bool excel;
  bool save;
  bool preview;
  bool addnew;
  bool isUse;
  List<MenuChild> menuChilds;
  PageMenuPermission(
      {this.menuId,
      this.menuName,
      this.pageId,
      this.pageName,
      this.isGroup,
      this.prerentsMenu,
      this.systemID,
      this.icon,
      this.component,
      this.delete,
      this.excel,
      this.save,
      this.preview,
      this.addnew,
      this.isUse,
      this.menuChilds});

  factory PageMenuPermission.fromJson(Map<String, dynamic> json) {
    var _menuChilds = new List<MenuChild>();
    var menuChildJson = json["menuChils"].cast<Map<String, dynamic>>() as List;
    if (menuChildJson.length > 0) {
      _menuChilds = menuChildJson
          .map<MenuChild>((jsonItem) => MenuChild.fromJson(jsonItem))
          .toList();
    }

    return PageMenuPermission(
      menuId: json["menuId"] as String,
      menuName: json["menuName"] as String,
      pageId: json["pageId"] as String,
      pageName: json["pageName"] as String,
      isGroup: json["isGroup"] as String,
      prerentsMenu: json["prerentsMenu"] as String,
      systemID: json["systemID"] as String,
      icon: json["icon"] as String,
      component: json["component"] as String,
      delete: json["delete"] as bool,
      excel: json["excel"] as bool,
      save: json["save"] as bool,
      preview: json["preview"] as bool,
      addnew: json["addnew"] as bool,
      isUse: json["isUse"] as bool,
      menuChilds: _menuChilds
    );
  }
}

class MenuChild {
  String menuId;
  String menuName;
  String pageId;
  String pageName;
  String isGroup;
  String prerentsMenu;
  String systemID;
  String icon;
  String component;
  bool delete;
  bool excel;
  bool save;
  bool preview;
  bool addnew;
  bool isUse;

  MenuChild({
    this.menuId,
    this.menuName,
    this.pageId,
    this.pageName,
    this.isGroup,
    this.prerentsMenu,
    this.systemID,
    this.icon,
    this.component,
    this.delete,
    this.excel,
    this.save,
    this.preview,
    this.addnew,
    this.isUse,
  });

  factory MenuChild.fromJson(Map<String, dynamic> json) {
    return MenuChild(
      menuId: json["menuId"] as String,
      menuName: json["menuName"] as String,
      pageId: json["pageId"] as String,
      pageName: json["pageName"] as String,
      isGroup: json["isGroup"] as String,
      prerentsMenu: json["prerentsMenu"] as String,
      systemID: json["systemID"] as String,
      icon: json["icon"] as String,
      component: json["component"] as String,
      delete: json["delete"] as bool,
      excel: json["excel"] as bool,
      save: json["save"] as bool,
      preview: json["preview"] as bool,
      addnew: json["addnew"] as bool,
      isUse: json["isUse"] as bool,
    );
  }
}

class ListGroupMenuPermission {
  
  PageMenuPermission menu;

  ListGroupMenuPermission(this.menu);
}
