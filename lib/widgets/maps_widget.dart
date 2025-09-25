import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
 class StoreLocation {
  final String name;
  final String address;
  final String hours;
  final double latitude;
  final double longitude;

  const StoreLocation({
    required this.name,
    required this.address,
    required this.hours,
    required this.latitude,
    required this.longitude,
  });
}


 
class MapWidget extends StatefulWidget {
  final StoreLocation location;
 
  const MapWidget({super.key, required this.location});
 
  @override
  State<MapWidget> createState() => _MapWidgetState();
}
 
class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(widget.location.latitude, widget.location.longitude),
            initialZoom: 15.0,    ),
          children: [
            TileLayer(
urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
subdomains: const ['a', 'b', 'c', 'd'],  userAgentPackageName: 'com.example.ext_interview', 
       ),   MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(widget.location.latitude, widget.location.longitude),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40.0,
                  ),
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(widget.location.latitude, widget.location.longitude),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40.0,
                  ),
                ),
              ],
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Widget buildMapSection() {
    const storeLocation = StoreLocation(
      name: 'Sunway Pyramid Garden Center',
      address: 'No 3 Jalan Lagoon Selatan Bandar Mall, Petaling Jaya',
      hours: 'Open: 9:00 AM - 9:00 PM',
      latitude: 3.0738,
      longitude: 101.6065,
    );

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'VISIT OUR STORE',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 200,
            child: MapWidget(location: storeLocation),
          ),
          const SizedBox(height: 20),
          _buildStoreInfo(storeLocation            ),
        ],
      ),
    );
  }
 
  Widget _buildStoreInfo(StoreLocation location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.store,  size: 24),
            const SizedBox(width: 10),
            Text(
              location.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                location.address,
                style: const TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.grey[600], size: 20),
            const SizedBox(width: 8),
            Text(
              location.hours,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
