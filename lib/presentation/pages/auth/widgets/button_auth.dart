import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/auth/auth_bloc.dart';
import 'package:fic6_fe_beliyuk/common/enum_state.dart';

class ButtonAuth extends StatelessWidget {
  const ButtonAuth({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.state == RequestState.loading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: state.state == RequestState.loading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Loading",
                        style: TextStyle(fontSize: 16),
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText("..."),
                        ],
                      ),
                    ],
                  )
                : Text(
                    title,
                    style: const TextStyle(fontSize: 16),
                  ),
          );
        },
      ),
    );
  }
}
