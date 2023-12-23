//
//  HomeView.swift
//  EasyBudget
//
//  Created by Andres Made on 7/31/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .mainTint
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.mainTint], for: .normal)
    }
    
    @State private var selectedView: SelectedView = .transactions
    @State private var showAddDeposite: Bool = false
    @State private var showAddTransaction: Bool = false
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView().padding(.top)
               
                    Picker("", selection: $selectedView) {
                        ForEach(SelectedView.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .font(.largeTitle)
                    .padding(.top, 50)
                    .padding(.bottom, 20)
                    .padding(.horizontal)
                    
                    ChosenView(selectedView: selectedView)
                    
                    Spacer()
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        if selectedView == .deposite {
                        Button("+Deposite") {
                            showAddDeposite.toggle()
                        }
                        .buttonStyle(.bordered)
                        .tint(.mainTint)
                    }
                }
               
            })
            .fullScreenCover(isPresented: $showAddDeposite, content: {
                NavigationStack {
                    AddDepositeView()
                }
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    if selectedView == .transactions {
                        Button("+Transactions") {
                            showAddTransaction.toggle()
                        }
                        .buttonStyle(.bordered)
                        .tint(.mainTint)
                    }
                }
            })
            .fullScreenCover(isPresented: $showAddTransaction, content: {
                NavigationStack {
                    AddTransactionView()
                }
            })
        }
    }
}

#Preview {
    HomeView()
}

enum SelectedView: String, CaseIterable {
    case transactions = "Transaction"
    case deposite = "Deposite"
}

struct ChosenView: View {
    var selectedView: SelectedView
    
    var body: some View {
        switch selectedView {
        case .transactions:
            TransactionListView()
        case .deposite:
            DepositeListView()
        }
    }
}
