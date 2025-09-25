import 'package:bfpms/custom/route.dart';
import 'package:bfpms/pages/admin/a_staff_form_reg/a_staff_reg_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/staff_models.dart';
import 'a_staff_management_controller.dart';

class StaffManagementScreen extends ConsumerStatefulWidget {
  const StaffManagementScreen({super.key});

  @override
  ConsumerState<StaffManagementScreen> createState() =>
      _StaffManagementScreenState();
}

class _StaffManagementScreenState extends ConsumerState<StaffManagementScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(staffAssignmentControllerProvider);
    final controller = ref.read(staffAssignmentControllerProvider.notifier);
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
                  child: Text(
                    'Staff Management',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    final respo = await SmoothRoute(
                      context: context,
                      child: StaffFormRegistrationScreen(),
                    ).route();

                    if (respo != null && respo) {
                      controller.fetchData();
                    }
                  },
                  child: const Text('Add Staff'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.fetchData,
                child: ListView.builder(
                  itemCount: controller.staffList.length,
                  itemBuilder: (context, index) {
                    final staff = controller.staffList[index];

                    return Card(
                      child: ListTile(
                        title: Text(staff["full_name"]),
                        subtitle: Text("${staff["role_name"]}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Staff staff) {
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('Delete Staff'),
    //     content: Text('Are you sure you want to delete ${staff.fullName}?'),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.pop(context),
    //         child: const Text('Cancel'),
    //       ),
    //       TextButton(
    //         onPressed: () {
    //           Provider.of<AdminProvider>(
    //             context,
    //             listen: false,
    //           ).deleteStaff(staff.id);
    //           Navigator.pop(context);
    //         },
    //         child: const Text('Delete'),
    //       ),
    //     ],
    //   ),
    // );
  }
}
