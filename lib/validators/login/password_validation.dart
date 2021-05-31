import 'dart:async';

class PasswordValidator {
  final StreamTransformer<String,String> validatePassword = StreamTransformer<String,String>.fromHandlers(handleData: (password, sink){
    if (password.isEmpty){
      sink.addError('Enter a valid password');
    } else {
      sink.add(password);
    }
  });
}