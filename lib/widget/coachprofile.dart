// Widget: Coach Item to display in the list
import 'package:flutter/material.dart';
import '../models/coach.dart';

class CoachItem extends StatelessWidget {
  final CoachProfile coach;

  const CoachItem({Key? key, required this.coach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: coach.profilePicture.isNotEmpty
            ? NetworkImage(coach.profilePicture)
            : AssetImage('assets/default_profile.png') as ImageProvider,
      ),
      title: Text(coach.fullName),
      subtitle: Text(coach.specialization),
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => CoachProfileScreen(coachId: coach.coachId),
        //   ),
        // );
      },
    );
  }
}
