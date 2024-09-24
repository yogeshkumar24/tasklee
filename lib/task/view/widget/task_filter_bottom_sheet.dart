import 'package:flutter/material.dart';
import 'package:tasklee/core/core.dart';
import 'package:tasklee/task/model/model.dart';


class TaskFilterBottomSheet extends StatefulWidget {
  const TaskFilterBottomSheet(this.callback,
      {this.selectedTaskStatus, Key? key})
      : super(key: key);
  final Function(TaskStatus?) callback;
  final TaskStatus? selectedTaskStatus;

  @override
  _TaskFilterBottomSheetState createState() => _TaskFilterBottomSheetState();
}

class _TaskFilterBottomSheetState extends State<TaskFilterBottomSheet> {
  TaskStatus? _selectedStatus;

  @override
  void initState() {
    _selectedStatus = widget.selectedTaskStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filter by Task Status',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: TaskStatus.values.length,
            itemBuilder: (BuildContext context, int index) {
              TaskStatus status = TaskStatus.values[index];
              return RadioListTile<TaskStatus>(
                title: Text(status.name.capitalizeFirst!.split('.').last),
                value: status,
                groupValue: _selectedStatus,
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                  widget.callback(_selectedStatus);
                  Navigator.pop(context);
                },
              );
            },
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                widget.callback(null);
              },
              child: const Text('Reset Filter'))
        ],
      ),
    );
  }
}
