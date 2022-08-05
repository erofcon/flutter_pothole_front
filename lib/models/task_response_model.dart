import 'dart:convert';

TaskResponseModel taskResponseModel(String str) =>
    TaskResponseModel.fromJson(json.decode(str));

Answer answerResponseModel(String str) =>
    Answer.fromJson(json.decode(str));


class TaskResponseModel {
  TaskResponseModel({
    required this.id,
    required this.category,
    required this.executor,
    required this.creator,
    required this.images,
    required this.answer,
    required this.state,
    required this.createDateTime,
    required this.leadDateTime,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.isDone,
  });

  late final int id;
  late final Category category;
  late final Executor executor;
  late final Creator creator;
  late final List<Images?> images;
  late final List<Answer> answer;
  late final String state;
  late final String createDateTime;
  late final String leadDateTime;
  late final String description;
  late final double latitude;
  late final double longitude;
  late final bool isDone;

  TaskResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = Category.fromJson(json['category']);
    executor = Executor.fromJson(json['executor']);
    creator = Creator.fromJson(json['creator']);
    images = List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    answer = List.from(json['answer']).map((e) => Answer.fromJson(e)).toList();
    state = json['state'];
    createDateTime = json['createDateTime'];
    leadDateTime = json['leadDateTime'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDone = json['is_done'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category.toJson();
    data['executor'] = executor.toJson();
    data['creator'] = creator.toJson();
    data['images'] = images.map((e) => e?.toJson()).toList();
    data['answer'] = answer.map((e) => e.toJson()).toList();
    data['state'] = state;
    data['createDateTime'] = createDateTime;
    data['leadDateTime'] = leadDateTime;
    data['description'] = description;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_done'] = isDone;
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

  Category.fromJson(Map<String, dynamic> json) {
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

  Executor.fromJson(Map<String, dynamic> json) {
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

  Creator.fromJson(Map<String, dynamic> json) {
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

class Images {
  Images({
    required this.id,
    required this.url,
  });

  late final int id;
  late final String url;

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class Answer {
  Answer({
    required this.id,
    required this.answerImages,
    required this.replyDate,
    required this.description,
    required this.task,
  });

  late final int id;
  late final List<AnswerImages> answerImages;
  late final String replyDate;
  late final String description;
  late final int task;

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answerImages = List.from(json['answerImages'])
        .map((e) => AnswerImages.fromJson(e))
        .toList();
    replyDate = json['replyDate'];
    description = json['description'];
    task = json['task'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['answerImages'] = answerImages.map((e) => e.toJson()).toList();
    data['replyDate'] = replyDate;
    data['description'] = description;
    data['task'] = task;
    return data;
  }
}

class AnswerImages {
  AnswerImages({
    required this.id,
    required this.url,
    required this.answer,
  });

  late final int id;
  late final String url;
  late final int answer;

  AnswerImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['answer'] = answer;
    return data;
  }
}
