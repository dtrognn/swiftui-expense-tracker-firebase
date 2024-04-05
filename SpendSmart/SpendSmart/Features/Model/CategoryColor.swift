//
//  CategoryColor.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

enum CategoryColor: String, CaseIterable, Identifiable {
    case cornflowerBlue = "699BF7"
    // default
    case bronze = "D27C2C"
    case jordyBlue = "89BEE4"
    case oceanGreen = "4FCA8F"
    case mulberry = "FD413C"
    case mikadoYellow = "FFC107"
    case indianYellow = "E4A951"
    case seashell = "FDEEEE"
    case tangerine = "FF9A62"
    case coconut = "905F31"
    case yellowOrange = "FDB03C"
    case frenchPlum = "890E54"
    case oriolesOrange = "F24E1E"
    case spanishGray = "94989B"
    case flirt = "910A67"
    case spanishYellow = "F2BA13"
    case paradisePink = "ED4C5C"
    case heliotrope = "D269F7"
    case lightMalachiteGreen = "69F780"
    case lightCrimson = "F7698B"
    case electricBlue = "69F7EE"
    case inchworm = "B9F769"
    case violetAreBlue = "9669F7"
    case frenchSkyBlue = "86A7FC"


    var id: String { rawValue }

    var color: Color { return .initWith(hexString: rawValue, opacity: 1) }
}
