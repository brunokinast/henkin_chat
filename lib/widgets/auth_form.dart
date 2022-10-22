import 'package:henkin_chat/models/auth_data.dart';
import 'package:henkin_chat/widgets/alert_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class AuthForm extends StatefulWidget {
  final void Function(BuildContext, AuthData) onAuth;
  const AuthForm(this.onAuth);

  @override
  AuthFormState createState() => AuthFormState();
}

class AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authData = AuthData();

  _onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onAuth(context, _authData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    constraints: _authData.isSignUp
                        ? null
                        : const BoxConstraints(maxHeight: 0, maxWidth: 0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Cor das mensagens'),
                        ),
                        CircleAvatar(
                          backgroundColor: _authData.color,
                          radius: 40,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: _authData.color.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertColorPicker(
                                    _authData.color,
                                    (color) => setState(
                                        () => _authData.color = color)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    constraints: _authData.isSignUp
                        ? null
                        : const BoxConstraints(maxHeight: 0, maxWidth: 0),
                    child: TextFormField(
                      onChanged: (value) => _authData.name = value,
                      initialValue: _authData.name,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (_authData.isSignUp &&
                            (value == null ||
                                value.trim().isEmpty ||
                                value.trim().length < 3))
                          return 'Informe um nome com no mínimo 3 caracteres';
                        else if (value != null && value.length > 20)
                          return 'Informe um nome com no máximo 20 caracteres';
                        return null;
                      },
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (value) => _authData.email = value,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  validator: (value) {
                    if (value == null || !isEmail(value))
                      return 'Informe um e-mail válido';
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (value) => _authData.password = value,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (_authData.isSignUp &&
                        (value == null || value.trim().length < 7))
                      return 'Informe uma senha com no mínimo 7 caracteres';
                    return null;
                  },
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    constraints: _authData.isSignUp
                        ? null
                        : const BoxConstraints(maxHeight: 0, maxWidth: 0),
                    child: TextFormField(
                      obscureText: true,
                      decoration:
                          const InputDecoration(labelText: 'Repetir a senha'),
                      validator: (value) {
                        if (_authData.isSignUp && value != _authData.password)
                          return 'As senhas devem coincidir';
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: _onSubmit,
                    child: Text(_authData.isSignUp ? 'Cadastrar' : 'Entrar'),
                  ),
                ),
                TextButton(
                  child: Text(
                      '${_authData.isSignUp ? 'Já' : 'Não'} possui uma conta?'),
                  onPressed: () =>
                      setState(() => _authData.isSignUp = !_authData.isSignUp),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
