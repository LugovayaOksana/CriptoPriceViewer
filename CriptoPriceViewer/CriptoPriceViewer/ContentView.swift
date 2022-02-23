//
//  ContentView.swift
//  CriptoPriceViewer
//
//  Created by Oksana on 23.02.2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject private var viewModel = CoinListViewModel()
    
    var body: some View {
        
        NavigationView {
            List(viewModel.coinViewModels, id: \.self) { coinViewModel in
                Text(coinViewModel.displayText)
            }.onAppear {
                self.viewModel.fetchCoins()
            }
            .navigationBarTitle("Coins")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
