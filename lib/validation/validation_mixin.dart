import 'dart:async';

class ValidationMixin {
  final validatorLogin = StreamTransformer<String, String>.fromHandlers(
    handleData: (login, sink) {
      sink.add(login);
    },
  );

  final validatorPassword =  StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 4) {
        sink.add(password);
      } else {
        sink.addError('Use better more than 6 characters!');
      }
    },
  );
}