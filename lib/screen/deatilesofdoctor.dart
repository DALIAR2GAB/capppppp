import 'package:capppppp/screen/vodafone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:url_launcher/url_launcher.dart';  // لإطلاق الروابط (مثل WhatsApp أو Zoom)

class Detailes2 extends StatefulWidget {
  const Detailes2({
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
  _Detailes2State createState() => _Detailes2State();
}

class _Detailes2State extends State<Detailes2> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Doctor ${widget.fullName}",
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
              padding: EdgeInsets.only(top: 120.0, left: 16.0, right: 16.0, bottom: 80.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
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
                          backgroundImage: NetworkImage(widget.image),
                          radius: 60,
                          backgroundColor: Colors.purple.shade100,
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildInfoRow("Name", widget.fullName),
                      _buildInfoRow("Specialization", widget.specialization),
                      _buildInfoRow("Price", "\$${widget.price.toString()}"),
                      _buildInfoRow("Nearest Appointment", widget.nearestAppointment),
                      _buildInfoRow("Hospital", widget.hospital),
                      SizedBox(height: 20),
                      Text(
                        "Bio: ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Consultant Psychiatrist with 15 years of experience in treating psychological disorders, anxiety, and depression.',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 30),
                      // Row of Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Book Now Button
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isPressed = !isPressed;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              isPressed ? Colors.blue.shade700 : Colors.purple.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                              shadowColor: Colors.purpleAccent,
                              elevation: 5,
                            ),
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Video Call Button
                          ElevatedButton(
                            onPressed: () {
                              _showVideoCallOptions();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                              shadowColor: Colors.greenAccent,
                              elevation: 5,
                            ),
                            child: Text(
                              'Video Call',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Method to show the options for video call
  void _showVideoCallOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose Video Call App'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ListTile(
              leading: Icon(Icons.video_call),
              title: Text('Zoom'),
              onTap: () {
                _launchURL('https://zoom.us/join');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.video_call),
              title: Text('Meeting'),
              onTap: () {
                _launchURL('https://meet.google.com/');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Method to launch the URL for the selected video call app
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
