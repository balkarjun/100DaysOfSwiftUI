//
//  Expenses.swift
//  P07-iExpense
//
//  Created by Arjun B on 04/10/22.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
