
import SwiftUI

struct TobView: View {
    @EnvironmentObject var marketModel: MarketModel
    var body: some View {
        HStack {
//            MarketChoicePickerView()
            Text((marketModel.currentMarket?.marketName) ?? "N/A")
                .font(.headline)
//            Text( "\(marketModel.currentMarket?.marketID ?? 0)" )
//                .font(.headline)
            Spacer()
            
            NavigationLink{
                CartView()
            } label: {
                Image(systemName: "cart")
                    .padding(.horizontal)
                    .imageScale(.large)
            }

                
        }
        .padding()
        
        

    }
}
