import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  final String uId;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String cover;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'uId': uId,
      'cover': cover,
    };
  }

  const UserDataModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.phone,
    this.image = '',
    this.cover = '',
  });
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      uId: json['uId'] ?? '',
      image: json['image'] ?? 'https://img.freepik.com/premium-photo/businessman-icon-blue-background-3d-render_567294-706.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=ais',
      cover: json['cover'] ?? 'https://img.freepik.com/free-photo/solid-concrete-wall-textured-backdrop_53876-129493.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.2.798062041.1678310296&semt=sph',
    );
  }

  @override
  List<Object> get props => [uId, name, email, phone, image,cover];
}
