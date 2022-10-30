import 'package:app/app.dart';
import 'package:app/views/player_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    Shell(app),
  );
}

class Shell extends StatelessWidget {
  const Shell(this.app, {super.key});

  final App app;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: app.init(),
      builder: (context, state) => state.connectionState != ConnectionState.done
          ? const ColoredBox(color: Colors.white)
          : MaterialApp(
              title: 'music',
              theme: ThemeData(
                primarySwatch: Colors.pink,
                useMaterial3: true,
                scaffoldBackgroundColor: Colors.white,
              ),
              home: const HomeView(),
            ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/app-icon.png',
          width: 48,
        ),
      ),
      body: PlayerView(
        playlist: app.playlist,
        player: app.player,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: app.player.play,
        tooltip: 'Play',
        child: const Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class XSlider extends StatelessWidget {
  const XSlider({
    required this.value,
    this.onChanged,
    super.key,
  });

  final double value;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbColor: Colors.white,
        thumbShape:
            const RoundSliderThumbShape(enabledThumbRadius: 10, elevation: 3),
        overlayColor: Colors.pinkAccent.withOpacity(0.3),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 25),
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
