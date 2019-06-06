//
//  ClipperTrip.swift
//  TransitPal
//
//  Created by Robert Trencheny on 6/4/19.
//  Copyright © 2019 Robert Trencheny. All rights reserved.
//

import Foundation
import SwiftUI

class ClipperTrip: TransitTrip {
    var Route: Int16 = 0
    var VehicleNumber: Int16 = 0
    var TransportCode: ClipperTransportCode = .Other

    override init() {}

    init(_ data: Data) {
        super.init()

        self.Timestamp = Date(timeInterval: TimeInterval(dataToInt(data, 0xc, 4)), since: Date(timeIntervalSince1970: -2208988800))
        self.ExitTimestamp = Date(timeInterval: TimeInterval(dataToInt(data, 0x10, 4)), since: Date(timeIntervalSince1970: -2208988800))

        if self.ExitTimestamp == Date(timeIntervalSince1970: -2208988800) {
            self.ExitTimestamp = nil
        }

        let fare: Int16 = data[0x6...0x8].withUnsafeBytes { $0.pointee }
        self.Fare = fare.bigEndian

        self.Agency = ClipperAgency(rawValue: UInt(data.subdata(in: 0x2..<0x2+2).last!))!

        let fromStation: Int16 = data[0x14...0x15].withUnsafeBytes { $0.pointee }
        self.From = fromStation.bigEndian

        let toStation: Int16 = data[0x16...0x17].withUnsafeBytes { $0.pointee }

        self.To = toStation.bigEndian
        let route: Int16 = data[0x1c...0x1d].withUnsafeBytes { $0.pointee }
        self.Route = route.bigEndian
        let vehicleID: Int16 = data[0xa...0xb].withUnsafeBytes { $0.pointee }
        self.VehicleNumber = vehicleID.bigEndian

        self.TransportCode = ClipperTransportCode(data.subdata(in: 0x1e..<0x1e+2).last!, self.Agency)
    }

    override var debugDescription: String {
        return "Timestamp: \(self.Timestamp), ExitTimestamp: \(self.ExitTimestamp), Fare: \(self.Fare), Agency: \(self.Agency), From: \(self.From), To: \(self.To), Route: \(self.Route), VehicleNumber: \(self.VehicleNumber), TransportCode: \(self.TransportCode)"
    }

    static func ==(lhs: ClipperTrip, rhs: ClipperTrip) -> Bool {
        return lhs.From == rhs.From && lhs.To == rhs.To && lhs.Agency == rhs.Agency
    }
}
