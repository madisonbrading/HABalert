//
//  ContentView.swift
//  HABalert
//
//  Created by Madison Brading on 10/17/23.
//

import SwiftUI
import MapKit

class User: ObservableObject{
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggings"
}

struct Location: Identifiable{
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    @StateObject private var user = User()
    @State private var tapCount = 0

    //@StateObject var expense = Expenses()
    
    @State private var name = ""
    @State private var reports: [Report] = []
    @State private var location: String = "Sample Location"

    @State private var selectedTab = "Map"
    
    var body: some View {
        
//        NavigationStack{
//            Form {
//                TextField("Enter name", text: $user.firstName)
//                TextField("Enter name", text: $user.lastName)
//
//                Text("Your name is \(user.firstName) \(user.lastName)")
//                Section{
//                    Text("Hello, world!")
//                }
//            }
//        .navigationTitle("home")
//        }
      
        TabView(selection: $selectedTab){
           
            ReportSubmissionView()
                .tabItem {
                    Label("Report", systemImage: "star")
                }
            MapView(reports: $reports)
                .tabItem{
                    Label("Map", systemImage: "circle")
                }
                .tag("Map")
            Text("News")
                .tabItem{
                    Label("News", systemImage: "square")
                }
                .tag("News")
        }
        .navigationTitle("Your App Title")
        .padding()
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
