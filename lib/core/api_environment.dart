class ApiEnvironment {
  static const appName = "Inovola";
  static final appUrl = "${Uri.base.toString().split("#").first}#";

  static const baseUrl = String.fromEnvironment('BASE_URL');
  static const apiUrl = baseUrl;
}
