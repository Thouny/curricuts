class RouteParameters {
  static const activityID = 'activityID';
  static const userAttemptID = 'userAttemptID';
  static const relatedActivityID = 'relatedActivityID';
  static const activityCategoryID = 'activityCategoryID';
}

class QueryParameters {
  static const path = 'path';
  static const phoneNumber = 'phoneNumber';
  static const token = 'token';
  static const shouldRestart = 'shouldRestart';
  static const title = 'title';
  static const description = 'description';
  static const showToggle = 'showToggle';
  static const notificationType = 'notificationType';
  static const appPinFlowType = 'appPinFlowType';
  static const weekDays = 'weekDays';
}

extension RoutingMapHelpers on Map<String, String> {
  // route params
  String? get activityID => this[RouteParameters.activityID];
  String? get userAttemptID => this[RouteParameters.userAttemptID];
  String? get relatedActivityID => this[RouteParameters.relatedActivityID];
  String? get activityCategoryID => this[RouteParameters.activityCategoryID];
  // query params
  String? get path => this[QueryParameters.path];
  String? get phoneNumber => this[QueryParameters.phoneNumber];
  String? get token => this[QueryParameters.token];
  String? get shouldRestart => this[QueryParameters.shouldRestart];
  String? get title => this[QueryParameters.title];
  String? get description => this[QueryParameters.description];
  String? get showToggle => this[QueryParameters.showToggle];
  String? get notificationType => this[QueryParameters.notificationType];
  String? get appPinFlowType => this[QueryParameters.appPinFlowType];
  String? get weekDays => this[QueryParameters.weekDays];
}
