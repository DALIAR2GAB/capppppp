import 'package:flutter/material.dart';
import 'package:capppppp/video/videocall.dart';
import 'aduiocall.dart';

class HomeScreenvideo extends StatefulWidget {
  const HomeScreenvideo({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenvideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية متدرجة بألوان رائعة 🎨🔥
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black26,
                  Colors.blue.shade600,
                  Colors.teal.shade600,
                  Colors.green,
                  Colors.purple.shade100,

                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // دوائر صغيرة في الخلفية
          Positioned(
            top: 100,
            left: 50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            top: 200,
            right: 30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            left: 20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),

          Positioned(
            bottom: 50,
            right: 50,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),

          // العنصر الرئيسي في المنتصف - تكبير الفورم ليكون أكثر وضوحًا
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9, // عرض الفورم
              height: MediaQuery.of(context).size.height * 0.6, // ارتفاع الفورم
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25), // تأثير الزجاج
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withOpacity(0.4)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center, // عناصر الفورم في المنتصف عموديًا
                children: [
                  // الصورة الشخصية
                  CircleAvatar(
                    radius: 85,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    backgroundImage: const NetworkImage(
                      "https://play-lh.googleusercontent.com/ZpQcKuCwbQnrCgNpsyUsgDjuBUnpcIBkVrPSDKS9LOJTAW1kxMsu6cLltOSUODjiEQ=w500-h280-rw",
                    ),
                  ),
                  const SizedBox(height: 20),

                  // الاسم بتنسيق أنيق
                  const Text(
                    "Amar Awni",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // رقم الهاتف
                  const Text(
                    "+20 1094037735",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // أزرار الاتصال داخل صف يحتوي على Flexible لضبط الحجم
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: _buildCallButton(
                          icon: Icons.video_call,
                          label: "Video Call",
                          color: Colors.teal,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideocallScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10), // مسافة بسيطة بين الأزرار
                      Flexible(
                        child: _buildCallButton(
                          icon: Icons.phone,
                          label: "Audio Call",
                          color: Colors.green,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AudioCallScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // دالة لإنشاء زر الاتصال بشكل جميل
  Widget _buildCallButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 30), // تقليل حجم الأيقونة قليلاً
      label: Text(
        label,
        style: const TextStyle(fontSize: 16), // تقليل حجم النص قليلاً
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.85),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), // تقليل الحشوة
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 6,
      ),
    );
  }
}