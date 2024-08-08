sealed class BaseEvent {}

class GetProductEvent extends BaseEvent {
  final String id;

  GetProductEvent({required this.id});
}

class GetDepartmentEvent extends BaseEvent {}

class ClearProductEvent extends BaseEvent {}

class ClearDepartmentEvent extends BaseEvent {}
