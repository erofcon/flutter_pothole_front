import 'dart:convert';

LoginResponse loginResponse(String str) =>
    LoginResponse.fromJson(json.decode(str));

User currentUser(String str) => User.fromJson(json.decode(str));

class LoginResponse {
  LoginResponse(
      {required this.refresh, required this.access, required this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    user = User.fromJson(json['user']);
  }

  late final String refresh;
  late final String access;
  late final User user;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['refresh'] = refresh;
    data['access'] = access;
    data['user'] = user.toJson();
    return data;
  }
}

class User {
  User({
    required this.id,
    required this.isSuperUser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isCreator,
    required this.isExecutor,
    required this.numberPhone,
    required this.groups,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSuperUser = json['is_superuser'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isCreator = json['is_creator'];
    isExecutor = json['is_executor'];
    numberPhone = json['number_phone'];
    groups = List.castFrom<dynamic, dynamic>(json['groups']);
  }

  late final int id;
  late final bool? isSuperUser;
  late final String username;
  late final String? firstName;
  late final String? lastName;
  late final String? email;
  late final bool? isCreator;
  late final bool? isExecutor;
  late final String? numberPhone;
  late final List<dynamic>? groups;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['is_superuser'] = isSuperUser;
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
