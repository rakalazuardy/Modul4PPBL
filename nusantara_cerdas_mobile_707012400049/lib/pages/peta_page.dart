import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PetaPage extends StatefulWidget {
  const PetaPage({super.key});

  @override
  State<PetaPage> createState() => _PetaPageState();
}

class _PetaPageState extends State<PetaPage> {
  static const LatLng _pusat = LatLng(
    -6.200000,
    106.816666,
  );

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('kantor_pusat'),
      position: LatLng(-6.200000, 106.816666),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Pusat',
      ),
    ),
    const Marker(
      markerId: MarkerId('kantor_utara'),
      position: LatLng(-6.155000, 106.865000),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Wilayah Utara',
      ),
    ),
    const Marker(
      markerId: MarkerId('kantor_selatan'),
      position: LatLng(-6.261000, 106.810000),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Wilayah Selatan',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Kantor'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              18,
              4,
              18,
              14,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Temukan kantor pelayanan terdekat.',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),

          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _pusat,
                zoom: 11.5,
              ),
              markers: _markers,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Lokasi pada peta merupakan contoh titik kantor layanan di Jakarta.',
              style: TextStyle(
                fontSize: 11,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}