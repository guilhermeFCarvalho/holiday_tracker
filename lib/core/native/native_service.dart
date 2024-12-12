import 'package:flutter/services.dart';

class NativeService {
  static const platform = MethodChannel('holiday_tracker');


  Future<void> showNotification(String title, String message) async {
    try {
      await platform.invokeMethod('showNotification', {
        'title': title,
        'message': message,
      });
    } on PlatformException catch (e) {
      print("Erro ao chamar o método nativo: ${e.message}");
    }
  }
}
