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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
