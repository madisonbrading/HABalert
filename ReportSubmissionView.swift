//
//  ReportSubmissionView.swift
//  HABalert
//
//  Created by Madison Brading on 10/31/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct ReportSubmissionView: View {
    @State private var description = ""
    @State private var color = Color.blue
    @State private var location = ""
    @State private var isSample = false
    @State private var selectedImage: Image?
    @State private var isImagePickerPresented = false
    @State private var imageData: Data?
    
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )


    var body: some View {
    //    MapView(location: $location)
        NavigationView {
            Form {
                Section(header: Text("Report Details")) {
                    TextField("Description", text: $description)
                    TextField("Location", text: $location)
                        .onChange(of: location, perform: { value in
                            // Geocode the user-entered location and set the map region
                            let geocoder = CLGeocoder()
                            geocoder.geocodeAddressString(value) { placemarks, error in
                                if let placemark = placemarks?.first {
                                    region.center = placemark.location!.coordinate
                                }
                            }
                        })

                    ColorPicker("Select a Color", selection: $color)
                                .padding()
                    Toggle("Did you collect a sample?", isOn: $isSample)
                }

                Section(header: Text("Add Photo")) {
                    if selectedImage != nil {
                        selectedImage?
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }

                    Button("Select Photo") {
                        isImagePickerPresented = true
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(image: $selectedImage, imageData: $imageData)
                    }
                }

                Section {
                    Button("Submit Report") {
                        _ = Report(location: location, date: Date(), description: description, photos: [], sample: isSample, color: color)

                        submitReport()
                        
                    }
                }
            }
            .navigationTitle("Submit Report")
        }
    }

    func submitReport() {
        if let imageData = imageData {
            let customID = UUID()
            let newReport = Report(id: customID, location: location, date: Date(), description: description, photos: [imageData], sample: isSample, color: color)
            HarmfulAlgalBloomReportManager.shared.submitReport(newReport)
        }
    }
}
