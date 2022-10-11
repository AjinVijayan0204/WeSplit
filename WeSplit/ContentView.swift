//
//  ContentView.swift
//  WeSplit
//
//  Created by Ajin on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var totalAmount = 0.0
    @State var noOfPeople = 1
    @State var tipPercentage = 20
    
    @FocusState var amountIsFocused: Bool
    
    var totalPerPerson: Double{
        let noOfPeople = Double(noOfPeople)
        let tipSelected = Double(tipPercentage)
        let amt = Double(totalAmount)
        
        var finalAmt = (amt*(1+tipSelected*0.01))/noOfPeople
        
        return finalAmt
    }
    
    
    let tipPercentages = [0,5,10,20,25]
    
    var body: some View {
        
        NavigationView{
            
            Form{
                Section{
                    TextField("Amount", value: $totalAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $noOfPeople) {
                        ForEach(0..<100) {
                            Text("\($0)")
                        }
                    }
                    
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { data in
                            Text("\(data)")
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Choose the tip percentage")
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            }.navigationTitle("WeSplit")
                .toolbar {
                    
                    //button comes along with keyboard based on placement
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                    
                }
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
