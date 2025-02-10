import 'package:capppppp/screen/vodafone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Detailes extends StatelessWidget {
  const Detailes({
    required this.profilePicture,
    required this.fullName,
    required this.sessionPrice,
    required this.yearsOfExperience,
    required this.gender,
    required this.specialization,
    required this.bio,
  });

  final String profilePicture;
  final String fullName;
  final int sessionPrice;
  final int yearsOfExperience;
  final String gender;
  final String specialization;
  final String bio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coach $fullName",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade200, Colors.blue.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade50, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                height: 150,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipperTwo(reverse: true),
              child: Container(
                height: 150,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 120.0, left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profilePicture),
                      radius: 60,
                      backgroundColor: Colors.purple.shade100,
                    ),
                  ),
                  SizedBox(height: 20),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: $fullName",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple.shade800),
                          ),
                          SizedBox(height: 10),
                          Text("Specialization: $specialization", style: TextStyle(fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text("Session Price: \$$sessionPrice", style: TextStyle(fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text("Experience: $yearsOfExperience years", style: TextStyle(fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text("Gender: $gender", style: TextStyle(fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 20),
                          Text("Bio:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple.shade800)),
                          SizedBox(height: 10),
                          Text(bio, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(),));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple.shade400,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              ),
                              child: Text(
                                "Book a Session",
                                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
