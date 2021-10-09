//
//  LeapMotionGestureService.swift
//  Mac App
//
//  Created by Sankalp Kasale on 22.08.19.
//

import CoreBluetooth

enum LeapMotionGestureService {
    static let uuid: CBUUID = CBUUID(string: "54A9FEA5-E8F5-4D50-A4AA-759FCC0F0821")
    static let hand: CBUUID = CBUUID(string: "54A9FEA5-E8F5-4D50-A4AA-759FCC000002")
    static let finger: CBUUID = CBUUID(string: "54A9FEA5-E8F5-4D50-A4AA-759FCC000002")
    
    static let characteristics: [CBUUID] = [
        hand,
        finger
    ]
}
