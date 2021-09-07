import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:qr_code_demo/globalServer.dart';
import 'package:async/async.dart';
import '../GlobalUser.dart';

class HttpBase {
  Future<http.Response> httpGet(String url) async {
    try {
      var address = globalServer.getServerAddress;
      var result = await http.get(address + url, headers: {
        "Content-Type": 'application/json'
      }).timeout(const Duration(seconds: 10));
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> httpGetToken(String url) async {
    try {
      String token = globalUser.gettoken;
      var address = globalServer.getServerApi;
      var result = await http.get(address + url, headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      }).timeout(const Duration(seconds: 10));

      return result;
    } catch (e) {
      return httpGetToken(url);
    }
  }

  Future<http.Response> httpGetHub(String url) async {
    try {
      var result = await http.get(globalServer.getServerHub + url, headers: {
        "Content-Type": 'application/json',
      }).timeout(const Duration(seconds: 10));
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> httpPutHub(String url) async {
    try {
      var result = await http.put(globalServer.getServerHub + url, headers: {
        "Content-Type": 'application/json',
      }).timeout(const Duration(seconds: 10));
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> httpPostHubNoBody(String url, dynamic body) async {
    try {
      var result = await http.post(globalServer.getServerHub + url,
          //body: json.encode(body),
          headers: {
            "Content-Type": 'application/json'
          }).timeout(const Duration(seconds: 10));
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> httpPostHub(String url, dynamic body) async {
    try {
      var result = await http.post(globalServer.getServerHub + url,
          body: json.encode(body),
          headers: {
            "Content-Type": 'application/json'
          }).timeout(const Duration(seconds: 10));

      return result;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> httpGetAsync(String url) async {
    try {
      var address = globalServer.getServerAddress;
      var result = await http.get(address + url, headers: {
        "Content-Type": 'application/json',
      }).timeout(const Duration(seconds: 10));

      return result;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> httpGetApi(String url) async {
    try {
      var address = globalServer.getServerApi;
      var result = await http.get(address + url, headers: {
        "Content-Type": 'application/json'
      }).timeout(const Duration(seconds: 10));
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> httpPostAsync(String url, dynamic body) async {
    try {
      var address = globalServer.getServerAddress;
      var result = await http.post(address + url,
          body: json.encode(body),
          headers: {
            "Content-Type": 'application/json'
          }).timeout(const Duration(seconds: 10));

      return result;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> httpPostApi(String url, dynamic body) async {
    try {
      var address = globalServer.getServerApi;
      var result = await http.post(address + url,
          body: json.encode(body),
          headers: {
            "Content-Type": 'application/json'
          }).timeout(const Duration(seconds: 10));

      return result;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> httpPost(String url, dynamic body) {
    try {
      var address = globalServer.getServerAddress;
      var result = http.post(address + url, body: json.encode(body), headers: {
        "Content-Type": 'application/json'
      }).timeout(const Duration(seconds: 10));
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> httpPostToken(String url, dynamic body) async {
    String token = globalUser.gettoken;
    var address = globalServer.getServerAddress;
    var a = json.encode(body);
    http.Response result;
    try {
      result = await http.post(address + url,
          body: json.encode(body),
          headers: {
            "Content-Type": 'application/json',
            "Authorization": 'Bearer $token'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      print(url + ": " + e.message);
      // result.statusCode = 4;
      return null;
    }
    return result;
  }

  Future<http.Response> httpPostTokenNotBody(String url) async {
    String token = globalUser.gettoken;
    var address = globalServer.getServerAddress;
    http.Response result;
    try {
      result = await http.post(address + url, headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      }).timeout(const Duration(seconds: 10));
    } catch (e) {
      print(url + ": " + e.message);
      // result.statusCode = 4;
      return null;
    }

    return result;
  }

  Future<http.Response> postRequest(String url, dynamic body) async {
    var response;
    try {
      var address = globalServer.getServerApi + url;
      var jsonBody = json.encode(body);
      response = await http
          .post(address,
              headers: {"Content-Type": "application/json"}, body: jsonBody)
          .timeout(const Duration(seconds: 20));
      return response;
    } catch (e) {
      //throw Exception(e);
      return response;
    }
  }

  Future<http.Response> postRequestTest(String url, dynamic body) async {
    var response;
    var body1 = {"sdt": '0969875777', "password": '123321'};

    try {
      var address = 'https://testapi.cep.org.vn/api/Users/Login';
      var jsonBody = json.encode(body1);
      response = await http
          .post(address,
              headers: {"Content-Type": "application/json"}, body: jsonBody)
          .timeout(const Duration(seconds: 10));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> httpPostEncoded(String url, dynamic body) async {
    var address = globalServer.getServerApi + url;
    var jsonBody = json.encode(body);
    var response;
    try {
      response = await http.post(address,
          headers: {"Content-Type": "application/json"}, body: jsonBody);
    } catch (e) {
      //result.statusCode =
    }

    return response;
  }

  Future<http.Response> httpGetSSO(String url) async {
    try {
      String token = globalUser.gettoken;
      var address = globalServer.getServerSSO;
      var result = await http.get(address + url, headers: {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      }).timeout(const Duration(seconds: 10));

      return result;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> httpPostSSO(String url, dynamic body) async {
    String token = globalUser.gettoken;
    var address = globalServer.getServerSSO;
    http.Response result;
    try {
      result = await http.post(address + url,
          body: json.encode(body),
          headers: {
            "Content-Type": 'application/json',
            "Authorization": 'Bearer $token'
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return null;
    }

    return result;
  }

  Future<http.StreamedResponse> httpPostOpenalpr(
      File file, int refNoValue) async {
    try {
      String token = globalUser.gettoken;
      Map<String, String> headers = {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token'
      };
      var uri = Uri.parse(
          "https://fbmp.enterprise.vn:9110/api/document/savedocument");
      var request = new http.MultipartRequest("POST", uri);
      request.headers.addAll(headers);
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();

      var multipartFile = new http.MultipartFile(
        'image',
        stream,
        length,
        filename: new DateTime.now().millisecondsSinceEpoch.toString() + '.jpg',
      );

      request.fields['docRefType'] = 'TRR';
      request.fields['refNoType'] = 'TRR';
      request.fields['refNoValue'] = refNoValue.toString();
      request.fields['createUser'] = globalUser.getId.toString();
      request.fields['userId'] = globalUser.getId.toString();
      print({"createuser": globalUser.getId});
      request.files.add(multipartFile);

      var result = await request.send().timeout(const Duration(seconds: 10));
      print({"292_reasonPhrase": result.reasonPhrase});
      return result;
    } catch (e) {
      print({"294": e});
      return null;
    }
  }

  String getFileSize(int file, int decimals) {
    int bytes = file;
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  Future<dynamic> httpPostDocument(File file) async {
    try {
      int a = await file.length();
      print(getFileSize(a, 2));
      var address = globalServer.getServerAddress;
      String token = globalUser.gettoken;
      Response response;
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path,
            filename: fileName,
            contentType: MediaType("image", basename(file.path))),
      });
      response = await dio.post(address + 'api/NhanVien/UploadImageByFormFile',
          data: formData);
      print("object");
      return response;
    } catch (e) {
      print({"294": e});
      return null;
    }
  }

  Future<dynamic> uploadImage1(File _image) async {
    var address = globalServer.getServerAddress;
    // open a byteStream
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    // get file length
    var length = await _image.length();

    // string to uri
    var uri = Uri.parse(address + 'api/NhanVien/UploadImageByFormFile');

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request
    //request.fields["user_id"] = "text";

    // multipart that takes file.. here this "image_file" is a key of the API request
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(_image.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<http.Response> getTestApiLocal() async {
    try {
      var address = 'https://10.0.2.2:44326/WeatherForecast/Get1231';
      var result = await http.get(address, headers: {
        "Content-Type": 'application/json',
      }).timeout(const Duration(seconds: 10));
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  // uploadFileFromDio(File photoFile) async {
  //   var dio = new Dio();
  //   dio.options.baseUrl = 'http://10.10.0.36:8889/api/NhanVien/UploadImageByFormFile';
  //   dio.options.connectTimeout = 5000; //5s
  //   dio.options.receiveTimeout = 5000;
  //   FormData formData = new FormData();
  //   formData.add("user_id", userProfile.userId);
  //   formData.add("name", userProfile.name);
  //   formData.add("email", userProfile.email);

  //   if (photoFile != null &&
  //       photoFile.path != null &&
  //       photoFile.path.isNotEmpty) {
  //     // Create a FormData
  //     String fileName = basename(photoFile.path);
  //     print("File Name : $fileName");
  //     print("File Size : ${photoFile.lengthSync()}");
  //     formData.add("user_picture", new UploadFileInfo(photoFile, fileName));
  //   }
  //   var response = await dio.post("user/manage_profile",
  //       data: formData,
  //       options: Options(
  //           method: 'POST',
  //           responseType: ResponseType.PLAIN // or ResponseType.JSON
  //           ));
  //   print("Response status: ${response.statusCode}");
  //   print("Response data: ${response.data}");
  // }
}
