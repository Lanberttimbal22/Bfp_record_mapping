import 'package:bfpms/pages/admin/a_establishments/a_establishments_controller.dart';
import 'package:bfpms/custom/custom_text.dart';
import 'package:bfpms/pages/admin/a_staff_management/a_staff_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminEstablishment extends ConsumerStatefulWidget {
  const AdminEstablishment({super.key});

  @override
  ConsumerState<AdminEstablishment> createState() => _AdminEstablishmentState();
}

class _AdminEstablishmentState extends ConsumerState<AdminEstablishment> {
  @override
  Widget build(BuildContext context) {
    ref.watch(adminEstablishmentControllerProvider);
    final controller = ref.read(staffAssignmentControllerProvider.notifier);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(19),
              child: Text(
                'Establishment Management',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            TabBar(
              tabs: [
                Tab(text: "Pending"),
                Tab(text: "Approved"),
                Tab(text: "Map View"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Home Tab')),
                  Center(child: Text('Staff Tab')),
                  Center(child: Text('Settings Tab')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
