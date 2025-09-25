import 'package:bfpms/models/staff_assignment.dart';
import 'package:bfpms/pages/admin/a_staff_assignment/a_assignment_form.dart'
    show AssignmentFormDialog;
import 'package:bfpms/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: const Text(
                    'Staff Assignments',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (adminProvider.staffList.isEmpty ||
                        adminProvider.establishments.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please add staff and establishments first',
                          ),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (context) => const AssignmentFormDialog(),
                    );
                  },
                  child: const Text('Assign Staff'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Total Assignments: ${adminProvider.assignments.length}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: adminProvider.assignments.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No assignments found',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Text(
                            'Click "Assign Staff" to create assignments',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: adminProvider.assignments.length,
                      itemBuilder: (context, index) {
                        final assignment = adminProvider.assignments[index];
                        final staff = adminProvider.getStaffById(
                          assignment.staffId,
                        );
                        final establishment = adminProvider
                            .getEstablishmentById(assignment.establishmentId);

                        if (staff == null || establishment == null) {
                          return const SizedBox();
                        }

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[100],
                              child: const Icon(
                                Icons.assignment,
                                color: Colors.blue,
                              ),
                            ),
                            title: Text(
                              staff.fullName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Establishment: ${establishment.name}'),
                                Text('Role: ${assignment.role}'),
                                Text(
                                  'Assigned: ${_formatDate(assignment.assignmentDate)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _showDeleteDialog(context, assignment);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showDeleteDialog(BuildContext context, StaffAssignment assignment) {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    final staff = adminProvider.getStaffById(assignment.staffId);
    final establishment = adminProvider.getEstablishmentById(
      assignment.establishmentId,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Assignment'),
        content: Text(
          'Are you sure you want to remove ${staff?.fullName ?? 'this staff member'} '
          'from ${establishment?.name ?? 'this establishment'}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              adminProvider.removeAssignment(assignment.id);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Assignment removed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
