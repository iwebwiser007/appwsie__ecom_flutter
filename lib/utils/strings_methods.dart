import 'package:intl/intl.dart';

String getInitials(String name) {
  if (name.isEmpty) {
    return "MB";
  }

  List<String> nameParts = name.trim().split(" ");

// If there's only one part or it's too short
  if (nameParts.length == 1) {
    if (nameParts[0].length >= 2) {
      return "${nameParts[0][0].toUpperCase()}${nameParts[0][1].toUpperCase()}";
    } else {
      return nameParts[0][0].toUpperCase();
    }
  }

// Ensure the parts have enough characters
  String firstInitial = nameParts[0].isNotEmpty ? nameParts[0][0].toUpperCase() : "";
  String secondInitial = nameParts[1].isNotEmpty ? nameParts[1][0].toUpperCase() : "";

  return "$firstInitial$secondInitial";
}

String safeString(String? value, [String defaultValue = 'N/A']) {
  return (value == null || value.trim().isEmpty) ? defaultValue : value.trim();
}

String showPrice(String? value, [String defaultValue = 'N/A']) {
  if (value == null || value.trim().isEmpty) {
    return defaultValue;
  }

  try {
    final number = double.parse(value.trim());
    final formattedPrice = NumberFormat.currency(
      locale: 'en_US',
      symbol: 'R', // Currency symbol
      decimalDigits: 0, // No decimal places
    ).format(number);

    return formattedPrice;
  } catch (e) {
    // Return defaultValue if parsing fails
    return defaultValue;
  }
}

String extractCityStateCountry(String? area) {
  if (area == null || area.isEmpty) return "Unknown Location";

  List<String> parts = area.split(',').map((e) => e.trim()).toList();

  if (parts.length < 3) return "Incomplete Address";

  return "${parts[parts.length - 3]}, ${parts[parts.length - 2]}, ${parts[parts.length - 1]}";
}
