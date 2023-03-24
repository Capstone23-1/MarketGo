//
//  ContentView.swift
//  SeeJang
//
//  Created by ram on 2023/03/23.
//

import SwiftUI

class MyClass: Identifiable {
    let id: UUID
    let name: String
    let rate: Float?
    
    init(name: String,rate: Float?=nil) {
        self.id = UUID()
        self.name = name
        self.rate = rate
        print("Name: \(self.name), Rating: \(self.rate)")
        
    }
    
    
}

struct ContentView: View {
    @State var searchText = ""
    @State var myClassArray: [MyClass] = [
        MyClass(name: "Class A"),
        MyClass(name: "Class B"),
        MyClass(name: "Class C",rate: 3.3)
    ]
    
    var filteredMyClassArray: [MyClass] {
        if searchText.isEmpty {
            return myClassArray
        } else {
            return myClassArray.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal)
            
            List(filteredMyClassArray,id :\.name) { myClass in
                
                Text(myClass.name)
//                if let floatValue = myClass.rate{
//                    if(0.0...5.0).contains(floatValue){
//                        Text(floatValue)
//                    }
//                    else{
//                        Text("error")
//                    }
//                    
//                } else {
//                    Text("평가없음")
//                }
                
                    
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
