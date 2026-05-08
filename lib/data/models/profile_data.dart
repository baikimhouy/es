import 'package:flutter/foundation.dart';

/// Singleton that holds the user's profile data locally.
/// Call [ProfileData.instance] from anywhere; listeners are notified on [update].
class ProfileData extends ChangeNotifier {
  ProfileData._();
  static final ProfileData instance = ProfileData._();

  String firstName = 'Moonlight';
  String lastName = 'Shine';
  String email = 'moonlight123@gmail.com';
  String phone = '012 300 400';
  String gender = '';
  String birthday = '01 Jan 2000';
  Uint8List? avatarBytes; // null = show default icon

  String get fullName => '$firstName $lastName'.trim();

  void update({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? gender,
    String? birthday,
    Uint8List? avatarBytes,
  }) {
    if (firstName != null) this.firstName = firstName;
    if (lastName != null) this.lastName = lastName;
    if (email != null) this.email = email;
    if (phone != null) this.phone = phone;
    if (gender != null) this.gender = gender;
    if (birthday != null) this.birthday = birthday;
    if (avatarBytes != null) this.avatarBytes = avatarBytes;
    notifyListeners();
  }
}
