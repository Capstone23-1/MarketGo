//
//  ContentView.swift
//  SeeJang
//
//  Created by ram on 2023/03/25.
//

import SwiftUI
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white
            VStack {
                HStack {
                    Text("시장")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                    Image(systemName: "cart")
                        .padding()
                    
                    ProfileImageView()
                        
                      
                
                    
                }
                .font(.title)
                Spacer()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
