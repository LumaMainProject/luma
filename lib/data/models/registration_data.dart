import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationData {
  final String role;
  final String email;
  final String name;
  final bool emailVerified;
  final bool agreedToTerms;
  final bool agreedToEmails;
  final Timestamp createdAt;

  RegistrationData({
    this.role = "user",
    this.name = "name",
    this.email = "",
    this.emailVerified = false,
    this.agreedToTerms = false,
    this.agreedToEmails = false,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  RegistrationData copyWith({
    String? role,
    String? email,
    String? name,
    bool? emailVerified,
    bool? agreedToTerms,
    bool? agreedToEmails,
    Timestamp? createdAt,
  }) {
    return RegistrationData(
      role: role ?? this.role,
      email: email ?? this.email,
      name: name ?? this.name,
      emailVerified: emailVerified ?? this.emailVerified,
      agreedToTerms: agreedToTerms ?? this.agreedToTerms,
      agreedToEmails: agreedToEmails ?? this.agreedToEmails,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
