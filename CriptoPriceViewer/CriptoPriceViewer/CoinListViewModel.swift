//
//  CoinListViewModel.swift
//  CriptoPriceViewer
//
//  Created by Оксана on 23.02.2022.
//

import SwiftUI
import Combine


class CoinListViewModel: ObservableObject {
    private let cryptoService = CryptoService()
    @Published var coinViewModels = [CoinViewModel]()
    
    var cancellable: AnyCancellable?
    
    func fetchCoins() {
        cancellable = cryptoService.fetchCoins().sink(receiveCompletion: { _ in
            //
        }, receiveValue: { cryptoContainer in
            self.coinViewModels = cryptoContainer.data.coins.map { CoinViewModel($0) }
            print(self.coinViewModels)
           
        })
    }
}

struct CoinViewModel: Hashable {
    private let coin: Coin
    
    var name: String {
        return coin.name
    }
    
    var formattedPrice: String {
        // do somo formatting
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        guard let price = Double(coin.price), let formattedPrice = numberFormatter.string(from:
                                                                NSNumber(value: price)) else { return "" }
        return formattedPrice
    }
    
    var displayText: String {
        return name + " - " + formattedPrice
    }
    
    init(_ coin: Coin) {
        self.coin = coin
    }
}
