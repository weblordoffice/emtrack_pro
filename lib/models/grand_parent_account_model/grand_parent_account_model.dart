class GrandparentAccountModel {
  final String accountType;
  final String grandparentName;

  GrandparentAccountModel({
    required this.accountType,
    required this.grandparentName,
  });

  Map<String, dynamic> toJson() {
    return {"accountType": accountType, "grandparentName": grandparentName};
  }
}
