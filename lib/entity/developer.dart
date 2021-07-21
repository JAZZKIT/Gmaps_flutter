import 'package:floor/floor.dart';

@entity
class Developer {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  String? firstName;
  String? lastName;
  String? email;
  String? jobTitle;

  Developer({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.jobTitle,
  });
}
