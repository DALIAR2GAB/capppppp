import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _opacity = 0.0;
  double _logoTop = -100;
  String _displayedText = "";
  String _fullText = "Welcome!";
  int _textIndex = 0;
  bool _textFinished = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _logoTop = MediaQuery.of(context).size.height * 0.35;
        _opacity = 1.0;
      });
    });

    Future.delayed(Duration(seconds: 2), () {
      _startTextAnimation();
    });
  }

  void _startTextAnimation() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_textIndex < _fullText.length) {
        setState(() {
          _displayedText += _fullText[_textIndex];
          _textIndex++;
        });
        _startTextAnimation();
      } else {
        setState(() {
          _textFinished = true;
        });

        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Stack(
        children: [
          // الخلفية مع الكرات البيضاء المتناثرة بأحجام مختلفة
          _buildBackground(),

          // النص "Welcome!" مع ميل وحركة
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: _textFinished ? 1.0 : 0.0,
              child: AnimatedSlide(
                duration: Duration(seconds: 2),
                offset: _textFinished ? Offset(0, 0) : Offset(0, -0.1),
                child: Transform.rotate(
                  angle: -0.1, // لإضافة تأثير ميل للنص
                  child: Text(
                    _displayedText,
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      letterSpacing: 5,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.purple[200]!,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        // كرات بيضاء بأحجام وأماكن مختلفة
        _buildCircle(Colors.white, 50, 80, 120),
        _buildCircle(Colors.white, 30, 150, 200),
        _buildCircle(Colors.white, 60, 100, 300),
        _buildCircle(Colors.white, 40, 250, 50),
        _buildCircle(Colors.white, 70, 180, 400),
        _buildCircle(Colors.white, 55, 300, 250),
      ],
    );
  }

  Widget _buildCircle(Color color, double size, double top, double left) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
