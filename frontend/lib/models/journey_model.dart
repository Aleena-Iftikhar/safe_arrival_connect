import 'dart:convert';

class Journey {
  final int? id;
  final String destinationName;
  final String destinationAddress;
  final String message;
  final List<Map<String, dynamic>> contacts;
  final String? status;
  final DateTime? createdAt;

  Journey({
    this.id,
    required this.destinationName,
    required this.destinationAddress,
    required this.message,
    required this.contacts,
    this.status,
    this.createdAt,
  });

  factory Journey.fromJson(Map<String, dynamic> json) {
    // contacts field can be string or list
    List<Map<String, dynamic>> parsedContacts = [];
    final rawContacts = json['contacts'];

    if (rawContacts is String && rawContacts.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawContacts);
        parsedContacts = List<Map<String, dynamic>>.from(decoded);
      } catch (_) {
        parsedContacts = [];
      }
    } else if (rawContacts is List) {
      parsedContacts = List<Map<String, dynamic>>.from(rawContacts);
    }

    return Journey(
      id: json['id'],
      destinationName: json['destinationName'] ?? '',
      destinationAddress: json['destinationAddress'] ?? '',
      message: json['message'] ?? '',
      contacts: parsedContacts,
      status: json['status'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}