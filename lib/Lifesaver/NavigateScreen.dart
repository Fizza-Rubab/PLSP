import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  final LatLng destination;

  MapScreen({required this.destination});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  late Position _currentPosition;
  Set<Marker> _markers = Set<Marker>();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _markers.add(Marker(
          markerId: MarkerId('Destination'),
          position: widget.destination,
          infoWindow: InfoWindow(title: 'Destination')));
    });
    _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 16,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
                  zoom: 16),
              markers: _markers,
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  color: Colors.red,
                  points: [
                    LatLng(_currentPosition.latitude, _currentPosition.longitude),
                    widget.destination
                  ],
                ),
              },
            ),
    );
  }
}
