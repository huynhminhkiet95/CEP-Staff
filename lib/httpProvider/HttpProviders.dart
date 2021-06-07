import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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
    // var a = json.encode(body);
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
      //      final bytes = await file.readAsBytes();
      //    final img.Image image = img.decodeImage(bytes);
      // final img.Image resized1 = img.copyResize(image, width: 800);
      // String base64Image = resized1.
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
}
