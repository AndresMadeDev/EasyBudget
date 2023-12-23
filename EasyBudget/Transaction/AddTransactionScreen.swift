//
//  AddTransactionView.swift
//  EasyBudget
//
//  Created by Andres Made on 8/1/23.
//

import SwiftUI

struct AddTransactionScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State var amount: String = ""
    @State var transactionDate: Date = .now
    @State var title: String = ""
    @State var selectedType: TransactionType = .food
    
    var transactionType = ["Food", "Gas", "Utilities", "Mortgage/Rent", "Entertainment", "Subscription"]
    
    private var isFormValid: Bool {
        title.isEmpty || amount.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                TextField("Transactions From...", text: $title)
                    .textInputAutocapitalization(.words)
                    .padding()
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                TextField("Transactions Amount...", text: $amount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                HStack {
                    Text("Transaction Type").font(.headline)
                    Spacer()
                    Picker("Transaction Type", selection: $selectedType) {
                        ForEach(TransactionType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.menu)
                }
                DatePicker("Transactions Date", selection: $transactionDate, displayedComponents: .date)
                //                .datePickerStyle(.)
                Spacer()
                
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newTransaction = TransactionModel(amount: Double(amount) ?? 0.0,
                                                              transactionDate: transactionDate,
                                                              title: title,
                                                              transactionType: selectedType.rawValue)
                        modelContext.insert(newTransaction)
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
            .tint(.mainTint)
            .padding(.horizontal)
            .navigationTitle("Transactions")
            .background(Color(.systemGray6))
        }
    }
}

//#Preview {
//    AddTransactionView()
//}
