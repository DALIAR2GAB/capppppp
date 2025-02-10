class VodafoneCashModel {
  final int id;
  final String imageUrl;

  VodafoneCashModel({required this.id, required this.imageUrl});

  factory VodafoneCashModel.fromJson(Map<String, dynamic> json) {
    return VodafoneCashModel(
      id: json['id'],
      imageUrl: json['image'],
    );
  }
}