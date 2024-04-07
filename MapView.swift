//
//  MapView.swift
//  HABalert
//
//  Created by Madison Brading on 3/31/24.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation



struct MapView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Binding var reports: [Report] //assuming I have a list of report objects
    @State private var userTrackingMode: MapUserTrackingMode = .follow

    
    // Define an IdentifiableMapPin struct that conforms to Identifiable
    struct IdentifiableMapPin: Identifiable {
        let id = UUID()
        var coordinate: CLLocationCoordinate2D
        var tint: Color
    }
    
    @State private var annotations: [IdentifiableMapPin] = []
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: annotations) { pin in
                MapPin(coordinate: pin.coordinate, tint: pin.tint)
            }
            .onAppear {
                updateMapAnnotations()
            }
        }
    }
    // Function to update map annotations based on user's input
    func updateMapAnnotations() {
        annotations = reports.map { report in
            let geocoder = CLGeocoder()
            var pinCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            var pinTint: Color = .red
            
            geocoder.geocodeAddressString(report.location) { placemarks, error in
                if let placemark = placemarks?.first, let location = placemark.location {
                    pinCoordinate = location.coordinate
                } else {
                    // Handle error or no results found
                }
            }
            return IdentifiableMapPin(coordinate: pinCoordinate, tint: pinTint)
        }
    }
}

    struct MapView_Previews: PreviewProvider {
        static var previews: some View {
            let sampleReports: [Report] = [] // Provide a list of sample reports
            return MapView(reports: .constant(sampleReports))
        }
    }
