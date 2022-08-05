

import 'dart:convert';

TaskList taskResult(String str) =>
    TaskList.fromJson(json.decode(str));

class TaskList {
  TaskList({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });
  late final int count;
  late final Null next;
  late final Null previous;
  late final List<Results> results;

  TaskList.fromJson(Map<String, dynamic> json){
    count = json['count'];
    next = null;
    previous = null;
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    data['results'] = results.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Results {
  Results({
    required this.id,
    required this.category,
    required this.executor,
    required this.creator,
    required this.state,
    required this.createDateTime,
  });
  late final int id;
  late final Category category;
  late final Executor executor;
  late final Creator creator;
  late final String state;
  late final String createDateTime;

  Results.fromJson(Map<String, dynamic> json){
    id = json['id'];
    category = Category.fromJson(json['category']);
    executor = Executor.fromJson(json['executor']);
    creator = Creator.fromJson(json['creator']);
    state = json['state'];
    createDateTime = json['createDateTime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category.toJson();
    data['executor'] = executor.toJson();
    data['creator'] = creator.toJson();
    data['state'] = state;
    data['createDateTime'] = createDateTime;
    return data;
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Executor {
  Executor({
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

  Executor.fromJson(Map<String, dynamic> json){
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

class Creator {
  Creator({
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

  Creator.fromJson(Map<String, dynamic> json){
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