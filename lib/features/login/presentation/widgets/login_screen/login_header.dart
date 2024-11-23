import 'package:flutter/material.dart';
import '../../../../../core/theme/color_pallet.dart';

class LoginHeader extends StatelessWidget {
  final Size headerSize;
  const LoginHeader({super.key, required this.headerSize});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HeaderPainter(color: Colors.black),
      size: headerSize,
    );
  }
}

class HeaderPainter extends CustomPainter {
  final Color color;

  HeaderPainter({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    _makeWaveCanvas(canvas, size);
    _makeTitleText(size, canvas);
  }

  void _makeWaveCanvas(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint();
    paint.shader = LinearGradient(
      colors: [
        ColorPallet.lightBlue,
        ColorPallet.blue,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    paint.strokeWidth = 2;
    paint.style = PaintingStyle.fill;
    path.lineTo(0, size.height);

    _generateCurve(
      path,
      startPoint: Offset(0, size.height),
      controlPoint: Offset(size.width * 0.015, size.height),
      endPoint: Offset(size.width * 0.028, size.height * 0.97),
    );
    _generateCurve(
      path,
      startPoint: Offset(size.width * 0.028, size.height * 0.97),
      controlPoint: Offset(size.width * 0.38, size.height * 0.2),
      endPoint: Offset(size.width * 0.7, size.height * 0.8),
    );

    _generateCurve(
      path,
      startPoint: Offset(size.width * 0.7, size.height * 0.8),
      controlPoint: Offset(size.width * 0.75, size.height * 0.89),
      endPoint: Offset(size.width * 0.83, size.height * 0.8),
    );

    _generateCurve(
      path,
      startPoint: Offset(size.width * 0.83, size.height * 0.8),
      controlPoint: Offset(size.width * 0.93, size.height * 0.7),
      endPoint: Offset(size.width, size.height),
    );

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();
    canvas.drawPath(path, paint);
  }

  void _generateCurve(
    Path path, {
    required Offset startPoint,
    required Offset controlPoint,
    required Offset endPoint,
  }) {
    path.lineTo(startPoint.dx, startPoint.dy);
    path.relativeQuadraticBezierTo(
      controlPoint.dx - startPoint.dx,
      controlPoint.dy - startPoint.dy,
      endPoint.dx - startPoint.dx,
      endPoint.dy - startPoint.dy,
    );
  }

  void _makeTitleText(Size size, Canvas canvas) {
    final textSpan = TextSpan(
      text: 'وردپرس یار',
      style: TextStyle(
        color: ColorPallet.white,
        fontSize: size.height * 0.08 * size.width * 0.0025,
        fontFamily: "Vazir",
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.rtl,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) * 0.3,
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
