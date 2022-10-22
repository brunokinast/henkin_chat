import 'package:henkin_chat/models/auth_data.dart';
import 'package:henkin_chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;

  Future<void> _authHandler(BuildContext context, AuthData authData) async {
    setState(() => _isLoading = true);
    final fb = FirebaseAuth.instance;
    try {
      if (authData.isSignUp) {
        final user = await fb.createUserWithEmailAndPassword(
          email: authData.email,
          password: authData.password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.user!.uid)
            .set({
          'name': authData.name,
          'color': authData.color.value,
        });
      } else
        await fb.signInWithEmailAndPassword(
          email: authData.email,
          password: authData.password,
        );
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: const Text('Ocorreu um erro, verifique suas credenciais!'),
          backgroundColor: Theme.of(context).errorColor,
        ));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    AuthForm(_authHandler),
                    if (_isLoading)
                      Positioned.fill(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
