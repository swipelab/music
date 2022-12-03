import 'package:app/app.dart';
import 'package:app/pages/player/player_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  app = App.production();
  runApp(
    Shell(app),
  );
}

class Shell extends StatelessWidget {
  const Shell(
    this.app, {
    super.key,
  });

  final App app;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: app.init(),
      builder: (context, state) => state.connectionState != ConnectionState.done
          ? const ColoredBox(color: Colors.white)
          : MaterialApp(
              title: 'Music',
              theme: ThemeData(
                primarySwatch: Colors.pink,
                useMaterial3: true,
                iconTheme: const IconThemeData(
                  size: 24,
                  color: Colors.black87,
                ),
              ),
              home: const PlayerPageView(),
            ),
    );
  }
}
