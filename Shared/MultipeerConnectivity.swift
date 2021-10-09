//
//  MultipeerConnectivity.swift
//  ARKit LeapMotion Control
//
//  Created by Sankalp Kasale on 22.08.19.
//

import Foundation
import CoreGraphics
import MultipeerConnectivity

struct LMMCService {
    static let type: String = "as-lmd"
}

struct LMHData {
    let x: Float
    let y: Float
    let z: Float
    let pitch: Float
    let yaw: Float
    let roll: Float
    let xposition: Float
    let yposition: Float
    let zposition: Float
    let xindexTipPosition: Float
    let yindexTipPosition: Float
    let zindexTipPosition: Float
    let gesture: Float
    
    init(
        x: Float,
        y: Float,
        z: Float,
        pitch: Float,
        yaw: Float,
        roll: Float,
        xposition: Float,
        yposition: Float,
        zposition: Float,
        xindexTipPosition: Float,
        yindexTipPosition: Float,
        zindexTipPosition: Float,
        gesture: Float
    ){
        self.x = x
        self.y = y
        self.z = z
        self.pitch = pitch
        self.yaw = yaw
        self.roll = roll
        self.xposition = xposition
        self.yposition = yposition
        self.zposition = zposition
        self.xindexTipPosition = xindexTipPosition
        self.yindexTipPosition = yindexTipPosition
        self.zindexTipPosition = zindexTipPosition
        self.gesture = gesture
    }
    
    init(
        x: CGFloat,
        y: CGFloat,
        z: CGFloat,
        pitch: CGFloat,
        yaw: CGFloat,
        roll: CGFloat,
        xposition: CGFloat,
        yposition: CGFloat,
        zposition: CGFloat,
        xindexTipPosition: CGFloat,
        yindexTipPosition: CGFloat,
        zindexTipPosition: CGFloat,
        gesture: Float
    ){
        self.x = Float(x)
        self.y = Float(y)
        self.z = Float(z)
        self.pitch = Float(pitch)
        self.yaw = Float(yaw)
        self.roll = Float(roll)
        self.xposition = Float(xposition)
        self.yposition = Float(yposition)
        self.zposition = Float(zposition)
        self.xindexTipPosition = Float(xindexTipPosition)
        self.yindexTipPosition = Float(yindexTipPosition)
        self.zindexTipPosition = Float(zindexTipPosition)
        self.gesture = Float(gesture)
    }
    
    init(fromBytes: [UInt8]) {
        self.x = fromByteArray(Array(fromBytes[0...3]), Float.self)
        self.y = fromByteArray(Array(fromBytes[4...7]), Float.self)
        self.z = fromByteArray(Array(fromBytes[8...11]), Float.self)
        self.pitch = fromByteArray(Array(fromBytes[12...15]), Float.self)
        self.yaw = fromByteArray(Array(fromBytes[16...19]), Float.self)
        self.roll = fromByteArray(Array(fromBytes[20...23]), Float.self)
        self.xposition = fromByteArray(Array(fromBytes[24...27]), Float.self)
        self.yposition = fromByteArray(Array(fromBytes[28...31]), Float.self)
        self.zposition = fromByteArray(Array(fromBytes[32...35]), Float.self)
        self.xindexTipPosition = fromByteArray(Array(fromBytes[36...39]), Float.self)
        self.yindexTipPosition = fromByteArray(Array(fromBytes[40...43]), Float.self)
        self.zindexTipPosition = fromByteArray(Array(fromBytes[44...47]), Float.self)
        self.gesture = fromByteArray(Array(fromBytes[48...51]), Float.self)
    }
    
    func toBytes() -> [UInt8] {
        let composite = [x, y, z, roll, pitch, yaw, xposition, yposition, zposition, xindexTipPosition, yindexTipPosition, zindexTipPosition, gesture]
        return composite.flatMap(){ toByteArray($0) }
    }
}


// http://stackoverflow.com/questions/26953591/how-to-convert-a-double-into-a-byte-array-in-swift
func toByteArray<T>(_ value: T) -> [UInt8] {
    var value = value
    return withUnsafeBytes(of: &value) { Array($0) }
}

