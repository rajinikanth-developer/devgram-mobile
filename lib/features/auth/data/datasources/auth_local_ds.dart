import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/strings/app_strings.dart';
import '../../../../core/constants/strings/validation_messages.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> register(UserModel user);
  Future<UserModel?> getCurrentUser();
  Future<void> logout();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  Box<UserModel> userBox = Hive.box<UserModel>(AppStrings.userBox);
  Box sessionBox = Hive.box(AppStrings.authBox);

  AuthLocalDataSourceImpl({required this.userBox});

  @override
  Future<void> register(UserModel userPayload) async {
    if (userBox.values.any((user) => user.email == userPayload.email)) {
      throw Exception(AppValidationMessages.emailExisted);
    }
    await userBox.put(userPayload.email, userPayload);
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final user = userBox.get(email);
      if (user == null) {
        throw Exception(AppValidationMessages.userNotFound);
      }

      if (user.password != password) {
        throw Exception(AppValidationMessages.loginFailed);
      } else {
        final deviceInfo = await DeviceInfoPlugin().androidInfo;
        final deviceId = deviceInfo.id;
        user.isLoggedIn = true;
        await sessionBox.put(deviceId, email);
        return user;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      final deviceId = deviceInfo.id;
      final userEmail = sessionBox.get(deviceId);
      if (userEmail == null) return null;
      return userBox.get(userEmail);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final deviceId = deviceInfo.id;
    final user = await getCurrentUser();
    if (user != null) {
      user.isLoggedIn = false;
    }
    user!.save();
    await sessionBox.delete(deviceId);
  }
}
