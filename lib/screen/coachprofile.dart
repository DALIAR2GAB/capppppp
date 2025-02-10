// import 'package:capppppp/providers/coachprofile.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
//
//
// class CoachProfileScreen extends StatefulWidget {
//   final int coachId;
//
//   const CoachProfileScreen({Key? key, required this.coachId}) : super(key: key);
//
//   @override
//   _CoachProfileScreenState createState() => _CoachProfileScreenState();
// }
//
// class _CoachProfileScreenState extends State<CoachProfileScreen> {
//   bool _isFirstLoad = true;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     if (_isFirstLoad) {
//       final provider = Provider.of<CoachProvider>(context, listen: false);
//       provider.loadCoachProfile(widget.coachId);
//       _isFirstLoad = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Coach Profile')),
//       body: Consumer<CoachProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (provider.errorMessage.isNotEmpty) {
//             return Center(child: Text(provider.errorMessage));
//           }
//           if (provider.coachProfile == null) {
//             return const Center(child: Text('No Data Available'));
//           }
//
//           final coach = provider.coachProfile!;
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   backgroundImage: coach.profilePicture.isNotEmpty
//                       ? NetworkImage(coach.profilePicture)
//                       : const AssetImage('assets/default_profile.png') as ImageProvider,
//                   radius: 50,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(coach.fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                 Text('Specialization: ${coach.specialization}', style: const TextStyle(fontSize: 16)),
//                 Text('Experience: ${coach.yearsOfExperience} years', style: const TextStyle(fontSize: 16)),
//                 Text('Session Price: \$${coach.sessionPrice}', style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 16),
//                 Text(coach.bio, style: const TextStyle(fontSize: 16)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
