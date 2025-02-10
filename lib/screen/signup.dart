import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/signup.dart';
import '../providers/signup.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String userType = "Person";
  String gender = "Male";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);

    return Scaffold(

      body: Stack(
        children: [
          SizedBox(height: 40,),
          // الخلفية الشفافة مع الألوان
          Container(
            decoration: BoxDecoration(

              gradient: LinearGradient(

                colors: [
                  Colors.blue.withOpacity(0.6),
                  Colors.purple.withOpacity(0.6),
                  Colors.green.withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Register', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,fontStyle: FontStyle.italic,color: Colors.white)),

                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      elevation: 7,
                      color: Colors.white.withOpacity(0.6), // زيادة الشفافية
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(

                          children: [

                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage("https://s3-alpha-sig.figma.com/img/c3f1/84b7/6f2ee7645352c895d38fabf9a4b4fbaa?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rnz9ecPSfUWUdxn3ND-LV0Dcy72RK9PZu8kN~towZ1gAhs6iJbOvSn8fS--~IiRWyDkdQtaL2FqgOAjhJ5k91vNteLJHLnEeRJoFhUawi6okFoCyjv6iA9sqK7UJVxHGiO76A3ZnjueTIKulWJUKr8Tp4WMPVTUDjr-AnCsyy5sxgq4QDzEIQUjdOa2Ui~IblAT6jZE~wGRxD8xYhPjPLYH8jrJ92wztvOHXdHTll8AJgTe8lyfm-Mye6STJHN0MXeYbelgQ4~ZYdRmmNhFvEUHAH80Fv-dj7FBf4blFdFuJbN6hFRkAFoJNkv7-h7My459KFbieMwL-ShV7OqmJwg__"),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Create Account",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF115376), letterSpacing: 1.5,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                  ),
                                ],),

                            ),
                            SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  _buildTextField("Age", ageController, TextInputType.number, Icons.calendar_today),
                                  _buildTextField("Email", emailController, TextInputType.emailAddress, Icons.email),
                                  _buildTextField("Full Name", fullNameController, TextInputType.text, Icons.person),
                                  _buildTextField("Username", usernameController, TextInputType.text, Icons.person_outline),
                                  _buildTextField("Password", passwordController, TextInputType.visiblePassword, Icons.lock, obscureText: true),
                                  _buildTextField("Confirm Password", confirmPasswordController, TextInputType.visiblePassword, Icons.lock_outline, obscureText: true),
                                  SizedBox(height: 10),
                                  _buildDropdown("Select Gender", ["Male", "Female"], gender, (value) {
                                    setState(() => gender = value!);
                                  }),
                                  SizedBox(height: 10),
                                  _buildDropdown("Select User Type", ["Person", "Doctor", "Coach"], userType, (value) {
                                    setState(() => userType = value!);
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    provider.isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF115376), // نفس لون زر Login
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                        elevation: 10,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final model = SignUpModel(
                            Age: int.parse(ageController.text),
                            email: emailController.text,
                            gender: gender,
                            fullName: fullNameController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                            username: usernameController.text,
                            userType: userType,
                          );
                          provider.register(model, context).then((success) {
                            if (success) {
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              });
                            }
                          });
                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Already have an account? Login',
                        style: TextStyle(fontSize: 18, color: Color(0xFF115376)),
                      ),
                    ),
                    if (provider.errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(provider.errorMessage, style: TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType keyboardType, IconData icon, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFF115376)),
          prefixIcon: Icon(icon, color: Color(0xFF115376)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Color(0xFF115376), width: 2),
          ),
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value!.isEmpty) return 'Please enter your $label';
          if (label == "Confirm Password" && value != passwordController.text) return "Passwords do not match";
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items, String value, ValueChanged<String?> onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color(0xFF115376)),
        color: Colors.white.withOpacity(0.8),
      ),
      child: DropdownButton<String>(
        value: value,
        items: items.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
        onChanged: onChanged,
        isExpanded: true,
        underline: SizedBox(),
      ),
    );
  }
}