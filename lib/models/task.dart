import 'package:project_app/services/api.dart';

class Task {
  final ApiService apiService = ApiService();

  final int? id;
  final String? title;
  final String? description;
  final int? dateCreation;
  final int? dateCompleted;
  final int? dateDue;
  final String? colorId;
  final int? projectId;
  final int? columnId;
  final int? ownerId;
  final int? position;
  final int? score;
  final int? isActive;
  final int? categoryId;
  final int? creatorId;
  final int? dateModification;
  final String? reference;
  final int? dateStarted;
  final int? timeSpent;
  final int? timeEstimated;
  final int? swimlaneId;
  final int? dateMoved;
  final int? recurrenceStatus;
  final int? recurrenceTrigger;
  final int? recurrenceFactor;
  final int? recurrenceTimeframe;
  final int? recurrenceBasedate;
  final int? recurrenceParent;
  final int? recurrenceChild;
  final int? priority;
  final String? externalProvider;
  final String? externalUri;
  final int? ownerGp;
  final int? ownerMs;
  final String? url;

  Task({
    this.id,
    this.title,
    this.description,
    this.dateCreation,
    this.dateCompleted,
    this.dateDue,
    this.colorId,
    this.projectId,
    this.columnId,
    this.ownerId,
    this.position,
    this.score,
    this.isActive,
    this.categoryId,
    this.creatorId,
    this.dateModification,
    this.reference,
    this.dateStarted,
    this.timeSpent,
    this.timeEstimated,
    this.swimlaneId,
    this.dateMoved,
    this.recurrenceStatus,
    this.recurrenceTrigger,
    this.recurrenceFactor,
    this.recurrenceTimeframe,
    this.recurrenceBasedate,
    this.recurrenceParent,
    this.recurrenceChild,
    this.priority,
    this.externalProvider,
    this.externalUri,
    this.ownerGp,
    this.ownerMs,
    this.url,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dateCreation: json['date_creation'],
      dateCompleted: json['date_completed'],
      dateDue: json['date_due'],
      colorId: json['color_id'],
      projectId: json['project_id'],
      columnId: json['column_id'],
      ownerId: json['owner_id'],
      position: json['position'],
      score: json['score'],
      isActive: json['is_active'],
      categoryId: json['category_id'],
      creatorId: json['creator_id'],
      dateModification: json['date_modification'],
      reference: json['reference'],
      dateStarted: json['date_started'],
      timeSpent: json['time_spent'],
      timeEstimated: json['time_estimated'],
      swimlaneId: json['swimlane_id'],
      dateMoved: json['date_moved'],
      recurrenceStatus: json['recurrence_status'],
      recurrenceTrigger: json['recurrence_trigger'],
      recurrenceFactor: json['recurrence_factor'],
      recurrenceTimeframe: json['recurrence_timeframe'],
      recurrenceBasedate: json['recurrence_basedate'],
      recurrenceParent: json['recurrence_parent'],
      recurrenceChild: json['recurrence_child'],
      priority: json['priority'],
      externalProvider: json['external_provider'],
      externalUri: json['external_uri'],
      ownerGp: json['owner_gp'],
      ownerMs: json['owner_ms'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date_creation': dateCreation,
      'date_completed': dateCompleted,
      'date_due': dateDue,
      'color_id': colorId,
      'project_id': projectId,
      'column_id': columnId,
      'owner_id': ownerId,
      'position': position,
      'score': score,
      'is_active': isActive,
      'category_id': categoryId,
      'creator_id': creatorId,
      'date_modification': dateModification,
      'reference': reference,
      'date_started': dateStarted,
      'time_spent': timeSpent,
      'time_estimated': timeEstimated,
      'swimlane_id': swimlaneId,
      'date_moved': dateMoved,
      'recurrence_status': recurrenceStatus,
      'recurrence_trigger': recurrenceTrigger,
      'recurrence_factor': recurrenceFactor,
      'recurrence_timeframe': recurrenceTimeframe,
      'recurrence_basedate': recurrenceBasedate,
      'recurrence_parent': recurrenceParent,
      'recurrence_child': recurrenceChild,
      'priority': priority,
      'external_provider': externalProvider,
      'external_uri': externalUri,
      'owner_gp': ownerGp,
      'owner_ms': ownerMs,
      'url': url,
    };
  }

  Future<List<Task>> getTaskByProject(int id) async {
    final result = await apiService.getTaskByProject(id);

    // print(result.runtimeType);
    // print(result);

    if (result is Map<String, dynamic>) {
      return [Task.fromJson(result)];
    } else if (result is List) {
      return result.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Unexpected response format');
    }
  }

  Future<int> getTaskCountByProject(int id) async {
    final result = await apiService.getTaskByProject(id);
    
    if (result is Map<String, dynamic>) {
      return 1;
    } else if (result is List) {
      return result.length;
    } else {
      throw Exception('Unexpected response format');
    }
  }
}
