//import SwiftUI
//struct EatingHouseList: View {
//    var data: [Document]
//    @Binding var selectedEating: Document?
//    
//    @State private var isLoading = false // indicator 추가
//    
//    @State var selectedMarket: MarketOne?
//    @EnvironmentObject var marketModel: MarketModel
//    @EnvironmentObject var userModel: UserModel
//    @ObservedObject var vm: MarketSearchViewModel
//    
//    var sortedData: [Document] {
//        data.sorted { $0.distance < $1.distance }
//    }
//    
//    var body: some View {
//        ScrollViewReader { value in
//            VStack {
//                List {
//                    ForEach(sortedData) { market in
//                        Button(action: {
//                            selectedEating = market
//                            vm.selectedID = market.id
//                            value.scrollTo(market.id, anchor: .top)
//                            print(selectedEating)
//                        }) {
//                            HStack {
//                                Text("\(market.placeName)   \(market.distance)m")
//                                    .foregroundColor(vm.selectedID == market.id ? .blue : .black)
//                                    .id(market.id)
//                            }
//                        }
//                    }
//                }
//                .onChange(of: selectedEating) { newValue in
//                    if let newID = newValue?.id {
//                        value.scrollTo(newID, anchor: .top)
//                    }
//                }
//            }
//        }
//    }
//}
