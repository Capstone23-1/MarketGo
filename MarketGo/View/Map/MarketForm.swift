//
//  MarketForm.swift
//  MarketGo
//
//  Created by ram on 2023/05/18.
//
import SwiftUI

struct MarketForm: View {
    @State private var marketID: Int = 0
    @State private var marketName = ""
    @State private var marketAddress = ""
    @State private var marketInfo = ""
    @State private var parking = false
    @State private var toilet = false
    @State private var marketPhoneNum = ""
    @State private var marketGiftcard = 0
    let giftcardOptions = ["온누리상품권", "제로페이", "지역사랑상품권"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("StoreMarket Information")) {
                    TextField("Market ID", value: $marketID, formatter: NumberFormatter())
                    TextField("Market Name", text: $marketName)
                    TextField("Market Address", text: $marketAddress)
                    TextField("Market Info", text: $marketInfo)
                    Toggle(isOn: $parking) {
                        Text("Parking Available")
                    }
                    Toggle(isOn: $toilet) {
                        Text("Toilet Available")
                    }
                    TextField("Market Phone Number", text: $marketPhoneNum)
                        .keyboardType(.numberPad)
                        .onChange(of: marketPhoneNum) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered.count <= 11 {
                                let splitIndex1 = filtered.index(filtered.startIndex, offsetBy: 3, limitedBy: filtered.endIndex)
                                let splitIndex2 = filtered.index(filtered.startIndex, offsetBy: 7, limitedBy: filtered.endIndex)
                                var result = ""
                                if let splitIndex1 = splitIndex1 {
                                    result = String(filtered[..<splitIndex1])
                                    if let splitIndex2 = splitIndex2 {
                                        result += "-\(filtered[splitIndex1..<splitIndex2])-\(filtered[splitIndex2...])"
                                    } else {
                                        result += filtered[splitIndex1...] == "" ? "" : "-\(filtered[splitIndex1...])"
                                    }
                                }
                                self.marketPhoneNum = result
                            }
                        }
                    Picker("Market Giftcard", selection: $marketGiftcard) {
                        ForEach(0 ..< giftcardOptions.count) {
                            Text(self.giftcardOptions[$0])
                        }
                    }
                    Text("Update Time: \(Date(), formatter: DateFormatter())")
                }
                
                Button(action: saveButtonClicked) {
                    Text("Save")
                }
            }
            .navigationBarTitle("Add StoreMarketID", displayMode: .inline)
        }
    }
    
    func saveButtonClicked() {
       
        print("ㅎㅇ")
        // TODO: Save the StoreMarketID as per your requirement
    }
}
