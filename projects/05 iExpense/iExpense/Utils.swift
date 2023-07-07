//
//  Utils.swift
//  iExpense
//
//  Created by Matthew Simo on 7/7/23.
//

import Foundation


var asCurrency : FloatingPointFormatStyle<Double>.Currency {
    FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "USD")
}
