//
//  ProfileImageView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//

import SwiftUI

struct ProfileImageView: View {
    //@State var profileImageName: String
    //var profileImage: UIImage?
    var profileImage = UIImage(named: "piri.png")
    var body: some View {
        if let image = profileImage {
            Image(uiImage: image)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .font(.title)
        } else {
            Image(systemName: "person.circle.fill")
                .font(.title)
        }
    }
    
    
    
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView()
    }
}
