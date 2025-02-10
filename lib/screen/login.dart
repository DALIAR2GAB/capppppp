import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/login.dart';
import '../providers/login.dart';
import 'homepage.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _loginError;
  String? _username;

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [

          // الخلفية الشفافة مع الألوان
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.6),
                  Colors.blue.withOpacity(0.6),
                  Colors.green.withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),

            child: Center(

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Login', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,fontStyle: FontStyle.italic,color: Colors.white)),
                   SizedBox(height: 10,),
                    Container(

                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0x80FFFFFF), // تم إضافة الشفافية
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.network(
                              'https://s3-alpha-sig.figma.com/img/c3f1/84b7/6f2ee7645352c895d38fabf9a4b4fbaa?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rnz9ecPSfUWUdxn3ND-LV0Dcy72RK9PZu8kN~towZ1gAhs6iJbOvSn8fS--~IiRWyDkdQtaL2FqgOAjhJ5k91vNteLJHLnEeRJoFhUawi6okFoCyjv6iA9sqK7UJVxHGiO76A3ZnjueTIKulWJUKr8Tp4WMPVTUDjr-AnCsyy5sxgq4QDzEIQUjdOa2Ui~IblAT6jZE~wGRxD8xYhPjPLYH8jrJ92wztvOHXdHTll8AJgTe8lyfm-Mye6STJHN0MXeYbelgQ4~ZYdRmmNhFvEUHAH80Fv-dj7FBf4blFdFuJbN6hFRkAFoJNkv7-h7My459KFbieMwL-ShV7OqmJwg__', // مسار الصورة الخاصة بالـ Logo
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _username != null
                              ? Text(
                            'Welcome, $_username',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF115376), // تغيير اللون
                              letterSpacing: 1.5,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          )
                              : const Text(
                            'Login Your Account',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF115376), // تغيير اللون
                              letterSpacing: 1.5,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          _buildTextField(_usernameController, 'Username', false, Icons.person),
                          const SizedBox(height: 15),
                          _buildTextField(_passwordController, 'Password', true, Icons.lock),
                          const SizedBox(height: 15),
                          _isLoading
                              ? CircularProgressIndicator()
                              : ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });

                              String username = _usernameController.text;
                              String password = _passwordController.text;

                              if (username.isEmpty || password.isEmpty) {
                                setState(() {
                                  _isLoading = false;
                                });
                                _showErrorSnackBar('Please enter both fields');
                                return;
                              }

                              final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                              await authProvider.login(User(username: username, password: password));

                              setState(() {
                                _isLoading = false;
                              });

                              if (authProvider.isAuthenticated) {
                                setState(() {
                                  _username = username;
                                });
                                _showSuccessMessage('Welcome to $username');

                                // الانتقال إلى الصفحة الرئيسية بعد تسجيل الدخول بنجاح
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Homepage(username: username,)),
                                );
                              } else {
                                _showErrorSnackBar(authProvider.loginError ?? 'Login Failed');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF115376), // تغيير اللون
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding:
                              const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                              elevation: 10,
                              shadowColor: Colors.black.withOpacity(0.3),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              // التوجيه إلى صفحة التسجيل
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),
                              );
                            },
                            child: const Text(
                              'If you dont have an account ? Sign Up',
                              style: TextStyle(fontSize: 18, color: Color(0xFF115376)), // تغيير اللون
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSocialLoginButtons(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool obscure, IconData icon) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFF115376)), // تغيير اللون
        prefixIcon: Icon(icon, color: Color(0xFF115376)), // إضافة الأيقونة
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color(0xFF115376), width: 2),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(Icons.facebook, 'https://www.facebook.com/login', Colors.blue),
        const SizedBox(width: 20),
        _buildSocialButton(Icons.mail, 'https://accounts.google.com/signin', Colors.red),
        const SizedBox(width: 20),
        _buildSocialButton(
            Icons.microwave_sharp, 'https://login.microsoftonline.com', Colors.green),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String url, Color color) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}