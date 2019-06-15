import 'dart:async';

class LoginValidators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains("@")) {
          sink.add(email);
      } else {
          sink.addError("Entre com um endereço de e-mail válido.");
      }
    }
  );
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length > 4) {
          sink.add(password);
        } else {
          sink.addError("Entre com uma senha válida.");
        }
      }
  );
}