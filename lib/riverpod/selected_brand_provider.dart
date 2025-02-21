import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedBrandProvider = StateNotifierProvider<SelectedbrandProvider, List<String>>((ref) {
  return SelectedbrandProvider();
});

class SelectedbrandProvider extends StateNotifier<List<String>> {
  SelectedbrandProvider() : super(['']);

  void update(List<String> val) {
    state = val;
  }

  // Function to add a brand to the list
  void addBrand(String brand) {
    if (!state.contains(brand)) {
      state = [...state, brand]; // Creates a new list with added brand
    }
  }

  // Function to remove a brand from the list
  void removeBrand(String brand) {
    state = state.where((b) => b != brand).toList(); // Creates a new list excluding the removed brand
  }
}
