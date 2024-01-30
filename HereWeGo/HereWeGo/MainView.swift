//
//  ContentView.swift
//  HereWeGo
//
//  Created by Ian Hoyos on 1/30/24.
//

import SwiftUI
import CoreData

struct MainView: View {
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    
                }
                
                HStack {
                    Spacer()
                    
                    Text("HereWeGo")
                        .font(.custom("Helvetica Neue", size: 22))
                        .fontWeight(.semibold)
                    Spacer()
                }
            }
            Text("Hello There")
        }
    }
}

struct MainViewPreview: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
