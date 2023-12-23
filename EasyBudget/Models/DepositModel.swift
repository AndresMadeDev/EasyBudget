//
//  DepositModel.swift
//  EasyBudget
//
//  Created by Andres Made on 8/1/23.
//

import Foundation

class DepositModel {
    var amount: Double
    var deposteDate: Date
    var title: String
    
    init(amount: Double, deposteDate: Date = .now, title: String) {
        self.amount = amount
        self.deposteDate = deposteDate
        self.title = title
    }
}
