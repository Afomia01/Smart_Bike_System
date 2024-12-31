class Bike {
  final String id;
  final String userId; // Owner or current user of the bike
  final String location; // Current GPS location
  final bool isAvailable; // Availability status
  final Lock? lock; // Lock object (optional)

  Bike({
    required this.id,
    required this.userId,
    required this.location,
    required this.isAvailable,
    this.lock,
  });

  // From JSON (useful when fetching from Firebase)
  factory Bike.fromJson(Map<String, dynamic> json) {
    return Bike(
      id: json['id'],
      userId: json['userId'],
      location: json['location'],
      isAvailable: json['isAvailable'],
      lock: json['lock'] != null ? Lock.fromJson(json['lock']) : null,
    );
  }

  // To JSON (useful when saving to Firebase)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'location': location,
      'isAvailable': isAvailable,
      'lock': lock?.toJson(),
    };
  }
}

class Lock {
  final String status; // locked/unlocked
  final String command; // lock/unlock
  final int lastUpdated; // Timestamp
  final double latitude; // Latitude of the lock
  final double longitude; // Longitude of the lock

  Lock({
    required this.status,
    required this.command,
    required this.lastUpdated,
    required this.latitude,
    required this.longitude,
  });

  factory Lock.fromJson(Map<String, dynamic> json) {
    return Lock(
      status: json['status'],
      command: json['command'],
      lastUpdated: json['lastUpdated'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'command': command,
      'lastUpdated': lastUpdated,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
