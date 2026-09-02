import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class MapPickerPage extends StatefulWidget {
  final LatLng? initialLocation;

  const MapPickerPage({super.key, this.initialLocation});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  static const Color _primary = Color(0xFF5B8DEF);

  LatLng _pickedLocation = const LatLng(31.5497, 74.3436); // default: Lahore
  String _pickedAddress = 'Tap on the map to select a location';

  bool _isLoadingAddress = false;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _pickedLocation = widget.initialLocation!;
    }
  }

  Future<void> _reverseGeocode(LatLng point) async {
    setState(() => _isLoadingAddress = true);
    try {
      final placemarks = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      ).timeout(const Duration(seconds: 8));

    if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final address = [
          p.name,
          p.street,
          p.locality,
          p.administrativeArea,
        ].where((e) => e != null && e.isNotEmpty).join(', ');

        setState(() {
          _pickedAddress = address.isNotEmpty ? address : 'Unknown location';
        });
      }
    } catch (e) {
      setState(() => _pickedAddress = 'Could not fetch address');
    } finally {
      setState(() => _isLoadingAddress = false);
    }
  }

  void _onMapTap(TapPosition tapPosition, LatLng point) {
    if (_isLoadingAddress) return;
    setState(() => _pickedLocation = point);
    _reverseGeocode(point);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pin Location'),
        backgroundColor: _primary,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _pickedLocation,
              initialZoom: 14,
              onTap: _onMapTap,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.safearrive',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _pickedLocation,
                    width: 44,
                    height: 44,
                    child: const Icon(
                      Icons.location_on,
                      color: _primary,
                      size: 44,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── Bottom card with address + confirm button ──
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Location',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _isLoadingAddress
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : Text(
                    _pickedAddress,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoadingAddress
                          ? null
                          : () {
                        Navigator.pop(context, {
                          'address': _pickedAddress,
                          'lat': _pickedLocation.latitude,
                          'lng': _pickedLocation.longitude,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Confirm Location'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}