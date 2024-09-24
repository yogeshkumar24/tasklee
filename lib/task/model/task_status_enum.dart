enum TaskStatus {
  pending,
  completed;

  bool isCompleted(){
    return this == TaskStatus.completed;
  }
}
