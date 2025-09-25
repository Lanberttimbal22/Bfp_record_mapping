import 'package:bfpms/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../custom/functions.dart';

class EstablishmentMapScreen extends StatefulWidget {
  final bool? isSelectLoc;
  const EstablishmentMapScreen({super.key, this.isSelectLoc = false});

  @override
  State<EstablishmentMapScreen> createState() => _EstablishmentMapScreenState();
}

class _EstablishmentMapScreenState extends State<EstablishmentMapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  CameraPosition? _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    mapInit();
  }

  Future<void> mapInit() async {
    LatLng myLocation = await Functions().getLocation();
    _initialCameraPosition = CameraPosition(
      target: myLocation, // Example: Manila center
      zoom: 15,
    );
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final establishments = Provider.of<AdminProvider>(context).establishments;
    // Clear previous markers
    _markers.clear();

    // Add markers for establishments with lat & lng
    for (final est in establishments) {
      if (est.latitude != null && est.longitude != null) {
        _markers.add(
          Marker(
            markerId: MarkerId(est.id),
            position: LatLng(est.latitude!, est.longitude!),
            infoWindow: InfoWindow(
              title: est.name,
              snippet: est.address,
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Selected ${est.name}')));
              },
            ),
          ),
        );
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Establishment Map')),
      body: _initialCameraPosition == null
          ? Container()
          : GoogleMap(
              initialCameraPosition: _initialCameraPosition!,
              markers: _markers,
              myLocationEnabled: true,
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
    );
  }
}
