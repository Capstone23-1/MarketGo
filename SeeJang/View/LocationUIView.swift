//
//  LocationUIView.swift
//  SeeJang
//
//  Created by ram on 2023/03/22.
//

import SwiftUI

struct LocationUIView: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "mappin.and.ellipse")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    
            }
            
        }
    }
}

struct LocationUIView_Previews: PreviewProvider {
    static var previews: some View {
        LocationUIView()
    }
}
