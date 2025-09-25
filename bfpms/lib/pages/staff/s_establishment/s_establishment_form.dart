import 'package:bfpms/constants.dart';
import 'package:bfpms/custom/custom_text.dart';
import 'package:bfpms/models/establishment_model.dart';
import 'package:bfpms/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class EstablishmentFormDialog extends StatefulWidget {
  const EstablishmentFormDialog({super.key});

  @override
  State<EstablishmentFormDialog> createState() =>
      _EstablishmentFormDialogState();
}

class _EstablishmentFormDialogState extends State<EstablishmentFormDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _address = '';
  String _type = '';
  double? _latitude;
  double? _longitude;

  Future<void> _setCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled.')),
        );
        return;
      }

      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to get location: $e')));
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newEstablishment = Establishment.create(
        name: _name,
        address: _address,
        type: _type,
        latitude: _latitude,
        longitude: _longitude,
      );

      Provider.of<AdminProvider>(
        context,
        listen: false,
      ).addEstablishment(newEstablishment);

      Navigator.of(context).pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Establishment'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: ''),
                onSaved: (value) => _name = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                onSaved: (value) => _address = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Type'),
                onSaved: (value) => _type = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _setCurrentLocation,
                icon: const Icon(Icons.my_location),
                label: const Text('Set Current Location'),
              ),
              const SizedBox(height: 10),
              AppText("Select in the map", color: primaryColor),
              if (_latitude != null && _longitude != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Lat: ${_latitude!.toStringAsFixed(6)}, Lng: ${_longitude!.toStringAsFixed(6)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _submitForm, child: const Text('Add')),
      ],
    );
  }
}
