import 'dart:async';

class UserNameValidator {
  final StreamTransformer<String,String> validateUserName = StreamTransformer<String,String>.fromHandlers(handleData: (userName, sink){
    if ( userName.toString().length < 6 || userName.isEmpty){
      sink.addError('Enter a valid user name');
    } else {
      sink.add(userName);
    }
  });
}