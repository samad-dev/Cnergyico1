// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//
//
//   Completer<GoogleMapController> _controllerGoogleMap = Completer();
//   late GoogleMapController newGoogleMapMapController;
//
//   GlobalKey<ScaffoldState> scaffoldstate = new GlobalKey<ScaffoldState>();
//
//   late Position currentposition;
//   var geolocator = Geolocator();
//
//   void locatePosition() async{
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     currentposition = position;
//
//     LatLng latLatPosition = LatLng(position.latitude, position.longitude);
//
//     CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 14);
//
//     newGoogleMapMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//   }
//
//
//   static final CameraPosition _KGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Location'),
//       ),
//
//       body: Stack(
//         children: [
//
//           GoogleMap(
//             mapType: MapType.normal,
//             myLocationButtonEnabled: true,
//             initialCameraPosition: _KGooglePlex,
//             myLocationEnabled: true,
//             zoomGesturesEnabled: true,
//             zoomControlsEnabled: true,
//             onMapCreated: (GoogleMapController controller)
//             {
//               _controllerGoogleMap.complete(controller);
//               newGoogleMapMapController = controller;
//               locatePosition();
//             },
//           ),
//
//
//
//
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:cnergyico/utils/constants.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen3 extends StatefulWidget {
  const MapScreen3({Key? key}) : super(key: key);

  @override
  _MapScreen3State createState() => _MapScreen3State();
}

class _MapScreen3State extends State<MapScreen3> {

  late GoogleMapController mapController;
  double _originLatitude = 24.861027, _originLongitude = 67.069544;
  double _destLatitude = 24.817101, _destLongitude = 67.107758;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBVd1NNxbwhotrraavfQdbE7-PT_CDLJb8";

  @override
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: Text("Vehicle Location"),
          backgroundColor: Constants.primaryColor,
        ),
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(_originLatitude, _originLongitude), zoom: 15),
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            // markers: Set<Marker>.of(markers.values),
            markers: Set<Marker>.of(
                [

                  Marker(
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                    markerId: MarkerId('marker_1'),
                    position: LatLng(24.861027, 67.069544),
                    consumeTapEvents: true,
                    infoWindow: InfoWindow(
                      title: 'Starting Point',
                      snippet: "Hi I'm a Platform Marker",
                    ),
                    onTap: () {
                      print("Starting Point");
                    },
                  ),


                  Marker(
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                    markerId: MarkerId('marker_2'),
                    position: LatLng(24.817101, 67.107758),
                    consumeTapEvents: true,
                    infoWindow: InfoWindow(
                      title: 'Destination point',
                      snippet: "Hi I'm a Platform Marker",
                    ),
                    onTap: () {
                      print("Destination Point");
                    },
                  ),
                ]
            ),
            polylines: Set<Polyline>.of(polylines.values),
          )),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    var mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}


