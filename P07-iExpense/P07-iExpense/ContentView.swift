//
//  ContentView.swift
//  P07-iExpense
//
//  Created by Arjun B on 04/10/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    VStack(alignment: .leading) {
                        Text(item.type)
                            .font(.headline)
                            .foregroundColor(item.type == "Personal" ? .blue : .orange)
                        
                        HStack {
                            Text(item.name)
                                .font(.title3)
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .font(.title3.bold())
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .listStyle(.inset)
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingAddExpense = true
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.blue.opacity(0.8))
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "plus")
                                .font(.title3.bold())
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
