//
//  HomeView.swift
//  MarketGo
//
//  Created by ram on 2023/05/15.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        Text((userViewModel.currentUser?.memberName)!)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
