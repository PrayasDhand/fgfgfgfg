import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pkart/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profilePicture,
  });

  String get fullName => '$firstName $lastName';

  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseUserName = '$firstName$lastName';
    String usernameWithPrefix = "cwt_$camelCaseUserName";
    return usernameWithPrefix;
  }

  static UserModel empty() => UserModel(id: '', username: '', email: '', firstName: '', lastName: '', phoneNumber: '', profilePicture: '');

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }
  /// factory method to create the usermodel snapshot from a firebase document snapshot
factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document){
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(id: document.id, username: data['Username'] ?? '', email: data ['Email'] ?? '', firstName: data['FirstName'] ?? '', lastName: data['LastName'] ?? '', phoneNumber:  data['PhoneNumber'] ?? '', profilePicture:  data['ProfilePicture'] ?? '');

    }  else{
      return UserModel.empty();
    }

}
}