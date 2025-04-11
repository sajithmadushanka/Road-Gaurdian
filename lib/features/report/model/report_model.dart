import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String priorityLevel;
  final GeoPoint location;
  final List? images;
  final DateTime? createdAt;

  ReportModel({
   required this.id,
   required this.userId,
    required this.title,
    required this.description,
    required this.priorityLevel,
    required this.location,
    this.images,
    required this.createdAt,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'priorityLevel': priorityLevel,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
      'images': images,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      priorityLevel: json['priorityLevel'],
      location: json['location'],
      images: json['images'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
