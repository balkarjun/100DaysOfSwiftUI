//
//  ExpenseItem.swift
//  P07-iExpense
//
//  Created by Arjun B on 04/10/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
