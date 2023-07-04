class Config {
  // static const String apiUrl = "http://192.168.1.8:8000";
  static const String apiUrl = "http://146.190.130.251:8000";
  static const String simpleMeds = '$apiUrl/medicine/simple_meds/';
  static const String refreshToken = '$apiUrl/auth/auth/jwt/refresh/';
  static const String interactionMain = '$apiUrl/medicine/interactions/';
  static const String login = '$apiUrl/auth/jwt/create/';
  static const String register = '$apiUrl/auth/users/';
  static const String myProfile = '$apiUrl/auth/users/me/';
  static const String userMedications = '$apiUrl/users/medications/';
  static const String generalCategories =
      '$apiUrl/medicine/general_categories/';

  static const String subCategories = '$apiUrl/medicine/categories/';
  static const String drugs = '$apiUrl/medicine/products/';
  static const String addresses = '$apiUrl/users/addresses/';
  static const String carts = '$apiUrl/store/carts/';
  static const String wishList = '$apiUrl/store/wishlists/';
  static const String orders = '$apiUrl/store/orders/';
  static const String contRegister = '$apiUrl/users/patients/me/';
  static const String patientProfile = '$apiUrl/users/patients/me/';
  static const String userImage = '$apiUrl/users/usersimages/';
  static const String interactionNotification =
      '$apiUrl/medicine/profile-interactions/';
}
