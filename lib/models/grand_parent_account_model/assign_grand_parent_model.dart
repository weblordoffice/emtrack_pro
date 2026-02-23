class AssignGrandparentModel {
  final int parentAccountId;
  final int grandparentAccountId;

  AssignGrandparentModel({
    required this.parentAccountId,
    required this.grandparentAccountId,
  });

  Map<String, dynamic> toJson() {
    return {
      "parentAccountId": parentAccountId,
      "grandparentAccountId": grandparentAccountId,
    };
  }
}
