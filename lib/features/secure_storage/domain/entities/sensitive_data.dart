class SensitiveData {
  final String? nameCompany;
  final String? fullName;
  final String? email;
  final String? password;

  const SensitiveData({
    this.nameCompany,
    this.fullName,
    this.email,
    this.password,
  });

  bool get isEmpty =>
      nameCompany == null &&
          fullName == null &&
          email == null &&
          password == null;

  @override
  String toString() =>
      'SensitiveData(nameCompany: ${nameCompany != null ? "***" : "null"}, '
          'fullName: ${fullName != null ? "***" : "null"}, '
          'email: ${email != null ? "***" : "null"}, '
          'password: ${password != null ? "***" : "null"})';
}