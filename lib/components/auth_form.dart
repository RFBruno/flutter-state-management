import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {'email': '', 'password': ''};

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  void _switchAuthMode() {
    setState(() {
      _authMode =
          _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
    });
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth _auth = Provider.of<Auth>(context, listen: false);
    if (isValid) {
      try {
        if (_isLogin()) {
          await _auth.signIn(_authData['email']!, _authData['password']!);
        } else {
          await _auth.signUp(_authData['email']!, _authData['password']!);
        }
      } on AuthException catch (e) {
        _showDialog(e.toString());
      } catch (e) {
        _showDialog('Ocorreu um erro inesperado.');
      }
    }

    setState(() => _isLoading = false);
  }

  void _showDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: _isLogin() ? 320 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.trim().isEmpty || !email.contains('@')) {
                      return 'Informe um e-mail válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  obscureText: true,
                  onSaved: (password) => _authData['password'] = password ?? '',
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.trim().isEmpty || password.length < 5) {
                      return 'Informe uma senha valida';
                    }
                    return null;
                  },
                ),
                if (_isSignup())
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirmar senha',
                    ),
                    obscureText: true,
                    validator: _isLogin()
                        ? null
                        : (_password) {
                            final password = _password ?? '';
                            if (password != _passwordCtrl.text) {
                              return 'Senhas informadas não coferem';
                            }
                          },
                  ),
                const SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8)),
                        child: Text(_isLogin() ? 'ENTRAR' : 'REGISTRAR'),
                      ),
                const Spacer(),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                      _isLogin() ? 'DESEJA REGISTRAR?' : 'JÁ POSSUI CONTA?'),
                )
              ],
            )),
      ),
    );
  }
}
