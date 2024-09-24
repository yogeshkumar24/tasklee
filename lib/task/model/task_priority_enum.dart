enum TaskPriority {
  low,
  medium,
  high;

  static TaskPriority priorityFromString(String priority) {
    switch (priority) {
      case 'High':
        return TaskPriority.high;
      case 'Medium':
        return TaskPriority.medium;
      case 'Low':
        return TaskPriority.low;
      default:
        return TaskPriority.medium;
    }
  }
}
