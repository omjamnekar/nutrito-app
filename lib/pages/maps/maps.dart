import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nutrito/util/theme/color.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({
    super.key,
  });

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.3350034, -122.03272188);
  static const LatLng destination = LatLng(37.3342983, -122.06600055);

  List<LatLng> polyineCoordinates = [];

  Future<void> getPolyPoint() async {
    await dotenv.load();
    PolylinePoints polylinePoints = PolylinePoints();
    final String? googleApiKey = dotenv.env['MAP_API'];

    if (googleApiKey == null || googleApiKey.isEmpty) {
      print("API Key is missing");
      return;
    }

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving,
      ),
      googleApiKey: googleApiKey,
    );

    if (result.points.isNotEmpty) {
      polyineCoordinates = result.points
          .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
          .toList();

      setState(() {});
    }
  }

  @override
  void initState() {
    getPolyPoint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Order"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: sourceLocation,
          zoom: 13.5,
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId(
              "route",
            ),
            color: ColorManager.bluePrimary,
            points: polyineCoordinates,
            width: 3,
          ),
        },
        markers: {
          Marker(
            markerId: MarkerId("source"),
            position: sourceLocation,
          ),
          Marker(
            markerId: MarkerId("destination"),
            position: destination,
          ),
        },
      ),
    );
  }
}
