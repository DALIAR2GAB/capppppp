import 'package:flutter/material.dart';
import '../models/coach.dart';
import '../providers/coach.dart';
import '../screen/detaileslifecoach.dart';

class CoachListWidget extends StatelessWidget {
  final CoachProvider coachProvider;

  const CoachListWidget({Key? key, required this.coachProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (coachProvider.isLoading) {
      return Center(child: CircularProgressIndicator()); // عرض مؤشر التحميل
    }

    if (coachProvider.errorMessage.isNotEmpty) {
      return Center(child: Text("Error: ${coachProvider.errorMessage}")); // عرض رسالة الخطأ
    }

    if (coachProvider.coaches.isEmpty) {
      return Center(child: Text("No data available")); // عرض رسالة إذا كانت البيانات فارغة
    }

    return ListView.builder(
      itemCount: coachProvider.coaches.length,
      itemBuilder: (context, index) {
        CoachProfile coach = coachProvider.coaches[index];

        return ListTile(
          leading: InkWell(
            child: InkWell(

              child: CircleAvatar(
                backgroundImage: coach.profilePicture == "string"
                    ? NetworkImage("https://via.placeholder.com/150") // صورة افتراضية
                    : NetworkImage(coach.profilePicture),
              ),
            ),
          ),
          title: Text(coach.fullName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(coach.specialization),
              Text(coach.bio),
            ],
          ),
        );
      },
    );
  }
}
