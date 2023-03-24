//
//  TobView.swift
//  SeeJang
//
//  Created by ram on 2023/03/25.
//

import SwiftUI

struct TobView: View {
    var body: some View {
        HStack {
            Text("시장")
                .font(.headline)
            Spacer()
            Image(systemName: "cart")
                .padding(.horizontal)
                .imageScale(.large)
            ProfileImageView()
                
        }
        .padding()
        
        

    }
}

struct TobView_Previews: PreviewProvider {
    static var previews: some View {
        TobView()
    }
}
