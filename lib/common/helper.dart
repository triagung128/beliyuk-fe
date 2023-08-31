import 'package:flutter/material.dart';

class Helper {
  static String getStatus(String status) {
    switch (status) {
      case 'purchased':
        return 'Pembayaran Berhasil';
      case 'waitingPayment':
        return 'Menunggu Pembayaran';
      case 'delivered':
        return 'Sukses';
      case 'onDelivery':
        return 'Sedang Dikirim';
      default:
        return 'Gagal';
    }
  }

  static Color? getStatusBackgroundColor(String status) {
    switch (status) {
      case 'purchased':
        return Colors.greenAccent[400];
      case 'waitingPayment':
        return Colors.yellowAccent[400];
      case 'delivered':
        return Colors.greenAccent[400];
      case 'onDelivery':
        return Colors.yellowAccent[400];
      default:
        return Colors.redAccent[400]?.withOpacity(0.5);
    }
  }

  static Color? getStatusTextColor(String status) {
    switch (status) {
      case 'purchased':
        return Colors.green[900];
      case 'waitingPayment':
        return Colors.yellow[900];
      case 'delivered':
        return Colors.green[900];
      case 'onDelivery':
        return Colors.yellow[900];
      default:
        return Colors.red[900];
    }
  }
}
