//
//  TransactionModel.swift
//  EasyBudget
//
//  Created by Andres Made on 7/31/23.
//

import Foundation

enum TransactionType {
    case food
    case mortgage
    case gas
    case utility
    case entertainment
    case subscription
    case other
    
}

class TransactionModel {
    var amount: Double
    var transactionDate: Date
    var detail: String
    var transactionType: TransactionType
    
    init(amount: Double, transactionDate: Date, detail: String, transactionType: TransactionType) {
        self.amount = amount
        self.transactionDate = transactionDate
        self.detail = detail
        self.transactionType = transactionType
    }
    
}


