import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/staff_assignment.dart';
import '../../../providers/admin_provider.dart';

class AssignmentFormDialog extends StatefulWidget {
  const AssignmentFormDialog({super.key});

  @override
  State<AssignmentFormDialog> createState() => _AssignmentFormDialogState();
}

class _AssignmentFormDialogState extends State<AssignmentFormDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedStaffId;
  String? _selectedEstablishmentId;
  final _roleController = TextEditingController();

  @override
  void dispose() {
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);

    return AlertDialog(
      title: const Text('Assign Staff to Establishment'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedStaffId,
                decoration: const InputDecoration(
                  labelText: 'Staff Member',
                  border: OutlineInputBorder(),
                ),
                items: adminProvider.staffList.map((staff) {
                  return DropdownMenuItem(
                    value: staff.id,
                    child: Text('${staff.fullName} (Staff)'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStaffId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a staff member';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedEstablishmentId,
                decoration: const InputDecoration(
                  labelText: 'Establishment',
                  border: OutlineInputBorder(),
                ),
                items: adminProvider.establishments.map((establishment) {
                  return DropdownMenuItem(
                    value: establishment.id,
                    child: Text(
                      '${establishment.name} (${establishment.type})',
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedEstablishmentId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an establishment';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _roleController,
                decoration: const InputDecoration(
                  labelText: 'Role/Position',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Manager, Supervisor, Staff',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a role';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Check if this assignment already exists
              final existingAssignment = adminProvider.assignments.firstWhere(
                (assignment) =>
                    assignment.staffId == _selectedStaffId &&
                    assignment.establishmentId == _selectedEstablishmentId,
                orElse: () => StaffAssignment(
                  id: '',
                  staffId: '',
                  establishmentId: '',
                  assignmentDate: DateTime.now(),
                  role: '',
                ),
              );

              if (existingAssignment.id.isNotEmpty) {
                // Show warning if assignment already exists
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Assignment Exists'),
                    content: const Text(
                      'This staff member is already assigned to this establishment.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                return;
              }

              final assignment = StaffAssignment.create(
                staffId: _selectedStaffId!,
                establishmentId: _selectedEstablishmentId!,
                role: _roleController.text,
              );
              adminProvider.assignStaff(assignment);
              Navigator.pop(context);

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Staff assigned successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: const Text('Assign'),
        ),
      ],
    );
  }
}
