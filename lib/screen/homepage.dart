import 'package:capppppp/screen/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/homepage.dart';
import '../providers/homepage.dart';
import 'coach.dart';
import 'doctor.dart';
import 'notifaction.dart';

class Homepage extends StatefulWidget {
  final String username;

  Homepage({required this.username});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Color doctorButtonColor = Colors.blue;
  Color coachButtonColor = Colors.green;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<PostProvider>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 140,
                  color: Colors.blue[200],
                  child: AppBar(
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                              r'D:\capppppp\WhatsApp Image 2024-10-14 at 7.34.32 PM.jpeg'),
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Welcome ${widget.username}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    actions: [
                      IconButton(
                        icon: InkWell(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
                        },child: Icon(Icons.notifications, color: Colors.white)),
                        onPressed: () {},
                      ),

                      PopupMenuButton<String>(
                        icon: Icon(Icons.menu, color: Colors.white),
                        onSelected: (value) {
                          if (value == 'home') {
                            print("الانتقال للصفحة الرئيسية");
                          } else if (value == 'settings') {
                            print("فتح الإعدادات");
                          } else if (value == 'dark_mode') {
                            print("تفعيل الوضع الداكن");
                          } else if (value == 'logout') {
                            print("تسجيل الخروج");
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'home',
                            child: ListTile(
                              leading: InkWell(onTap: (){
                              },child: Icon(Icons.home, color: Colors.black)),
                              title: Text('Home'),
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'settings',
                            child: ListTile(
                              leading: InkWell(onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),));
                              },child: Icon(Icons.settings, color: Colors.black)),
                              title: Text('Settings'),
                            ),
                          ),


                          PopupMenuItem<String>(
                            value: 'logout',
                            child: ListTile(
                              leading: Icon(Icons.logout, color: Colors.black),
                              title: Text('Logout'),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Expanded(
            child: Consumer<PostProvider>(
              builder: (context, postProvider, child) {
                if (postProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (postProvider.posts.isEmpty) {
                  return Center(child: Text('No posts available.'));
                } else {
                  return ListView.builder(
                    itemCount: postProvider.posts.length,
                    itemBuilder: (context, index) {
                      Post post = postProvider.posts[index];
                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                               'Dr. ${post.username}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: post.content, // نص المحتوى
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5, // زيادة المسافة بين الأسطر
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 10),

                              SizedBox(height: 10),
                              Row(
                                children: [

                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey,
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text('Chat Now', style: TextStyle(color: Colors.white)),
                                    onPressed: () {},
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      post.isLiked ? Icons.favorite : Icons.favorite_border,
                                      color: post.isLiked ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () {
                                      postProvider.toggleLike(index);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          doctorButtonColor = Colors.blueAccent;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          doctorButtonColor = Colors.blue;
                        });
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: doctorButtonColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person_2_sharp, color: Colors.white),
                            SizedBox(width: 5),
                            Text('Doctors', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DoctorPage()), // الانتقال إلى صفحة الدكاترة
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Consult with expert doctors\nfor your health and well-being.',
                        style: TextStyle(
                            color: Colors.blueGrey, fontSize: 12, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          coachButtonColor = Colors.greenAccent;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          coachButtonColor = Colors.green;
                        });
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: coachButtonColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.people, color: Colors.white),
                            SizedBox(width: 5),
                            Text('Live Coach', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            coachButtonColor = coachButtonColor == Colors.green
                                ? Colors.greenAccent
                                : Colors.green;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CoachScreen(),));
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Empower your growth \nwith professional coaching\nand unlock your full potential.',
                        style: TextStyle(
                            color: Colors.blueGrey, fontSize: 12, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 2);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 40);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height - 80, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
