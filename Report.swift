//
//  Report.swift
//  HABalert
//
//  Created by Madison Brading on 3/31/24.
//

import Foundation
import SwiftUI

struct Report: Codable, Identifiable {
    var id: UUID
    
    var photos: [Data]
    var color: Color
    var description: String
    var date: Date
    var location: String
    var sample: Bool
    
    init(id: UUID = UUID(), location: String, date: Date, description: String, photos: [Data], sample: Bool, color: Color) {
        self.id = id
        self.photos = photos
        self.color = color
        self.date = date
        self.location = location
        self.description = description
        self.sample = sample
    }
    
    // Implement custom decoding for the Color property
        enum CodingKeys: String, CodingKey {
            case id, photos, color, description, date, location, sample
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            photos = try container.decode([Data].self, forKey: .photos)
            // Decode color as a hex string and create a Color
            let colorHex = try container.decode(String.self, forKey: .color)
            color = Color(hex: colorHex)
            description = try container.decode(String.self, forKey: .description)
            date = try container.decode(Date.self, forKey: .date)
            location = try container.decode(String.self, forKey: .location)
            sample = try container.decode(Bool.self, forKey: .sample)
        }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(photos, forKey: .photos)
            // Encode the Color property as a hex string
            try container.encode(color.toHex(), forKey: .color)
            try container.encode(description, forKey: .description)
            try container.encode(date, forKey: .date)
            try container.encode(location, forKey: .location)
            try container.encode(sample, forKey: .sample)
        }
}

extension Color {
    func toHex() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        if #available(iOS 14.0, *) {
            UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }

        return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
}

// Your Color extension to decode a hex string

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: .whitespacesAndNewlines))
        scanner.scanString("#", into: nil)
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

class YourViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var selectedImageData: Data?

    // Function to open the image picker when a user wants to add a photo to the report
    func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // Or .camera if capturing photos
        present(imagePicker, animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegate method to handle the selected image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImageData = image.pngData() // Convert the UIImage to Data
        }
        picker.dismiss(animated: true, completion: nil)
    }

    // Function to submit the report with the selected image data
    func submitReport() {
        if let imageData = selectedImageData {
            let customID = UUID()
            let newReport = Report(id: customID, location: "Coordinates or Location Name", date: Date(), description: "Detailed description of the observation", photos: [imageData], sample: true, color: Color.red)
            HarmfulAlgalBloomReportManager.shared.submitReport(newReport)
        }
    }
}
    
class HarmfulAlgalBloomReportManager {
    static let shared = HarmfulAlgalBloomReportManager()

    var reports: [Report] = []

    func submitReport(_ report: Report) {
        reports.append(report)
        // Here, you can implement code to send the report data to scientists or a backend server.
        // You may also want to add error handling and network requests.
    }
 
}
