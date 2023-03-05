//
//  MapDirectionView.swift
//  OttActivity
//
//  Created by Emrah on 2022-12-30.
//

import MapKit
import SwiftUI
import UIKit

struct MapDirectionView: UIViewRepresentable{

  typealias UIViewType = MKMapView

    let destinationLocation:Location
    @Binding var ETA:String
    private let locationManager:LocationManager = LocationManager()
    private let defaultOttawaLocation = CLLocation(latitude: 45.42001, longitude: -75.68954)

  func makeCoordinator() -> MapViewCoordinator {
    return MapViewCoordinator()
  }

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator

    let region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: destinationLocation.lat, longitude: destinationLocation.lng),
      span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    mapView.setRegion(region, animated: true)
      
      let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: locationManager.lastKnownLocation?.coordinate.latitude ?? defaultOttawaLocation.coordinate.latitude, longitude: locationManager.lastKnownLocation?.coordinate.longitude ?? defaultOttawaLocation.coordinate.longitude))
      let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destinationLocation.lat, longitude: destinationLocation.lng))

      
      let sourcePin = MKPointAnnotation()
      sourcePin.coordinate = CLLocationCoordinate2D(latitude: locationManager.lastKnownLocation?.coordinate.latitude ?? defaultOttawaLocation.coordinate.latitude, longitude: locationManager.lastKnownLocation?.coordinate.longitude ?? defaultOttawaLocation.coordinate.longitude)
      sourcePin.title = "My Location"
      
      let destinationPin = MKPointAnnotation()
      destinationPin.coordinate = CLLocationCoordinate2D(latitude: destinationLocation.lat, longitude: destinationLocation.lng)
      destinationPin.title = destinationLocation.title
      
    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: sourcePlaceMark)
    request.destination = MKMapItem(placemark: destinationPlacemark)
    request.transportType = .any

    let directions = MKDirections(request: request)
    directions.calculate { response, error in
      guard let route = response?.routes.first else { return }
      mapView.addAnnotations([sourcePin, destinationPin])
      mapView.addOverlay(route.polyline)
      mapView.setVisibleMapRect(
        route.polyline.boundingMapRect,
        edgePadding: UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35),
        animated: true)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.minute, .hour, .day]
        ETA = formatter.string(from: Date(), to: Date(timeInterval: route.expectedTravelTime, since: Date())) ?? ""
    }
    mapView.isUserInteractionEnabled = false
    return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {
  }

  class MapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let renderer = MKPolylineRenderer(overlay: overlay)
      renderer.strokeColor = .systemBlue
      renderer.lineWidth = 3
      return renderer
    }
  }
}
