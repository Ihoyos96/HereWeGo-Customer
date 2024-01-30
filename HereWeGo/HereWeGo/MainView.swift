//
//  ContentView.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 1/30/24.
//

import SwiftUI
import CoreData

struct MainView: View {
    let networkManager = NetworkManager.shared
    
    @State private var response: createTripResponse?
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
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
            Spacer ()
            
            VStack {
                Text("\(response?.tripId ?? "No Trip Available")")
            }
            
            Button {
                networkManager.createTrip(trip: Trip()) { response in
                    switch response {
                    case .success(let createResponse):
                        DispatchQueue.main.async {
                            self.response = createResponse
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
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
            
            Spacer()
        }
    }
}

struct MainViewPreview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
