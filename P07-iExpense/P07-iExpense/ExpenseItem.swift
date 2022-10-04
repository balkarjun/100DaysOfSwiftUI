//
//  ExpenseItem.swift
//  P07-iExpense
//
//  Created by Arjun B on 04/10/22.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
