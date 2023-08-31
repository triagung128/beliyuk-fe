import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/presentation/blocs/main/main_bloc.dart';
import 'package:beliyuk/presentation/pages/main/main_page.dart';

class PaymentFailedPage extends StatefulWidget {
  const PaymentFailedPage({super.key});

  @override
  State<PaymentFailedPage> createState() => _PaymentFailedPageState();
}

class _PaymentFailedPageState extends State<PaymentFailedPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Pembayaran Gagal',
        desc: 'Maaf pembayaran Anda gagal',
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
        btnOkColor: Colors.red,
        btnOkText: 'Tutup',
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
