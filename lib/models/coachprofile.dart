// // Model: CoachProfile
// class CoachProfile{
//   final int coachId;
//   final String profilePicture;
//   final String fullName;
//   final int sessionPrice;
//   final int yearsOfExperience;
//   final String gender;
//   final String specialization;
//   final String bio;
//
//   CoachProfile({
//     required this.coachId,
//     required this.profilePicture,
//     required this.fullName,
//     required this.sessionPrice,
//     required this.yearsOfExperience,
//     required this.gender,
//     required this.specialization,
//     required this.bio,
//   });
//
//   factory CoachProfile.fromJson(Map<String, dynamic> json) {
//     return CoachProfile(
//       coachId: json['coachId'],
//       profilePicture: json['profilePicture'] ?? '',
//       fullName: json['fullName'] ?? 'Unknown',
//       sessionPrice: json['sessionPrice'] ?? 0,
//       yearsOfExperience: json['yearsOfExperience'] ?? 0,
//       gender: json['gender'] ?? 'Not Specified',
//       specialization: json['specialization'] ?? 'General',
//       bio: json['bio'] ?? 'No bio available.',
//     );
//   }
// }