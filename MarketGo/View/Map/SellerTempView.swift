//
//  SellerTempView.swift
//  MarketGo
//
//  Created by ram on 2023/05/20.
//

import SwiftUI

struct SellerTempView: View {
    @EnvironmentObject var userViewModel: UserModel
    @EnvironmentObject var marketModel: MarketModel
    var body: some View {
        VStack{
            Text("\(userViewModel.currentUser?.memberName ?? "")")
            Text("\(String(describing:userViewModel.currentUser?.memberID))")
            Text("\(userViewModel.currentUser?.memberToken ?? "")")
        }
       
        
    }
}


