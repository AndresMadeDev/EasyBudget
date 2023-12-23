//
//  YearlyChartView.swift
//  EasyBudget
//
//  Created by Andres Made on 9/4/23.
//

import SwiftUI
import SwiftData
import Charts

struct MonthlyChartView: View {
    @Query(sort: \TransactionModel.transactionDate, order: .forward) var transactions: [TransactionModel]
    
    @Query(sort: \DepositModel.deposteDate, order: .reverse) var deposite: [DepositModel]
    
    var chunckTransaction: [[TransactionModel]] {
        let chunckTransaction = transactions.chunked {
            Calendar.current.isDate($0.transactionDate, equalTo: $1.transactionDate, toGranularity: .year)
        }
        return chunckTransaction.map {Array($0)}
    }
    var chunckDeposite: [[DepositModel]] {
        let chunckDeposit = deposite.chunked {
            Calendar.current.isDate($0.deposteDate, equalTo: $1.deposteDate, toGranularity: .era)
        }
        return chunckDeposit.map {Array($0)}
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Text("Monthly Transactions ")
                        Spacer()
                    }
                    Chart(chunckTransaction, id: \.self) { trans in
                        ForEach(trans) { item in
                            BarMark(x: .value("Moth", item.transactionDate.formatted(.dateTime.year().month())),
                                    y: .value("Amount", item.amount))
                        }
                    }
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .listRowSeparator(.hidden)
                .padding(.horizontal)
                
                
                VStack {
                    HStack {
                        Text("Monthly Deposit")
                        Spacer()
                    }
                    Chart(chunckDeposite, id: \.self) { trans in
                        ForEach(trans) { item in
                            BarMark(x: .value("Moth", item.deposteDate.formatted(.dateTime.year().month())),
                                    y: .value("Amount", item.amount))
                        }
                    }
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .listRowSeparator(.hidden)
                .padding(.horizontal)

            }
           
        }
        
    }
}

#Preview {
    MonthlyChartView()
}
