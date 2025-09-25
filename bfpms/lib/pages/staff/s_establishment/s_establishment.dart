import 'package:bfpms/custom/route.dart';
import 'package:bfpms/models/establishment_model.dart';
import 'package:bfpms/pages/admin/a_map/a_map_screen.dart';
import 'package:bfpms/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstablishmentManagementScreen extends StatelessWidget {
  const EstablishmentManagementScreen({super.key});

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
                  child: Text(
                    'Establishment Management',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => EstablishmentFormDialog(),
                    // );
                  },
                  child: const Text('Add Establishment'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: adminProvider.establishments.length,
                itemBuilder: (context, index) {
                  final establishment = adminProvider.establishments[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.business)),
                      title: Text(establishment.name),
                      subtitle: Text(
                        '${establishment.type} • ${establishment.address}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) => EstablishmentFormDialog(),
                              // );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _showDeleteDialog(context, establishment);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.map),
        onPressed: () {
          SmoothRoute(
            context: context,
            child: EstablishmentMapScreen(),
          ).route();
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Establishment establishment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Establishment'),
        content: Text('Are you sure you want to delete ${establishment.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<AdminProvider>(
                context,
                listen: false,
              ).deleteEstablishment(establishment.id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
