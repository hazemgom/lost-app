import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  final String name;
  final String uId;
  final String image;
  final String dateTime;
  final String text;
  final String postImage;
  final String location;
  final String phone;
  final String email;

  const PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
    required this.location,
    required this.phone,
    required this.email,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      name: json['name'],
      uId: json['uId'],
      image: json['image'],
      dateTime: json['dateTime'],
      text: json['text'],
      postImage: json['postImage'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
      'phone': phone,
      'email': email,
      'location': location
    };
  }

  @override
  List<Object> get props => [
        name,
        uId,
        image,
        dateTime,
        text,
        postImage,
        location,
        email,
        phone,
      ];
}
