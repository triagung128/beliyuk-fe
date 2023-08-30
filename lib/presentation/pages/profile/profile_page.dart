import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';

import 'package:beliyuk/presentation/blocs/auth/auth_bloc.dart';
import 'package:beliyuk/presentation/blocs/cart/cart_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun Saya'),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.grey[400],
                  child: const Icon(
                    Icons.person,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  state.user?.username ?? 'null',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(state.user?.email ?? 'null'),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.noHeader,
                      title: 'Logout',
                      desc: 'Apakah Anda yakin ingin logout ?',
                      btnCancelText: 'Batal',
                      btnOkText: 'Logout',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        context.read<AuthBloc>().add(DoLogoutEvent());
                        context.read<CartBloc>().add(DeleteAllCartEvent());
                        Restart.restartApp();
                      },
                    ).show();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Logout'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
