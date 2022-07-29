import 'dart:convert';

RelatedUser taskCategory(String str) => RelatedUser.fromJson(json.decode(str));

class RelatedUser {
  RelatedUser({
    required this.id,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isCreator,
    required this.isExecutor,
    required this.numberPhone,
    required this.groups,
  });

  late final int id;
  late final bool isSuperuser;
  late final String username;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final bool isCreator;
  late final bool isExecutor;
  late final String numberPhone;
  late final List<int> groups;

  RelatedUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSuperuser = json['is_superuser'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isCreator = json['is_creator'];
    isExecutor = json['is_executor'];
    numberPhone = json['number_phone'];
    groups = List.castFrom<dynamic, int>(json['groups']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['is_superuser'] = isSuperuser;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['is_creator'] = isCreator;
    data['is_executor'] = isExecutor;
    data['number_phone'] = numberPhone;
    data['groups'] = groups;
    return data;
  }
}
