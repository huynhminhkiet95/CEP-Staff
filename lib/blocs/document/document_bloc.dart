import 'dart:convert';
import 'dart:io';

import 'package:qr_code_demo/bloc_helpers/bloc_event_state.dart';
import 'package:qr_code_demo/blocs/document/document_event.dart';
import 'package:qr_code_demo/blocs/document/document_state.dart';
import 'package:qr_code_demo/models/document/documentresult.dart';
import 'package:qr_code_demo/services/documentService.dart';
import 'package:qr_code_demo/services/sharePreference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

class DocumentBloc extends BlocEventStateBase<DocumentEvent, DocumentState> {
  final SharePreferenceService sharePreferenceService;
  final DocumentService documentService;

  DocumentBloc(this.sharePreferenceService, this.documentService)
      : super(initialState: DocumentState.init());

  BehaviorSubject<List<GetDocumentResult>> _getDocumentsController =
      BehaviorSubject<List<GetDocumentResult>>();

  BehaviorSubject<List<GetDocumentResult>> _setDocumentsController =
      BehaviorSubject<List<GetDocumentResult>>();
  Stream<List<GetDocumentResult>> get getDocumentsController =>
      _setDocumentsController;

  @override
  void dispose() {
    _getDocumentsController?.close();
    _setDocumentsController?.close();
    super.dispose();
  }

  @override
  Stream<DocumentState> eventHandler(
      DocumentEvent event, DocumentState state) async* {
    if (event is LoadDocumentInfoEvent) {
      yield DocumentState.updateLoading(true);
      var documentResult = new List<GetDocumentResult>();

      var response = await documentService.getDocuments(event.documentInfo);
      if (response == null) {
        yield DocumentState.updateLoading(false);
        return;
      }
      if (response.statusCode == 200) {
        yield DocumentState.updateLoading(false);
        var dataJson = json.decode(response.body);
        var documentJson =
            dataJson["payload"].cast<Map<String, dynamic>>() as List;
        if (documentJson.length > 0) {
          documentResult = documentJson
              .map<GetDocumentResult>(
                  (json) => GetDocumentResult.fromJson(json))
              .toList();
          _setDocumentsController.sink.add(documentResult);
        }
      }
    }
    if (event is DeleteDocumentEvent) {
      var response = await documentService.deleteDocuments(event.documentInfo);
      if (response == null) {
        return;
      }
      if (response.statusCode == 200) {
        var dataJson = json.decode(response.body);
        if (dataJson["payload"] > 0) {
          Fluttertoast.showToast(
              msg: "Delete Image success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.blueAccent,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }
    if (event is SaveDocumentEvent) {
      File fileImage = File(event.fileName);
      var response = await documentService.saveImage(fileImage, event.item);
      if (response.reasonPhrase == "OK") {
        Fluttertoast.showToast(
            msg: "Save Image success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
