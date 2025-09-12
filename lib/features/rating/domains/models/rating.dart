import 'package:fitness_client/features/gym/domains/models/gym.dart';
import 'package:fitness_client/features/profile/domains/models/client.dart';

class Rating {
  String? id;
  String? content;
  double? rating;
  Client? client;
  Gym? gym;
  DateTime? createdAt;
  Rating({this.id, this.content, this.rating, this.client, this.gym, this.createdAt});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['_id'],
      content: json['content'] ?? "",
      rating: json['rating']?.toDouble(),
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      gym: json['gym'] != null ? Gym.fromJson(json['gym']) : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'content': content, 'rating': rating, 'client': client?.toJson(), 'gym': gym?.toJson(), 'createdAt': createdAt?.toIso8601String()};
  }
}
