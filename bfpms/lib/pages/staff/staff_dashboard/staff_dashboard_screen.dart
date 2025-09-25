import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'staff_controller.dart';

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the state of your controller (StaffState)
    final staffState = ref.watch(staffControllerProvider);

    // Read your controller to call methods (like Staff)
    final staffController = ref.read(staffControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Dashboard'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Establishment Registration',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () async {},
                  label: const Text('Add'),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(title: Text("index"));
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 5);
                },
                itemCount: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
