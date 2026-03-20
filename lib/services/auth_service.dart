import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyUsers = 'registered_users';
  static const String _keyIsLoggedIn = 'is_logged_in';

  // Lấy danh sách user từ local storage
  Future<Map<String, dynamic>> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersJson = prefs.getString(_keyUsers);
    if (usersJson == null) return {};
    return jsonDecode(usersJson);
  }

  // Kiểm tra user đã tồn tại chưa
  Future<bool> userExists(String username) async {
    final users = await _getUsers();
    return users.containsKey(username);
  }

  // Đăng ký user mới
  Future<bool> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _getUsers();
    
    if (users.containsKey(username)) return false;

    users[username] = password;
    await prefs.setString(_keyUsers, jsonEncode(users));
    return true;
  }

  // Đăng nhập
  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _getUsers();

    if (users.containsKey(username) && users[username] == password) {
      await prefs.setBool(_keyIsLoggedIn, true);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }
}
