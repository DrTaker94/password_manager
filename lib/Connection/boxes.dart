import 'package:hive/hive.dart';
import 'package:password_manager/model/password_info.dart';

class Boxes {
  static Box<PasswordInfo> getPasswordInfo() => Hive.box<PasswordInfo>('passwords');
}