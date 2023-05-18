//
//  StoreInfoWrite.swift
//  MarketGo
//
//  Created by ram on 2023/05/18.
//

import SwiftUI

struct StoreInfoWrite: View {
    @State private var selectedCategoryId = 0
    
    var categories = [
        (id: 0, name: "분류"),
        (id: 1, name: "농산물"),
        (id: 2, name: "수산물"),
        (id: 3, name: "축산물"),
        (id: 4, name: "반찬"),
        (id: 5, name: "가공식품"),
        (id: 6, name: "건강식품"),
        (id: 7, name: "생활용품"),
        (id: 8, name: "기타"),
    ]
    @State var category = ""
    @State var id = ""
    var body: some View {
        Form{
            ImageUploadView(category: $category, id: $id)
            
            
            
            Picker(selection: $selectedCategoryId, label: Text("카테고리")) {
                ForEach(categories, id: \.id) { category in
                    Text(category.name).tag(category.id)
                }
            }
        }
    }
}


