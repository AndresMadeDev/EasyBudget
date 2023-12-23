//
//  BalanceView.swift
//  EasyBudget
//
//  Created by Andres Made on 7/31/23.
//

import SwiftUI
import SwiftData

struct BalanceView: View {
    @Query private var deposite: [DepositModel]
    @Query private var transactions: [TransactionModel]
    
    var totalDeposite: Double {
        return deposite.reduce(0, {$0 + $1.amount})
    }
    
    var totalTransaction: Double {
        return transactions.reduce(0, {$0 + $1.amount})
    }
    
    var remainingBalance: Double {
        return totalDeposite - totalTransaction
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(remainingBalance.asCurrencyWith2Decimals())
                .font(.system(size: 60))
                .fontWeight(.black)
                .foregroundStyle(remainingBalance < 0.0 ? .red : .mainTint)
            Text("Remaining Balance")
                .font(.headline)
                
           
        }
        .padding()
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.3), radius: 10, x: 3, y: 3)
        .padding(.horizontal)
        
        
    }
}

#Preview {
    BalanceView()
}
