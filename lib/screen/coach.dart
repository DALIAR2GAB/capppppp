import 'package:capppppp/screen/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coach.dart';
import '../providers/coach.dart';
import '../providers/userprovidr.dart';
import 'detaileslifecoach.dart';
import 'homepage.dart';
import 'layoutpage.dart';
import 'notifaction.dart';

class CoachScreen extends StatefulWidget {
  @override
  _CoachScreenState createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  final CoachProvider _coachProvider = CoachProvider();
  final TextEditingController _searchController = TextEditingController();
  List<CoachProfile> _filteredCoaches = [];

  @override
  void initState() {
    super.initState();
    _coachProvider.fetchCoaches().then((_) {
      _filteredCoaches = _coachProvider.coaches; // تهيئة القائمة المصفاة بالبيانات الكاملة
    });
  }

  void _searchCoaches(String query) {
    setState(() {
      _filteredCoaches = _coachProvider.coaches
          .where((coach) =>
          coach.fullName.toLowerCase().contains(query.toLowerCase()))
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
                'https://s3-alpha-sig.figma.com/img/c3f1/84b7/6f2ee7645352c895d38fabf9a4b4fbaa?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rnz9ecPSfUWUdxn3ND-LV0Dcy72RK9PZu8kN~towZ1gAhs6iJbOvSn8fS--~IiRWyDkdQtaL2FqgOAjhJ5k91vNteLJHLnEeRJoFhUawi6okFoCyjv6iA9sqK7UJVxHGiO76A3ZnjueTIKulWJUKr8Tp4WMPVTUDjr-AnCsyy5sxgq4QDzEIQUjdOa2Ui~IblAT6jZE~wGRxD8xYhPjPLYH8jrJ92wztvOHXdHTll8AJgTe8lyfm-Mye6STJHN0MXeYbelgQ4~ZYdRmmNhFvEUHAH80Fv-dj7FBf4blFdFuJbN6hFRkAFoJNkv7-h7My459KFbieMwL-ShV7OqmJwg__', // مسار الصورة الخاصة بالـ Logo
              ),
            ),
            SizedBox(width: 10), // مسافة بين الـ Logo والنص
            Text(
              'Life Coaches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
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
                  leading: InkWell(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(username: usernames),
                      ),
                    );
                  }, child: Icon(Icons.home, color: Colors.black)),
                  title: Text('Home'),
                ),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: ListTile(
                  leading: InkWell(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  }, child: Icon(Icons.settings, color: Colors.black)),
                  title: Text('Settings'),
                ),
              ),

              PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: InkWell(onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogoutPage()),
                    );
                  }, child: Icon(Icons.logout, color: Colors.black)),
                  title: Text('Logout'),
                ),
              ),
            ],
          ),
          IconButton(
            icon: InkWell(onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            }, child: Icon(Icons.notifications, color: Colors.white)),
            onPressed: () {
              // إضافة وظيفة للـ Notifications هنا
            },
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
          preferredSize: Size.fromHeight(50), // تصغير ارتفاع الـ Search Bar
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9), // لون الخلفية
                borderRadius: BorderRadius.circular(25), // زوايا مدورة
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
                  border: InputBorder.none, // إزالة الحدود
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                onChanged: _searchCoaches, // تحديث القائمة عند تغيير النص
              ),
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider<CoachProvider>(
        create: (context) => _coachProvider,
        child: Consumer<CoachProvider>(
          builder: (context, coachProvider, child) {
            if (coachProvider.isLoading) {
              return Center(child: CircularProgressIndicator()); // عرض مؤشر التحميل
            }

            if (coachProvider.errorMessage.isNotEmpty) {
              return Center(child: Text("Error: ${coachProvider.errorMessage}")); // عرض رسالة الخطأ
            }

            if (_filteredCoaches.isEmpty) {
              return Center(child: Text("No data available")); // عرض رسالة إذا كانت البيانات فارغة
            }

            return ListView.builder(
              itemCount: _filteredCoaches.length,
              itemBuilder: (context, index) {
                CoachProfile coach = _filteredCoaches[index];
                return CoachItem(coach: coach); // استخدام الـ CoachItem لعرض كل Life Coach
              },
            );
          },
        ),
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage(username: usernames)),
                );
              },
              child: Icon(Icons.home, size: 30),
            ),
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

class CoachItem extends StatelessWidget {
  final CoachProfile coach;

  const CoachItem({Key? key, required this.coach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // ظل للـ Card
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // هامش حول الـ Card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // زوايا مدورة
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detailes(
                profilePicture: coach.profilePicture,
                fullName: coach.fullName,
                gender: coach.gender,
                sessionPrice: coach.sessionPrice,
                specialization: coach.specialization,
                bio: coach.bio,
                yearsOfExperience: coach.sessionPrice,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16), // هامش داخلي للـ Card
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: coach.profilePicture == "string"
                    ? NetworkImage("https://via.placeholder.com/150") // صورة افتراضية
                    : NetworkImage(coach.profilePicture),
                radius: 40, // حجم الصورة
              ),
              SizedBox(width: 16), // مسافة بين الصورة والنص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coach. ${coach.fullName}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade800,
                      ),
                    ),
                    SizedBox(height: 8), // مسافة بين الاسم والتخصص
                    Text(
                      coach.specialization,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8), // مسافة بين التخصص والـ Bio
                    Text(
                      coach.bio,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2, // عدد الأسطر للـ Bio
                      overflow: TextOverflow.ellipsis, // تقصير النص إذا كان طويلاً
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
