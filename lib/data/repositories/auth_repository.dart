import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luma_2/data/models/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  // ------------------ Singleton ------------------
  static final AuthRepository instance = AuthRepository._internal();
  AuthRepository._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ------------------ Streams ------------------
  Stream<User?> get userChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  // ------------------ Email link auth ------------------
  Future<void> sendSignInLink(String email) async {
    final actionCodeSettings = ActionCodeSettings(
      url: 'https://luma2-b50a2.web.app',
      handleCodeInApp: true,
      androidPackageName: 'com.example.luma_2',
      androidInstallApp: true,
      androidMinimumVersion: '21',
    );

    await _auth.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: actionCodeSettings,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emailForSignIn', email);
  }

  Future<void> signInWithEmailLink(String emailLink) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('emailForSignIn');

    if (email != null && _auth.isSignInWithEmailLink(emailLink)) {
      await _auth.signInWithEmailLink(email: email, emailLink: emailLink);
      await prefs.remove('emailForSignIn');
    }
  }

  /// Авторизация по email напрямую (финальная для тестов, без FirebaseAuth)
  Future<UserProfile?> signInWithEmailOnly(String email) async {
    final query = await _firestore
        .collection("users")
        .where("emails", arrayContains: email)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return UserProfile.fromJson(doc.data(), doc.id);
  }

  // ------------------ Auth utils ------------------
  Future<void> signOut() async => _auth.signOut();
  Future<void> signInAsGuest() async => _auth.signInAnonymously();

  // ------------------ Test login ------------------
  Future<UserProfile?> signInTestUser(String email) async {
    final query = await _firestore
        .collection("users")
        .where("emails", arrayContains: email)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return UserProfile.fromJson(doc.data(), doc.id);
  }
}
