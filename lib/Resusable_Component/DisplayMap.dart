import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DisplayMap extends StatefulWidget {
  final latitude, longitude;
  const DisplayMap({Key key, this.latitude, this.longitude}) : super(key: key);

  @override
  _DisplayMapState createState() => _DisplayMapState();
}

class _DisplayMapState extends State<DisplayMap> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    _markers.add(Marker(
        markerId: MarkerId('marker'),
        position: LatLng(widget.latitude, widget.latitude),
        infoWindow: InfoWindow(title: 'marker')));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.latitude, widget.longitude),
            zoom: 12,
          ),
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete();
          },
        ),
      ),
    );
  }
}
