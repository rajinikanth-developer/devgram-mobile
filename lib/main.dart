import 'package:devgram/core/constants/strings/app_strings.dart';
import 'package:devgram/devgram.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'features/auth/data/models/user_model.dart';
import 'features/feed/data/models/post_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final devgramDir = await getApplicationDocumentsDirectory();
  Hive.init(devgramDir.path);
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(PostModelAdapter());

  await Hive.openBox<UserModel>(AppStrings.userBox);
  await Hive.openBox<PostModel>(AppStrings.postsBox);
  await Hive.openBox(AppStrings.authBox);
  runApp(const Devgram());
}
