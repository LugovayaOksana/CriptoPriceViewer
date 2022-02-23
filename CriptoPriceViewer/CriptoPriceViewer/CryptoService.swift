//
//  CryptoService.swift
//  CriptoPriceViewer
//
//  Created by Oksana on 23.02.2022.
//

import Foundation
import Combine

//https://api.coinranking.com/v2/coins

final class CryptoService {
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coinranking.com"
        components.path = "/v2/coins"
        components.queryItems = [URLQueryItem(name: "base", value: "USD"), URLQueryItem(name: "timePeriod", value: "24h")]
        return components
    }
    
    func fetchCoins() -> AnyPublisher<CryptoDataContainer, Error> {
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .decode(type: CryptoDataContainer.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct CryptoDataContainer: Decodable {
    let status: String
    let data: CryptoData
}

struct CryptoData: Decodable {
    let coins: [Coin]
}
