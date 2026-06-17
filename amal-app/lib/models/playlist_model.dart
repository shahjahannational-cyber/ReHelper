import 'package:equatable/equatable.dart';

class Playlist extends Equatable {
  final String id;
  final String name;
  final String url;
  final String? description;
  final String? thumbnailUrl;
  final int videoCount;
  final DateTime createdAt;
  final DateTime? lastUpdated;
  final String? lastWatchedVideoId;
  final int? lastWatchedTimestamp;

  const Playlist({
    required this.id,
    required this.name,
    required this.url,
    this.description,
    this.thumbnailUrl,
    this.videoCount = 0,
    required this.createdAt,
    this.lastUpdated,
    this.lastWatchedVideoId,
    this.lastWatchedTimestamp,
  });

  Playlist copyWith({
    String? id,
    String? name,
    String? url,
    String? description,
    String? thumbnailUrl,
    int? videoCount,
    DateTime? createdAt,
    DateTime? lastUpdated,
    String? lastWatchedVideoId,
    int? lastWatchedTimestamp,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      videoCount: videoCount ?? this.videoCount,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      lastWatchedVideoId: lastWatchedVideoId ?? this.lastWatchedVideoId,
      lastWatchedTimestamp: lastWatchedTimestamp ?? this.lastWatchedTimestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'videoCount': videoCount,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'lastWatchedVideoId': lastWatchedVideoId,
      'lastWatchedTimestamp': lastWatchedTimestamp,
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      description: map['description'],
      thumbnailUrl: map['thumbnailUrl'],
      videoCount: map['videoCount'] ?? 0,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      lastUpdated: map['lastUpdated'] != null ? DateTime.parse(map['lastUpdated']) : null,
      lastWatchedVideoId: map['lastWatchedVideoId'],
      lastWatchedTimestamp: map['lastWatchedTimestamp'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        url,
        description,
        thumbnailUrl,
        videoCount,
        createdAt,
        lastUpdated,
        lastWatchedVideoId,
        lastWatchedTimestamp,
      ];
}