func fromByteArray<T>(_ value: [UInt8], _: T.Type) -> T {
    return value.withUnsafeBytes {
        $0.baseAddress!.load(as: T.self)
    }
}


struct LMHDataNew {
    let xindextiptranslation: Float
    let yindextiptranslation: Float
    let zindextiptranslation: Float
    let pitch: Float
    let yaw: Float
    let roll: Float
    let xposition: Float
    let yposition: Float
    let zposition: Float
    let xindexTipPosition: Float
    let yindexTipPosition: Float
    let zindexTipPosition: Float
    let gesture: Float
    
    init(
        xindextiptranslation: Float,
        yindextiptranslation: Float,
        zindextiptranslation: Float,
        pitch: Float,
        yaw: Float,
        roll: Float,
        xposition: Float,
        yposition: Float,
        zposition: Float,
        xindexTipPosition: Float,
        yindexTipPosition: Float,
        zindexTipPosition: Float,
        gesture: Float
    ){
        self.xindextiptranslation = xindextiptranslation
        self.yindextiptranslation = yindextiptranslation
        self.zindextiptranslation = zindextiptranslation
        self.pitch = pitch
        self.yaw = yaw
        self.roll = roll
        self.xposition = xposition
        self.yposition = yposition
        self.zposition = zposition
        self.xindexTipPosition = xindexTipPosition
        self.yindexTipPosition = yindexTipPosition
        self.zindexTipPosition = zindexTipPosition
        self.gesture = gesture
    }
    
    init(
        xindextiptranslation: CGFloat,
        yindextiptranslation: CGFloat,
        zindextiptranslation: CGFloat,
        pitch: CGFloat,
        yaw: CGFloat,
        roll: CGFloat,
        xposition: CGFloat,
        yposition: CGFloat,
        zposition: CGFloat,
        xindexTipPosition: CGFloat,
        yindexTipPosition: CGFloat,
        zindexTipPosition: CGFloat,
        gesture: Float
    ){
        self.xindextiptranslation = Float(xindextiptranslation)
        self.yindextiptranslation = Float(yindextiptranslation)
        self.zindextiptranslation = Float(zindextiptranslation)
        self.pitch = Float(pitch)
        self.yaw = Float(yaw)
        self.roll = Float(roll)
        self.xposition = Float(xposition)
        self.yposition = Float(yposition)
        self.zposition = Float(zposition)
        self.xindexTipPosition = Float(xindexTipPosition)
        self.yindexTipPosition = Float(yindexTipPosition)
        self.zindexTipPosition = Float(zindexTipPosition)
        self.gesture = Float(gesture)
    }
    
    init(fromBytes: [UInt8]) {
        self.xindextiptranslation = fromByteArray(Array(fromBytes[0...3]), Float.self)
        self.yindextiptranslation = fromByteArray(Array(fromBytes[4...7]), Float.self)
        self.zindextiptranslation = fromByteArray(Array(fromBytes[8...11]), Float.self)
        self.pitch = fromByteArray(Array(fromBytes[12...15]), Float.self)
        self.yaw = fromByteArray(Array(fromBytes[16...19]), Float.self)
        self.roll = fromByteArray(Array(fromBytes[20...23]), Float.self)
        self.xposition = fromByteArray(Array(fromBytes[24...27]), Float.self)
        self.yposition = fromByteArray(Array(fromBytes[28...31]), Float.self)
        self.zposition = fromByteArray(Array(fromBytes[32...35]), Float.self)
        self.xindexTipPosition = fromByteArray(Array(fromBytes[36...39]), Float.self)
        self.yindexTipPosition = fromByteArray(Array(fromBytes[40...43]), Float.self)
        self.zindexTipPosition = fromByteArray(Array(fromBytes[44...47]), Float.self)
        self.gesture = fromByteArray(Array(fromBytes[48...51]), Float.self)
    }
    
    func toBytes() -> [UInt8] {
        let composite = [xindextiptranslation, yindextiptranslation, zindextiptranslation, roll, pitch, yaw, xposition, yposition, zposition, xindexTipPosition, yindexTipPosition, zindexTipPosition, gesture]
        return composite.flatMap(){ toByteArray($0) }
    }
}
