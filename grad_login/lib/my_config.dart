class Config {
  static const String apiUrl = "http://64.225.110.140:8000";
  static const String simpleMeds = '$apiUrl/medicine/simple_meds/';
  static const String interactionMain = '$apiUrl/medicine/interactions/';
  static const String login = '$apiUrl/auth/jwt/create/';
  static const String register = '$apiUrl/auth/users/';
  static const String myProfile = '$apiUrl/auth/users/me/';
  static const String userMedications = '$apiUrl/users/medications/';
  static const String refreshJWT = '$apiUrl/auth/jwt/refresh/';
  static const String drugs = '$apiUrl/medicine/products/';
  static const String addresses = '$apiUrl/users/addresses/';
  static const String carts = '$apiUrl/store/carts/';
  static const String orders = '$apiUrl/store/orders/';
  static const String contRegister = '$apiUrl/users/patients/me/';
}
