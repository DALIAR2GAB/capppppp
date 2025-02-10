class DoctorProfile {
  final String specialization;
  final String hospital;
  final DateTime nearestAppointment;
  final double price;
  final String image;
  final String fullName;

  DoctorProfile({
    required this.specialization,
    required this.hospital,
    required this.nearestAppointment,
    required this.price,
    required this.image,
    required this.fullName,
  });

  Map<String, dynamic> toJson() => {
    'specialization': specialization,
    'hospital': hospital,
    'nearestAppointment': nearestAppointment.toIso8601String(),
    'price': price,
    'image': image,
    'fullName': fullName,
  };
}
