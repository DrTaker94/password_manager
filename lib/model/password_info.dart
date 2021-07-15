import 'package:hive/hive.dart';

part 'password_info.g.dart';

@HiveType(typeId: 0)
class PasswordInfo extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String url;
  @HiveField(5)
  final String notes;

  PasswordInfo({
    required this.id,
    required this.title,
    required this.username,
    required this.password,
    required this.url,
    required this.notes,
  });
}
