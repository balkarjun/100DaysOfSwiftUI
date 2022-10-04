//
//  Expenses.swift
//  P07-iExpense
//
//  Created by Arjun B on 04/10/22.
//

import Foundation

class Expense: ObservableObject {
    @Published var items = [ExpenseItem]()
}
