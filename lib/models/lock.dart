class Lock {
  final String status;
  final String command;
  final int lastUpdated;

  Lock({required this.status, required this.command, required this.lastUpdated});

  // Convert Lock object to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'command': command,
      'lastUpdated': lastUpdated,
    };
  }

  // Create Lock object from JSON
  factory Lock.fromJson(Map<String, dynamic> json) {
    return Lock(
      status: json['status'],
      command: json['command'],
      lastUpdated: json['lastUpdated'],
    );
  }
}
