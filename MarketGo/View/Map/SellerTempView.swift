//
//  SellerTempView.swift
//  MarketGo
//
//  Created by ram on 2023/05/20.
//

import SwiftUI

struct SellerTempView: View {
    @EnvironmentObject var userViewModel: UserModel
    var body: some View {
        VStack{
            Text((userViewModel.currentUser?.memberName)!)
            Text(String((userViewModel.currentUser?.memberID)!))
            Text(String((userViewModel.currentUser?.storeID)!))
        }
    }
}


