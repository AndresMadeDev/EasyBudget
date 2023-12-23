//
//  TransactionListView.swift
//  EasyBudget
//
//  Created by Andres Made on 7/31/23.
//

import SwiftUI
import SwiftData
import Algorithms

struct TransactionListScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TransactionModel.transactionDate, order: .reverse) var transactions: [TransactionModel]
    
    var chunckTransaction: [[TransactionModel]] {
        let chunckTransaction = transactions.chunked {
            Calendar.current.isDate($0.transactionDate, equalTo: $1.transactionDate, toGranularity: .month)
            
        }
        return chunckTransaction.map {Array($0)}
    }

    
    
    var body: some View {
        VStack {
                Text("Transactions")
                    .font(.title)
                    .bold()
                .foregroundStyle(.mainTint)
          
//            List(chunckTransaction, id: \.self) { items in
//                Section(items.first!.transactionDate.formatted(.dateTime.month(.wide))) {
//                    ForEach(items) { trans in
//                        TransactionCell(transaction: trans)
//                            .swipeActions(content: {
//                                Button("Delete", role: .destructive) {
//                                    modelContext.delete(trans)
//                                }.tint(.red)
//                            })
//                            
//                    }
//                }
//            }.listRowSeparator(.visible)
//                .listRowBackground(Color.clear)
//                .ignoresSafeArea()
            
            if !transactions.isEmpty {
                List(transactions) { transaction in
                            TransactionCell(transaction: transaction)
                                .swipeActions(content: {
                                    Button("Delete", role: .destructive) {
                                        modelContext.delete(transaction)
                                    }.tint(.red)
                                })
                                .listRowSeparator(.visible)
                                .listRowBackground(Color.clear)
                        }
                 
                .listStyle(.plain)
                .listRowSeparator(.visible)
                .listRowBackground(Color.clear)
            } else {
                ContentUnavailableView(
                    "You have no Transactions",
                    systemImage: "dollarsign",
                    description: Text("Tap on '+Transaction' to create a new transaction.")
                ).symbolEffect(.pulse)
            }
           
        }.ignoresSafeArea()
        
    }
}



struct TransactionCell: View {
    @Bindable var transaction: TransactionModel
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(transaction.title)
                    .font(.headline)
                Text(transaction.transactionType)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
            }
            Spacer()
            VStack {
                Text(transaction.amount.asCurrencyWith2Decimals())
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.mainTint)
                Text(transaction.transactionDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .listRowSeparator(.visible)
        .listRowBackground(Color.clear)
    }
}
