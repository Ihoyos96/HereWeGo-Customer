//
//  MapView.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 2/7/24.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var coreLocationManager = CoreLocationManager.shared
    @State private var position: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    init() {
        position = .region(MKCoordinateRegion(center: coreLocationManager.userPosition ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)) )
    }
    
    var body: some View {
        Map(position: $position){
            UserAnnotation()
        }
        .mapStyle(.standard)
        .mapControls{
            MapUserLocationButton()
                .offset(y: screenHeight)
        }
        
        .onAppear {
            locateUser()
        }
    }
    
    private func locateUser() {
        // Implement location finding logic here, updating `region` with the user's current location
        // Typically, you would use CLLocationManager to find the user's location and then update the `region`
    }
}

extension CLLocationCoordinate2D {
//    var userPosition = CLLocation
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

