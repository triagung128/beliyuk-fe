import 'package:equatable/equatable.dart';

import 'package:beliyuk/domain/entities/midtrans.dart';

class MidtransModel extends Equatable {
  final String token;
  final String redirectUrl;

  const MidtransModel({
    required this.token,
    required this.redirectUrl,
  });

  @override
  List<Object> get props => [token, redirectUrl];

  Map<String, dynamic> toJson() => {
        'token': token,
        'redirect_url': redirectUrl,
      };

  factory MidtransModel.fromJson(Map<String, dynamic> json) => MidtransModel(
        token: json['token'],
        redirectUrl: json['redirect_url'],
      );

  Midtrans toEntity() => Midtrans(token: token, redirectUrl: redirectUrl);
}
