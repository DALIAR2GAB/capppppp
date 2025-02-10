class CoachProfile {
  final String profilePicture;
  final String fullName;
  final String gender;
  final String specialization;
  final String bio;
  final int sessionPrice;
  final int yearsOfExperience;

  CoachProfile({
    required this.profilePicture,
    required this.fullName,
    required this.gender,
    required this.specialization,
    required this.bio,
    required this.sessionPrice,
    required this.yearsOfExperience,
  });

  factory CoachProfile.fromJson(Map<String, dynamic> json) {
    return CoachProfile(
      profilePicture: json['profilePicture'],
      fullName: json['fullName'],
      gender: json['gender'],
      specialization: json['specialization'],
      bio: json['bio'],
      sessionPrice: json['sessionPrice'],
        yearsOfExperience: json['yearsOfExperience'],
    );
  }

}