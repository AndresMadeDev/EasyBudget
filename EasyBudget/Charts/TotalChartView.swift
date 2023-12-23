//
//  ChartView.swift
//  EasyBudget
//
//  Created by Andres Made on 8/5/23.
//

import SwiftUI
import SwiftData
import Charts

struct TotalChartView: View {
    @Query(sort: \TransactionModel.transactionDate, order: .reverse) var transactions: [TransactionModel]
    
    @Query(sort: \DepositModel.deposteDate, order: .reverse) var deposite: [DepositModel]
    
    var chunckTransaction: [[TransactionModel]] {
        let chunckTransaction = transactions.chunked {
            Calendar.current.isDate($0.transactionDate, equalTo: $1.transactionDate, toGranularity: .year)
        }
        return chunckTransaction.map {Array($0)}
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("Transactions")
                    Chart(chunckTransaction, id: \.self) { trans in
                        ForEach(trans) { item in
                            SectorMark(angle: .value("Amount", item.amount))
                                .foregroundStyle(by: .value("Transactions From", item.transactionType))
                        }
                    }.frame(height: 250)
                }
                
                Spacer()
                
                VStack {
                    Text("Deposte")
                    Chart {
                        ForEach(deposite) { item in
                            SectorMark(angle: .value("Amount", item.amount))
                                .foregroundStyle(by: .value("Deposute From", item.title))
                        }
                    }.frame(height: 250)
                }
                
            }
            .padding(.horizontal)
            .navigationTitle("Stats")
        }
    }
}

//#Preview {
//    WeeklyChartView()
//}
