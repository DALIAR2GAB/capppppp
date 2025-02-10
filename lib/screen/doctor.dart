import 'package:capppppp/screen/homepage.dart';
import 'package:capppppp/screen/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/doctor.dart';
import '../providers/userprovidr.dart';
import '../serviecs/doctor.dart';
import 'deatilesofdoctor.dart';
import 'notifaction.dart';

class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  late Future<List<DoctorProfile>> _doctorProfiles;
  TextEditingController _searchController = TextEditingController();
  List<DoctorProfile> _filteredProfiles = [];

  @override
  void initState() {
    super.initState();
    _doctorProfiles = DoctorService().getAllProfiles();
  }

  void _filterDoctors(String query, List<DoctorProfile> profiles) {
    setState(() {
      _filteredProfiles = profiles
          .where((profile) => profile.fullName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    String usernames = Provider.of<UserProvider>(context).username;; // جلب اسم المستخدم

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://s3-alpha-sig.figma.com/img/c3f1/84b7/6f2ee7645352c895d38fabf9a4b4fbaa?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rnz9ecPSfUWUdxn3ND-LV0Dcy72RK9PZu8kN~towZ1gAhs6iJbOvSn8fS--~IiRWyDkdQtaL2FqgOAjhJ5k91vNteLJHLnEeRJoFhUawi6okFoCyjv6iA9sqK7UJVxHGiO76A3ZnjueTIKulWJUKr8Tp4WMPVTUDjr-AnCsyy5sxgq4QDzEIQUjdOa2Ui~IblAT6jZE~wGRxD8xYhPjPLYH8jrJ92wztvOHXdHTll8AJgTe8lyfm-Mye6STJHN0MXeYbelgQ4~ZYdRmmNhFvEUHAH80Fv-dj7FBf4blFdFuJbN6hFRkAFoJNkv7-h7My459KFbieMwL-ShV7OqmJwg__',
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Doctors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_2_sharp, color: Colors.white),
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
                  },child: InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(username: usernames),));
                  },child: Icon(Icons.home, color: Colors.black))),
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
          ),

          IconButton(
            icon: InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));

            },child: Icon(Icons.notifications, color: Colors.white)),
            onPressed: () {},
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade300, Colors.blue.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search, color: Colors.purple.shade300),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                onChanged: (query) {
                  _doctorProfiles.then((profiles) {
                    _filterDoctors(query, profiles);
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<DoctorProfile>>(
              future: _doctorProfiles,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No doctors found.'));
                } else {
                  var profiles = _searchController.text.isEmpty ? snapshot.data! : _filteredProfiles;
                  return ListView.builder(
                    itemCount: profiles.length,
                    itemBuilder: (context, index) {
                      var profile = profiles[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Detailes2(image: profile.image,fullName: profile.fullName,hospital: profile.hospital,nearestAppointment: profile.nearestAppointment,price: profile.price,specialization: profile.specialization,),));
                                }
                                ,child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(profile.image),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                    'Dr. ${ profile.fullName}',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                    Row(
                                      children: List.generate(5, (starIndex) {
                                        return Icon(
                                          starIndex < 4 ? Icons.star : Icons.star_border,
                                          color: Colors.amber,
                                        );
                                      }),
                                    ),
                                    SizedBox(height: 5),
                                    Text(profile.specialization, style: TextStyle(color: Colors.grey[600])),
                                    SizedBox(height: 5),
                                    Text('Hospital: ${profile.hospital}'),
                                    SizedBox(height: 5),
                                    Text('Price: \$${profile.price}'),
                                    SizedBox(height: 5),
                                    Text('Next Appointment: ${profile.nearestAppointment}'),
                                  ],
                                ),
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        items: [

          BottomNavigationBarItem(
            icon: InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(username: usernames),));

            },child: Icon(Icons.home, size: 30)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
      ),
    );
  }
}
