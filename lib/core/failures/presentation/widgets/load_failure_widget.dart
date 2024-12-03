import 'package:flutter/material.dart';

class LoadFailureWidget extends StatelessWidget {
  final void Function()? reload;
  const LoadFailureWidget({
    super.key,
    required this.reload,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Ocorreu um erro, tente novamente"),
        TextButton(
          onPressed: () {},
          child: const Text("Recarregar"),
        )
      ],
    );
  }
}
