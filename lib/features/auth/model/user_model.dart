class AppUser {
  final String uid;
  final String fullName;
  final String address;
  final String email;

  AppUser({
    required this.uid,
    required this.fullName,
    required this.address,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'fullName': fullName,
        'address': address,
        'email': email,
      };
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      fullName: json['fullName'],
      address: json['address'],
      email: json['email'],
    );
  }
}
