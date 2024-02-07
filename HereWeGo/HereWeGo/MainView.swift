//
//  ContentView.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 1/30/24.
//
import Foundation
import SwiftUI
import UIKit
import MapKit
import CoreData

struct MainView: View {
    let networkManager = NetworkManager.shared
    @ObservedObject var userDefaults = UserDefaultsManager.shared
    @ObservedObject var locationManager = CoreLocationManager.shared
    @ObservedObject var searchManager = LocationSearchManager()

    @State private var response: createTripResponse?
    @State private var searchText = ""
    @State private var timer: Timer?
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            MapView()
            
            VStack {
                ZStack {
                    HStack {
                        Image(systemName: "hare.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .foregroundColor(Color.indigo)
                            .offset(x: -90)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("HereWeGo")
                            .font(.custom("Helvetica Neue", size: 24))
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                }
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .stroke(Color.white, lineWidth: 2)
                        .fill(Color.white)
                )
                .frame(width: screenWidth/1.5)
                
                
                Spacer ()
                
                VStack {
                    
                }
                
                ZStack {
                    VStack {
                        TextField("Search For Your Destination", text: $searchText, onEditingChanged: { _ in }, onCommit: {
                            searchManager.updateSearchResults(for: searchText)
                        })
                        .font(.custom("Helvetica Neue", size: 16))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .stroke(Color.white, lineWidth: 2)
                                .fill(Color.white)
                        )
                        .frame(width: screenWidth/1.2)
                        .onChange(of: searchText) { oldValue, newValue in
                            timer?.invalidate() // Cancel the existing timer
                            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                                searchManager.updateSearchResults(for: newValue)
                            }
                        }
                        
                        Button {
                            //                        networkManager.createTrip(
                            //                            trip: Trip(userId: userDefaults.userId, pickupLocation: coreLocationManager, dropoffLocation: CLLocationCoordinate2D)
                            //                        ) { response in
                            //                            switch response {
                            //                            case .success(let createResponse):
                            //                                DispatchQueue.main.async {
                            //                                    self.response = createResponse
                            //                                }
                            //                            case .failure(let error):
                            //                                print(error)
                            //                            }
                            //                        }
                        } label: {
                            Text("Test Create Trip")
                                .font(.custom("Helvetica Neue", size: 20))
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                                .padding(.vertical, 15)
                                .frame(width: screenWidth/1.5)
                                .background(
                                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                                        .stroke(Color.indigo, lineWidth: 2)
                                        .fill(Color.blue)
                                )
                        }
                    }
                    .zIndex(2)
                    
                    if !searchManager.searchResults.isEmpty || searchText != "" {
                        ScrollView {
                            ForEach(searchManager.searchResults, id: \.self) { item in
                                HStack{
                                    VStack (alignment: .leading, spacing: 0) {
                                        HStack {
                                            Text(item.name ?? "Unknown")
                                                .font(.custom("Helvetica Neue", size: 16))
                                                .fontWeight(.regular)
                                            
                                            Text("\(String(format: "%.1f", distanceFromLocation(location: item.placemark.location ?? CLLocation()))) miles")
                                                .font(.custom("Helvetica Neue", size: 14))
                                                .fontWeight(.regular)
                                                .foregroundColor(Color.secondary)
                                        }
                                        
                                        Text(item.placemark.title ?? "")
                                            .font(.custom("Helvetica Neue", size: 12))
                                            .fontWeight(.regular)
                                            .foregroundColor(Color.secondary)
                                    }
                                    Spacer()
                                    
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal, 5)
                                Divider()
                            }
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                        .frame(width: screenWidth/1.2, height: screenHeight/5)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .stroke(Color.gray, lineWidth: 1)
                                .fill(Color.white)
                        )
                        .offset(y: 100)
                        .zIndex(3)
                    }
                }
                .padding([.bottom], 150)
            }
        }
        .onAppear() {
            
        }
    }
    
    private func distanceFromLocation(location: CLLocation) -> Double {
        let distance = location.distance(from: CLLocation(latitude: self.locationManager.userPosition?.latitude ?? 0.0, longitude: self.locationManager.userPosition?.longitude ?? 0.0))
        
        return distance / 1609.34
    }
}

struct MainViewPreview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
