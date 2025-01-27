import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_data_model.dart';

final userDataProvider = StateNotifierProvider<UserDataNotifier, UserDataModel?>((ref) {
  return UserDataNotifier();
});

class UserDataNotifier extends StateNotifier<UserDataModel?> {
  UserDataNotifier() : super(null); // Initial state is null.

  void setUserData(UserDataModel userData) {
    state = userData;
  }

  void clearUserData() {
    state = null;
  }
}
