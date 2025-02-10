import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class DoctorProfile {
  final String fullName;
  final String specialization;
  final String hospital;
  final String nearestAppointment;
  final double price;
  final String image;

  DoctorProfile({
    required this.fullName,
    required this.specialization,
    required this.hospital,
    required this.nearestAppointment,
    required this.price,
    required this.image,
  });

  // تحويل البيانات من JSON إلى Model
  factory DoctorProfile.fromJson(Map<String, dynamic> json) {
    return DoctorProfile(
      fullName: json['fullName'],
      specialization: json['specialization'],
      hospital: json['hospital'],
      nearestAppointment: json['nearestAppointment'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}

class Detailes extends StatelessWidget {
  const Detailes({
    required this.fullName,
    required this.specialization,
    required this.hospital,
    required this.nearestAppointment,
    required this.price,
    required this.image,
  });

  final String fullName;
  final String specialization;
  final String hospital;
  final String nearestAppointment;
  final double price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Coach $fullName",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent, // AppBar شفاف
        elevation: 0, // إزالة الظل
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
      extendBodyBehindAppBar: true, // لجعل الـ AppBar يظهر فوق الخلفية
      body: Stack(
        children: [
          // خلفية متدرجة
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade50, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // شكل موجة في الأعلى
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

          // شكل موجة في الأسفل
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

          // محتوى الصفحة
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 120.0, left: 16.0, right: 16.0, bottom: 16.0),
              child: AnimatedContainer(
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
                      Center(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(image),
                          radius: 60,
                          backgroundColor: Colors.purple.shade100,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Name: $fullName",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Specialization: $specialization",
                        style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Hospital: $hospital",
                        style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Nearest Appointment: $nearestAppointment",
                        style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Price: \$${price.toString()}",
                        style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Bio:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}