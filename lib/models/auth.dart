import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const _url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBlrU8Aic_39GF9_7JG3aTDMgj89aYOMTE';

  Future<void> signup(String email, String password) async {    
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode({
        'email' : email,
        'password' : password,
        'returnSecureToken' : true
      }),
    );

    print(jsonDecode(response.body));
  }
}
