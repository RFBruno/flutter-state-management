import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(125, 177, 11, 243),
                  Color.fromARGB(227, 5, 130, 202),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                      // esse dois pontos(..) serve para o flutter ententer o cascade
                      transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 24, 168, 187),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.black26,
                                offset: Offset(0, 2))
                          ]),
                      child: const Text(
                        'Minha Loja',
                        style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'Anto',
                          // color: Theme.of(context).textTheme.headline6.color
                        ),
                      ),
                    ),
                    const AuthForm()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
