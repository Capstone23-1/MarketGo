//
//  HomeView.swift
//  MarketGo
//
//  Created by ram on 2023/05/15.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text((currentUser?.memberName)!)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
