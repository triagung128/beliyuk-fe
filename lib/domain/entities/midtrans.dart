import 'package:equatable/equatable.dart';

class Midtrans extends Equatable {
  final String token;
  final String redirectUrl;

  const Midtrans({
    required this.token,
    required this.redirectUrl,
  });

  @override
  List<Object> get props => [token, redirectUrl];
}
