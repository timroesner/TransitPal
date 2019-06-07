//
//  TransitTrip.swift
//  TransitPal
//
//  Created by Robert Trencheny on 6/5/19.
//  Copyright © 2019 Robert Trencheny. All rights reserved.
//

import Foundation

class TransitTrip: TransitEvent {
    var ExitTimestamp: Date?
    var Fare: Int = 0
    var From: Station = Station()
    var To: Station = Station()
    var Route: Int = 0
    var VehicleNumber: Int = 0
    var Mode: TransportType = TransportType()

    override var debugDescription: String {
        return "Timestamp: \(self.Timestamp), ExitTimestamp: \(self.ExitTimestamp), Fare: \(self.Fare), Agency: \(self.Agency.name.english), From: \(self.From.name.english), To: \(self.To.name.english), Route: \(self.Route), VehicleNumber: \(self.VehicleNumber), TransportCode: \(self.Mode)"
    }

    static func ==(lhs: TransitTrip, rhs: TransitTrip) -> Bool {
        return lhs.From == rhs.From && lhs.To == rhs.To && lhs.Agency == rhs.Agency
    }

    var prettyFare: String {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter.string(from: (NSNumber(value: Double(self.Fare)/100))) ?? "0"
    }
}

extension TransportType {
    var icon: FontAwesome {
        switch self {
        case .bus:
            return .bus
        case .train:
            return .train
        case .tram:
            return .tram
        case .metro:
            return .subway
        case .ferry:
            return .ship
        case .ticketMachine:
            return .ticketAlt
        case .vendingMachine, .pos:
            return .cashRegister
        case .banned:
            return .ban
        case .trolleybus:
            return .busAlt
        case .unknown, .other, .UNRECOGNIZED(_):
            return .questionCircle
        }
    }
}
