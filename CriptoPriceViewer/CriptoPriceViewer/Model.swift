//
//  Model.swift
//  CriptoPriceViewer
//
//  Created by Oksana on 23.02.2022.
//

import SwiftUI

struct Coin: Decodable, Hashable {
    let name: String
    let price: String
}
