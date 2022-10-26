//
//  CheckoutView.swift
//  P10-CupcakeCorner
//
//  Created by Arjun B on 26/10/22.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .padding(.horizontal)
                
                VStack {
                    Text("your total is")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(order.cost, format: .currency(code: "USD"))
                        .font(.title.bold())
                }
                
                Button {
                    
                } label: {
                    Text("Place Order")
                        .font(.body.bold())
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CheckoutView(order: Order())
        }
    }
}
