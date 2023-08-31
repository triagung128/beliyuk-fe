import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/common/global_variables.dart';
import 'package:beliyuk/presentation/blocs/auth/auth_bloc.dart';
import 'package:beliyuk/presentation/pages/auth/widgets/auth_text_form_field.dart';
import 'package:beliyuk/presentation/pages/auth/widgets/button_auth.dart';

enum AuthFormMode { login, signup }

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthFormMode _authFormMode = AuthFormMode.login;

  bool _passwordHide = true;
  bool _confirmPasswordHide = true;

  final GlobalKey<FormState> _authFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _login() {
    context.read<AuthBloc>().add(DoLoginEvent(
          identifier: _emailController.text,
          password: _passwordController.text,
        ));
  }

  void _register() {
    context.read<AuthBloc>().add(DoRegisterEvent(
          username: _emailController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ));
  }

  void _submit() {
    if (_authFormMode == AuthFormMode.login) {
      _login();
    } else if (_authFormMode == AuthFormMode.signup) {
      _register();
    }
  }

  void _switchMode() {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _authFormMode == AuthFormMode.login
          ? _authFormMode = AuthFormMode.signup
          : _authFormMode = AuthFormMode.login;
    });

    _emailController.text = '';
    _passwordController.text = '';
    _confirmPasswordController.text = '';

    _authFormKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            _authFormMode == AuthFormMode.login ? 'Masuk' : 'Daftar',
          ),
          actions: [
            TextButton(
              onPressed: () => _switchMode(),
              child: Text(
                _authFormMode == AuthFormMode.login ? 'Daftar' : 'Masuk',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.state == RequestState.error) {
              _scaffoldMessengerKey.currentState!
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red[400],
                  ),
                );
            } else if (state.state == RequestState.loaded) {
              Navigator.pop(context, GlobalVariables.successLogin);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _authFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  AuthTextFormField(
                    key: const Key('email_field'),
                    controller: _emailController,
                    labelText: 'Email',
                    marginBottom: 16,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong!';
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return 'Email tidak valid!';
                      }
                      return null;
                    },
                  ),
                  AuthTextFormField(
                    key: const Key('password_field'),
                    controller: _passwordController,
                    labelText: 'Password',
                    marginBottom: 16,
                    obscureText: _passwordHide,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordHide = !_passwordHide;
                        });
                      },
                      icon: Icon(_passwordHide
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 6) {
                        return 'Password min. 6 karakter';
                      }
                      return null;
                    },
                  ),
                  if (_authFormMode == AuthFormMode.signup)
                    AuthTextFormField(
                      key: const Key('confirm_password_field'),
                      controller: _confirmPasswordController,
                      labelText: 'Konfirmasi Password',
                      obscureText: _confirmPasswordHide,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _confirmPasswordHide = !_confirmPasswordHide;
                          });
                        },
                        icon: Icon(_confirmPasswordHide
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi Password tidak boleh kosong';
                        }
                        if (value.trim() != _passwordController.text.trim()) {
                          return 'Password tidak sama';
                        }
                        return null;
                      },
                    ),
                  ButtonAuth(
                    onPressed: () {
                      if (_authFormKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _submit();
                      }
                    },
                    title: _authFormMode == AuthFormMode.login
                        ? 'Masuk'
                        : 'Daftar',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _authFormMode == AuthFormMode.login
                            ? 'Belum memiliki akun? '
                            : 'Sudah memiliki akun? ',
                      ),
                      GestureDetector(
                        onTap: () => _switchMode(),
                        child: Text(
                          _authFormMode == AuthFormMode.login
                              ? 'Daftar'
                              : 'Masuk',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }
}
