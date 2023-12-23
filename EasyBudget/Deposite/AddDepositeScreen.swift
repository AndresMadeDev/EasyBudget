//
//  AddDepositeView.swift
//  EasyBudget
//
//  Created by Andres Made on 7/31/23.
//

import SwiftUI
import SwiftData

struct AddDepositeScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var depositeDate: Date = .now
    
    private var isFormValid: Bool {
        title.isEmpty || amount.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                TextField("Deposite From...", text: $title)
                    .textInputAutocapitalization(.words)
                    .padding()
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                TextField("Deposite Amount...", text: $amount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                DatePicker("Deposite Date", selection: $depositeDate, displayedComponents: .date)
                //                .datePickerStyle(.)
                Spacer()
                
            }
            .tint(.mainTint)
            .padding(.horizontal)
            .navigationTitle("Deposite")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGray6))
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newDeposite = DepositModel(
                            amount: Double(amount) ?? 0.0,
                            deposteDate: depositeDate,
                            title: title)
                        modelContext.insert(newDeposite)
                        title = ""
                        amount = ""
                        dismiss()
                    }
                    .disabled(isFormValid)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            })
        }
    }
}

#Preview {
    NavigationStack {
        AddDepositeScreen()
    }
}
