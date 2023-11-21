import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_bloc.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_event.dart';
import 'package:motelhub_flutter/presentation/blocs/login/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  _buildBody() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.of(context).pushNamed('/home');
        }
        if (state is LoginErrorState) {
          showAlertDialog(context, 'Login failed');
        }
      },
      builder: (context, state) {
        if (state is LoginLoadingState) {
          return const Center(child:  CupertinoActivityIndicator());
        }
        
        return _loginForm(context);
      },
    );
  }

  Widget _loginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 600
          ),
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
          child: Column(
            children: [
              AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset('assets/images/login_logo.png')),
              const Text("Welcome back!", style: TextStyle(fontSize: 50)),
              const SizedBox(height: 50),
              TextField(
                onChanged: (value) {
                  context.read<LoginBloc>().add(UsernameChangeEvent(value));
                },
                decoration: InputDecoration(
                  label: const Text("Username"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  context.read<LoginBloc>().add(PasswordChangeEvent(value));
                },
                obscureText: true,
                decoration: InputDecoration(
                  label: const Text("Password"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginButtonEvent());
                  },
                  child: const Text("Login")),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        height: 1.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _squareIconButton(const Image(
                      image: AssetImage(
                          'assets/images/google_icon.png'), // Replace with the desired Google icon
                    )),
                    _squareIconButton(const Image(
                      image: AssetImage(
                          'assets/images/facebook_icon.png'), // Replace with the desired Google icon
                    )),
                    _squareIconButton(const Icon(Icons.phone))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account?"),
                    TextButton(onPressed: ()=>{}, child: const Text('Register now'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _squareIconButton(Widget icon) {
    return Container(
        width: 48.0, // Adjust the width and height as needed
        height: 48.0,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius:
              BorderRadius.circular(8.0), // Adjust the border radius as needed
        ),
        child: InkWell(
          onTap: () {
            // Handle button tap
          },
          child: icon,
        ));
  }
}

  showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
