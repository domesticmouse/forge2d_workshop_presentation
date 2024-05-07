import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class ShowGame<T extends Game> extends StatelessWidget {
  const ShowGame({
    super.key,
    required this.gameFactory,
  });

  final GameFactory<T> gameFactory;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/johannes-plenio-3nvxR54IR-0-unsplash.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(4, 8),
                      ),
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 800,
                    height: 600,
                    child: Stack(
                      children: [
                        Center(
                          child: GameWidget.controlled(
                            gameFactory: gameFactory,
                          ),
                        ),
                        CustomPaint(
                          painter: _WindowControlsPainer(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WindowControlsPainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(14, 14), 6, Paint()..color = Colors.red[400]!);
    canvas.drawCircle(Offset(34, 14), 6, Paint()..color = Colors.orange[300]!);
    canvas.drawCircle(Offset(54, 14), 6, Paint()..color = Colors.green[400]!);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
