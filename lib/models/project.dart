import 'package:project_app/services/api.dart';

class Project {
  final ApiService apiService = ApiService();

  int? id;
  String? name;
  bool? isActive;
  String? token;
  int? lastModified;
  bool? isPublic;
  bool? isPrivate;
  String? defaultSwimlane;
  bool? showDefaultSwimlane;
  String? description;
  String? identifier;
  ProjectUrl? url;

  Project({
    this.id,
    this.name,
    this.isActive,
    this.token,
    this.lastModified,
    this.isPublic,
    this.isPrivate,
    this.defaultSwimlane,
    this.showDefaultSwimlane,
    this.description,
    this.identifier,
    this.url,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'] == "1",
      token: json['token'],
      lastModified: json['last_modified'],
      isPublic: json['is_public'] == "0",
      isPrivate: json['is_private'] == "0",
      defaultSwimlane: json['default_swimlane'],
      showDefaultSwimlane: json['show_default_swimlane'] == "1",
      description: json['description'],
      identifier: json['identifier'],
      url: ProjectUrl.fromJson(json['url']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_active': isActive,
      'token': token,
      'last_modified': lastModified,
      'is_public': isPublic,
      'is_private': isPrivate,
      'default_swimlane': defaultSwimlane,
      'show_default_swimlane': showDefaultSwimlane,
      'description': description,
      'identifier': identifier,
      'url': url,
    };
  }

  Future<List<Project>> getAllProject() async {
    final result = await apiService.sendRequest('getMyProjects');
    // print(result);
    if (result is List) {
      return result.map((project) => Project.fromJson(project)).toList();
    } else {
      throw Exception('Unexpected response format');
    }
  }

  Future<List<Project>> getProjectById(int? id) async {
    final result = await apiService.getProjectById(id);
    // print(result.runtimeType);
    if (result is Map<String, dynamic>) {
      return [Project.fromJson(result)];
    } else if (result is List) {
      return result.map((project) => Project.fromJson(project)).toList();
    } else {
      throw Exception('Unexpected response format');
    }
  }

  Future<int> getProjectCount() async {
    final result = await apiService.sendRequest('getMyProjects');

    if (result is Map<String, dynamic>) {
      return 1;
    } else if (result is List) {
      return result.length;
    } else {
      throw Exception('Unexpected response format');
    }
  }
}

class ProjectUrl {
  String? board;
  String? calendar;
  String? list;

  ProjectUrl({
    this.board,
    this.calendar,
    this.list,
  });

  factory ProjectUrl.fromJson(Map<String, dynamic> json) {
    return ProjectUrl(
      board: json['board'],
      calendar: json['calendar'],
      list: json['list'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'board': board,
      'calendar': calendar,
      'list': list,
    };
  }
}
