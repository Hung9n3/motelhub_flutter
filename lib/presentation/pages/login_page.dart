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
    return Scaffold(
      body: Column(
        children: [
          const Text("Welcome back!", style: TextStyle(fontSize: 24)),
          TextField(
            onChanged: (value) {
              context.read<LoginBloc>().add(UsernameChangeEvent(value));
            },
            decoration: const InputDecoration(label: Text("Username")),
          ),
          TextField(
            onChanged: (value) {
              context.read<LoginBloc>().add(PasswordChangeEvent(value));
            },
            obscureText: true,
            decoration: const InputDecoration(label: Text("Password")),
          ),
          TextButton(
              onPressed: () {
                context.read<LoginBloc>().add(LoginButtonEvent());
              },
              child: const Text("Login"))
        ],
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Column(
        children: [
          const Text("Welcome back!", style: TextStyle(fontSize: 24)),
          TextField(
            onChanged: (value) {
              context.read<LoginBloc>().add(UsernameChangeEvent(value));
            },
            decoration: const InputDecoration(label: Text("Username")),
          ),
          TextField(
            onChanged: (value) {
              context.read<LoginBloc>().add(PasswordChangeEvent(value));
            },
            obscureText: true,
            decoration: const InputDecoration(label: Text("Password")),
          ),
          TextButton(
              onPressed: () {
                context.read<LoginBloc>().add(LoginButtonEvent());
              },
              child: const Text("Login"))
        ],
      );
    });
  }
}
