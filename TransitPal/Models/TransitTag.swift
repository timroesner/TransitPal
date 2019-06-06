//
//  TransitTag.swift
//  TransitPal
//
//  Created by Robert Trencheny on 6/5/19.
//  Copyright © 2019 Robert Trencheny. All rights reserved.
//

import Foundation
import CoreNFC
import PromiseKit

enum TransitTagType: CaseIterable {
    case feliCa
    case iso15693
    case iso7816
    case miFare
    case unknown
}

class TransitTag {
    var Label: String?
    var Serial: String?
    var Balance: Int?
    var Trips: [TransitTrip] = []
    var Refills: [TransitRefill] = []
    var ScannedAt: Date?
    var NFCType: TransitTagType?

    public var Events: [TransitEvent] {
        return self.Trips + self.Refills
    }

    var prettyBalance: String {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter.string(from: (NSNumber(value: Double(self.Balance ?? 0)/100))) ?? "0"
    }

    func importTag(_ foundTag: NFCNDEFTag) -> Promise<TransitTag> {
        fatalError("importTag is not implemented!")
    }
}
