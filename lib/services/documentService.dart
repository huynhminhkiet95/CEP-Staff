import 'dart:io';

import 'package:qr_code_demo/httpProvider/HttpProviders.dart';
import 'package:qr_code_demo/services/service_constants.dart';
import 'package:http/http.dart';

class DocumentService {
  final HttpBase _httpBase;
  DocumentService(this._httpBase);

  Future<Response> getDocuments(dynamic body) {
    String url = ServiceName.GetDocuments.toString();
    return _httpBase.httpPostToken(url, body);
  }

  Future<Response> deleteDocuments(dynamic body) {
    String url = ServiceName.DeleteDocument.toString();
    return _httpBase.httpPostToken(url, body);
  }

  Future<StreamedResponse> saveImage(File file, int itemId) {
    return _httpBase.httpPostOpenalpr(file, itemId);
  }
}
