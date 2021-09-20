class Register {
  final String fullname;
  final String phone;
  final String email;

  Register(this.fullname, this.phone, this.email);
  factory Register.fromMap(Map<String, dynamic> json) {
    return Register(
      json['fullname'],
      json['phone'],
      json['email'],
    );
  }
}
