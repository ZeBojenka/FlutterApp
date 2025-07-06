import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const VictoryApp());

class VictoryApp extends StatelessWidget {
  const VictoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ПОБЕДА!',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF388E3C),
        ),
      ),
      home: const VictoryScreen(),
    );
  }
}

class VictoryScreen extends StatefulWidget {
  const VictoryScreen({super.key});

  @override
  State<VictoryScreen> createState() => _VictoryScreenState();
}

class _VictoryScreenState extends State<VictoryScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _showNotification = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() => _isPlaying = state == PlayerState.playing);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playVictorySound() async {
    try {
      await _audioPlayer.play(
        UrlSource('https://www.soundjay.com/misc/sounds/bell-ringing-05.mp3'),
        volume: 1.0,
      );
    } catch (e) {
      debugPrint("Ошибка воспроизведения: $e");
    }
  }

  void _handleButtonPress() {
    setState(() => _showNotification = true);
    _playVictorySound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "ПОБЕДНОЕ ПРИЛОЖЕНИЕ",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isPlaying ? null : _handleButtonPress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF388E3C),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(300, 100),
                ),
                child: const Text(
                  "НАЖМИ МЕНЯ!",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                _isPlaying 
                  ? "Звук победы играет!" 
                  : "Нажмите кнопку, чтобы услышать звук победы!",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: _isPlaying ? Colors.green : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              if (_showNotification) ...[
                const SizedBox(height: 30),
                const Text(
                  "УРА! Мы создали рабочую программу!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
