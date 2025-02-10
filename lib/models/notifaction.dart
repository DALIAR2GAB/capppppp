class NotificationModel {
  final String fullName;
  final String? profileImage;

  NotificationModel({
    required this.fullName,
    this.profileImage,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      fullName: json['fullName'],
      profileImage: json['profileImage'],
    );
  }
}