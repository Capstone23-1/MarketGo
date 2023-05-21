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
    @State var move = false
    var body: some View {
        VStack{
            Button {
                move=true
            } label: {
                Text("정보수정창")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .sheet(isPresented: $move) {
                SellerEditInfoView()
            }

        }
       
        
    }
}


