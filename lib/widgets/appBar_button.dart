import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppBarButton extends StatelessWidget {
  final GoogleMapController? googleController;
  final Marker? marker;
  final String name;
  final Color color;

  const AppBarButton(this.googleController, this.marker, this.name, this.color);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => googleController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: marker!.position,
            zoom: 14.5,
            tilt: 50.0,
          ),
        ),
      ),
      style: TextButton.styleFrom(
        primary: color,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
      child: Text(name),
    );
  }
}
