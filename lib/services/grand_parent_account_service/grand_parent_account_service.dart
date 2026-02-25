import 'package:emtrack/models/grand_parent_account_model/assign_grand_parent_model.dart';
import 'package:emtrack/models/grand_parent_account_model/grand_parent_account_model.dart';

class GrandparentAccountService {
  /// CREATE
  Future<void> createGrandparent(GrandparentAccountModel model) async {
    await Future.delayed(const Duration(seconds: 1));
    // POST API here
  }

  /// ASSIGN
  Future<void> assignGrandparent(AssignGrandparentModel model) async {
    await Future.delayed(const Duration(seconds: 1));
    // POST API here
  }
}
