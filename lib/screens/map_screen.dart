import 'package:flutter/material.dart';
import 'package:gmaps_practice/model/direction_repository.dart';
import 'package:gmaps_practice/model/directions_model.dart';
import 'package:gmaps_practice/widgets/appBar_button.dart';
import 'package:gmaps_practice/widgets/message.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Marker? _origin;
  Marker? _destination;
  // Directions? _info;

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  GoogleMapController? _googleMapController;
  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  void _addMarker(LatLng position) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
          position: position,
        );
        _destination = null;
        // _info = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: position,
        );
      });

      // final directions = await DirectionsRepository().getDirections(
      //     origin: _origin!.position, destination: _destination!.position);
      // setState(() => _info = directions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Maps Practice'),
        actions: [
          if (_origin != null)
            AppBarButton(
              _googleMapController,
              _origin,
              'Origin',
              Colors.yellow,
            ),
          if (_destination != null)
            AppBarButton(
              _googleMapController,
              _destination,
              'Destination',
              Colors.white,
            ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) (_origin) as Marker,
              if (_destination != null) (_destination) as Marker,
            },
            // polylines: {
            //   if (_info != null)
            //     Polyline(
            //       polylineId: const PolylineId('overview_polyline'),
            //       color: Colors.red,
            //       width: 5,
            //       points: _info!.polylinePoints
            //           .map((e) => LatLng(e.latitude, e.longitude))
            //           .toList(),
            //     ),
            // },
            onLongPress: _addMarker,
          ),
          //MessagingWidget(),
          // if (_info != null)
          //   Positioned(
          //     top: 20.0,
          //     child: Container(
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 6.0,
          //         horizontal: 12.0,
          //       ),
          //       decoration: BoxDecoration(
          //         color: Colors.yellowAccent,
          //         borderRadius: BorderRadius.circular(20.0),
          //         boxShadow: const [
          //           BoxShadow(
          //             color: Colors.black26,
          //             offset: Offset(0, 2),
          //             blurRadius: 6.0,
          //           )
          //         ],
          //       ),
          //       child: Text(
          //         '${_info!.totalDistance}, ${_info!.totalDuration}',
          //         style: const TextStyle(
          //           fontSize: 18.0,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _googleMapController!.animateCamera(//_info != null
            //? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
            CameraUpdate.newCameraPosition(_initialCameraPosition)),
        child: Icon(Icons.center_focus_strong),
      ),
    );
  }
}
