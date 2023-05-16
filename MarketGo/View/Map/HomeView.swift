//
//  HomeView.swift
//  MarketGo
//
//  Created by ram on 2023/05/15.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserModel
    @EnvironmentObject var marketModel: MarketModel
    var body: some View {
        VStack{
            Text("\(userViewModel.currentUser?.memberName ?? "")")
            Text(String(userViewModel.currentUser!.memberID!))
            Text("\(userViewModel.currentUser?.memberToken ?? "")")
        }
       
        
    }

}

