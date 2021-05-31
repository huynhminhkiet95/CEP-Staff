// import 'package:permission_handler/permission_handler.dart';

// class  CheckPermission{

//   void checkPermission(PermissionGroup permissionGroup)
//   {
//     PermissionHandler().checkPermissionStatus(permissionGroup).then((value)=>
//     {
//       updatePermisson(value)
//     });
//   }

//   void updatePermisson(PermissionStatus permissionStatus)
//   {
//     if(permissionStatus != PermissionStatus.granted)
//     {
//        requestPermission();
//     }
//   }

//   void requestPermission()
//   {
//     // final  permissions  = [PermissionGroup.location,PermissionGroup.contacts,
//     // PermissionGroup.camera,PermissionGroup.phone,PermissionGroup.calendar];
//     final  permissions  = [PermissionGroup.location];
//     PermissionHandler().requestPermissions(permissions).then(_statusRequested);
//   }

//   void _statusRequested(Map<PermissionGroup,PermissionStatus> statuses)
//   {
//     final status = statuses[PermissionGroup.location];
//     if(status != PermissionStatus.granted)
//     {
//       PermissionHandler().openAppSettings();
//     }else
//     {
//       updatePermisson(status);
//     }
//   }

//   static final CheckPermission _checkPermission = new CheckPermission._internal();
//   factory CheckPermission() {
//     return _checkPermission;
//   }
//   CheckPermission._internal();
// }

// CheckPermission checkPermissionGlobal = new CheckPermission();
