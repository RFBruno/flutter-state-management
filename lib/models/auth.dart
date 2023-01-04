import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  static const _urlBase = 'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const _keyDb = 'key=AIzaSyBlrU8Aic_39GF9_7JG3aTDMgj89aYOMTE';
  static const _signUp = 'signUp?';
  static const _signIn = 'signInWithPassword?';

  DateTime? _expiryDate;
  String? _token;
  String? _uid;
  String? _email; 

  bool get isAuth {
    final isValid =_expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }
 
  String? get uid {
    return isAuth ? _uid : null;
  }

  Future<void> autentication(
      String email, String password, String urlFragment) async {
    String url = _urlBase + urlFragment + _keyDb;
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );

    final body = jsonDecode(response.body);

    if(body['error'] != null){
      throw AuthException(body['error']['message']);
    }else{
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn'])
        )
      );
      notifyListeners();  
    }
  }

  Future<void> signUp(String email, String password) async {
    return autentication(email, password, _signUp);
  }

  Future<void> signIn(String email, String password) async {
    return autentication(email, password, _signIn);
  }
}
