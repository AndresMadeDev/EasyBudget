//
//  DepositeListView.swift
//  EasyBudget
//
//  Created by Andres Made on 8/1/23.
//

import SwiftUI
import SwiftData
import Algorithms

struct DepositeListScreen: View {
    @Query(sort: \DepositModel.deposteDate, order: .reverse) var deposites: [DepositModel]
    @Environment(\.modelContext) private var modelContext
    
    var chunckDeposite: [[DepositModel]] {
        let chunckDeposite = deposites.chunked {
            Calendar.current.isDate($0.deposteDate, equalTo: $1.deposteDate, toGranularity: .month)
        }
        return chunckDeposite.map {Array($0)}
    }
    
    var body: some View {
        NavigationStack {
                Text("Deposite")
                    .font(.title)
                    .bold()
                .foregroundStyle(.mainTint)
 
            if !deposites.isEmpty {
                List(deposites) { deposite in
                    DepositeCell(deposite: deposite)
                        .listRowSeparator(.hidden)
                        .swipeActions{
                            Button("Delete", role: .destructive) {
                                modelContext.delete(deposite)
                            }.tint(.red)
                        }
                }
                .listStyle(.plain)
            } else {
                ContentUnavailableView(
                    "You have no Deposite",
                    systemImage: "dollarsign",
                    description: Text("Tap on '+Deposite' to create a new deposite.")
                )
                .symbolEffect(.pulse)
            }
        }
    }
}

#Preview {
    DepositeListScreen()
}

struct DepositeCell: View {
    @Bindable var deposite: DepositModel
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(deposite.title)
                    .font(.headline)
                Text(deposite.deposteDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(deposite.amount.asCurrencyWith2Decimals())
                .font(.headline)
                .bold()
                .foregroundStyle(.mainTint)
        }
        .listRowSeparator(.visible)
        .listRowBackground(Color.clear)
    }
}
