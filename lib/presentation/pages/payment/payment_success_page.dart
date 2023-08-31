import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/presentation/blocs/main/main_bloc.dart';
import 'package:beliyuk/presentation/pages/main/main_page.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Pembayaran Sukses',
          desc: 'Selamat pembayaran Anda berhasil dilakukan',
          btnOkOnPress: () {
            context.read<MainBloc>().add(const DoTabChangeEvent(tabIndex: 2));
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const MainPage(),
              ),
              (_) => false,
            );
          },
        ).show();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
