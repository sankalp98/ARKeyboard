//
//  InteractiveARSceneManager.swift
//  iOS App
//
//  Created by Sankalp Kasale on 22.08.19.
//

import UIKit
import ARKit

enum BodyType: Int {
    case boxQ = 1, boxW, boxE, boxR, boxT, boxY, boxU, boxI, boxO, boxP, boxA, boxS, boxD, boxF, boxG, boxH, boxJ, boxK, boxL, boxZ, boxX, boxC, boxV, boxB, boxN, boxM
    case sphere = 0
}

class InteractiveARSceneManager: NSObject, SCNPhysicsContactDelegate {
    fileprivate let sceneView: ARSCNView
    fileprivate let scene = SCNScene()
    fileprivate var planes: [String : SCNNode] = [:]
    fileprivate var showPlanes: Bool = true
//    fileprivate let geometryNodeA: SCNNode = SCNNode()
//    fileprivate let geometryNodeB: SCNNode = SCNNode()
//    fileprivate let geometryNodeC: SCNNode = SCNNode()
//    fileprivate let geometryNodeD: SCNNode = SCNNode()
    fileprivate let geometryNodeQ: SCNNode = SCNNode()
    fileprivate let geometryNodeW: SCNNode = SCNNode()
    fileprivate let geometryNodeE: SCNNode = SCNNode()
    fileprivate let geometryNodeR: SCNNode = SCNNode()
    fileprivate let geometryNodeT: SCNNode = SCNNode()
    fileprivate let geometryNodeY: SCNNode = SCNNode()
    fileprivate let geometryNodeU: SCNNode = SCNNode()
    fileprivate let geometryNodeI: SCNNode = SCNNode()
    fileprivate let geometryNodeO: SCNNode = SCNNode()
    fileprivate let geometryNodeP: SCNNode = SCNNode()
    
    fileprivate let geometryNodeA: SCNNode = SCNNode()
    fileprivate let geometryNodeS: SCNNode = SCNNode()
    fileprivate let geometryNodeD: SCNNode = SCNNode()
    fileprivate let geometryNodeF: SCNNode = SCNNode()
    fileprivate let geometryNodeG: SCNNode = SCNNode()
    fileprivate let geometryNodeH: SCNNode = SCNNode()
    fileprivate let geometryNodeJ: SCNNode = SCNNode()
    fileprivate let geometryNodeK: SCNNode = SCNNode()
    fileprivate let geometryNodeL: SCNNode = SCNNode()
    
    fileprivate let geometryNodeZ: SCNNode = SCNNode()
    fileprivate let geometryNodeX: SCNNode = SCNNode()
    fileprivate let geometryNodeC: SCNNode = SCNNode()
    fileprivate let geometryNodeV: SCNNode = SCNNode()
    fileprivate let geometryNodeB: SCNNode = SCNNode()
    fileprivate let geometryNodeN: SCNNode = SCNNode()
    fileprivate let geometryNodeM: SCNNode = SCNNode()
    
    fileprivate let sphereNode: SCNNode = SCNNode()
    fileprivate var textNode: SCNNode = SCNNode()
    fileprivate var MaintextNode: SCNNode = SCNNode()
    fileprivate var Maintext: SCNText = SCNText()
    fileprivate let metalMaterial = MetalMaterial(surfaceType: .streaked)
    var upperkeys = ["Q","W","E","R","T","Y","U","I","O","P",]
    var middlekeys = ["A","S","D","F","G","H","J","K","L"]
    var lowerkeys = ["Z","X","C","V","B","N","M"]
    var counterr = 0
    var xcounter = 0.0
    var mainSentence = ""
    var upperkeynodes: [SCNNode] = []
    var middlekeynodes: [SCNNode] = []
    var lowerkeynodes: [SCNNode] = []
    
    var sphereNodeAdded = false
    
    init(sceneView: ARSCNView) {
        self.sceneView = sceneView
        super.init()
        commonInit()
    }
    
    fileprivate func commonInit() {
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        sceneView.antialiasingMode = .multisampling4X
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.preferredFramesPerSecond = 60
        sceneView.scene.physicsWorld.contactDelegate = self
        sceneView.debugOptions = [
//            ARSCNDebugOptions.showWorldOrigin,
            ARSCNDebugOptions.showFeaturePoints
        ]
        setupEnvironment()
        addGeometry()
    }
    
    private func addGeometry() {
        let boxGeometry = SCNBox(
            width: 1,
            height: 1,
            length: 0.01,
            chamferRadius: 0.005
        )
        boxGeometry.firstMaterial = metalMaterial
        
        self.upperkeynodes.append(geometryNodeQ)
        self.upperkeynodes.append(geometryNodeW)
        self.upperkeynodes.append(geometryNodeE)
        self.upperkeynodes.append(geometryNodeR)
        self.upperkeynodes.append(geometryNodeT)
        self.upperkeynodes.append(geometryNodeY)
        self.upperkeynodes.append(geometryNodeU)
        self.upperkeynodes.append(geometryNodeI)
        self.upperkeynodes.append(geometryNodeO)
        self.upperkeynodes.append(geometryNodeP)
        createUpperKeys(keys: upperkeys, keynodes: upperkeynodes)
        
        self.middlekeynodes.append(geometryNodeA)
        self.middlekeynodes.append(geometryNodeS)
        self.middlekeynodes.append(geometryNodeD)
        self.middlekeynodes.append(geometryNodeF)
        self.middlekeynodes.append(geometryNodeG)
        self.middlekeynodes.append(geometryNodeH)
        self.middlekeynodes.append(geometryNodeJ)
        self.middlekeynodes.append(geometryNodeK)
        self.middlekeynodes.append(geometryNodeL)
        createMiddleKeys(keys: middlekeys, keynodes: middlekeynodes)
        
        self.lowerkeynodes.append(geometryNodeZ)
        self.lowerkeynodes.append(geometryNodeX)
        self.lowerkeynodes.append(geometryNodeC)
        self.lowerkeynodes.append(geometryNodeV)
        self.lowerkeynodes.append(geometryNodeB)
        self.lowerkeynodes.append(geometryNodeN)
        self.lowerkeynodes.append(geometryNodeM)
        createLowerKeys(keys: lowerkeys, keynodes: lowerkeynodes)
        
        let sphereGeometry = SCNSphere(radius: 0.01)
        sphereGeometry.firstMaterial = metalMaterial
        sphereNode.geometry = sphereGeometry
        let sphere = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: sphereNode))
        sphereNode.physicsBody = sphere
        sphereNode.name = "finger"
        sphereNode.physicsBody?.categoryBitMask = BodyType.sphere.rawValue
        //sphereNode.physicsBody?.collisionBitMask = BodyType.boxA.rawValue | BodyType.boxB.rawValue | BodyType.boxC.rawValue | BodyType.boxD.rawValue
        sphereNode.physicsBody?.contactTestBitMask = BodyType.boxQ.rawValue | BodyType.boxW.rawValue | BodyType.boxE.rawValue | BodyType.boxR.rawValue | BodyType.boxT.rawValue | BodyType.boxY.rawValue | BodyType.boxU.rawValue | BodyType.boxI.rawValue | BodyType.boxO.rawValue | BodyType.boxP.rawValue | BodyType.boxA.rawValue | BodyType.boxS.rawValue | BodyType.boxD.rawValue | BodyType.boxF.rawValue | BodyType.boxG.rawValue | BodyType.boxH.rawValue | BodyType.boxJ.rawValue | BodyType.boxK.rawValue | BodyType.boxL.rawValue | BodyType.boxZ.rawValue | BodyType.boxX.rawValue | BodyType.boxC.rawValue | BodyType.boxV.rawValue | BodyType.boxB.rawValue | BodyType.boxN.rawValue | BodyType.boxM.rawValue
        sphereNode.position = SCNVector3(
            x: 0,
            y: 0,
            z: -1
        )
        scene.rootNode.addChildNode(sphereNode)
        
        self.addMainText(string: "\(mainSentence)", parent: scene.rootNode)
        
    }
    
    func clearsentence()
    {
        self.mainSentence = ""
    }
    
    func createUpperKeys(keys: [String], keynodes: [SCNNode])
    {
        let boxGeometry = SCNBox(
            width: 0.2,
            height: 0.2,
            length: 0.01,
            chamferRadius: 0.005
        )
        boxGeometry.firstMaterial = metalMaterial
        
        var somedist = Float(0)
        
        for node in keynodes
        {
            node.geometry = boxGeometry
            let xbox = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: node))
            node.physicsBody = xbox
            let indexOfnode = keynodes.firstIndex(of: node)
            node.name = keys[indexOfnode!]
            switch node.name {
            case "Q":
                node.physicsBody?.categoryBitMask = BodyType.boxQ.rawValue
            case "W":
                node.physicsBody?.categoryBitMask = BodyType.boxW.rawValue
            case "E":
                node.physicsBody?.categoryBitMask = BodyType.boxE.rawValue
            case "R":
                node.physicsBody?.categoryBitMask = BodyType.boxR.rawValue
            case "T":
                node.physicsBody?.categoryBitMask = BodyType.boxT.rawValue
            case "Y":
                node.physicsBody?.categoryBitMask = BodyType.boxY.rawValue
            case "U":
                node.physicsBody?.categoryBitMask = BodyType.boxU.rawValue
            case "I":
                node.physicsBody?.categoryBitMask = BodyType.boxI.rawValue
            case "O":
                node.physicsBody?.categoryBitMask = BodyType.boxO.rawValue
            case "P":
                node.physicsBody?.categoryBitMask = BodyType.boxP.rawValue
            default :
                node.physicsBody?.categoryBitMask = BodyType.boxQ.rawValue
            }
            
            node.physicsBody?.contactTestBitMask = BodyType.sphere.rawValue
            
            node.position = SCNVector3(
                x: somedist,
                y: 0,
                z: -1.9
            )
            somedist = somedist+0.4
            scene.rootNode.addChildNode(node)
            self.addText(string: "\(node.name ?? "/")", parent: node)
        }
    }
    
    func createMiddleKeys(keys: [String], keynodes: [SCNNode])
    {
        let boxGeometry = SCNBox(
            width: 0.2,
            height: 0.2,
            length: 0.01,
            chamferRadius: 0.005
        )
        boxGeometry.firstMaterial = metalMaterial
        
        var somedist = Float(0)
        
        for node in keynodes
        {
            node.geometry = boxGeometry
            let xbox = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: node))
            node.physicsBody = xbox
            let indexOfnode = keynodes.firstIndex(of: node)
            node.name = keys[indexOfnode!]
            switch node.name {
            case "A":
                node.physicsBody?.categoryBitMask = BodyType.boxA.rawValue
            case "S":
                node.physicsBody?.categoryBitMask = BodyType.boxS.rawValue
            case "D":
                node.physicsBody?.categoryBitMask = BodyType.boxD.rawValue
            case "F":
                node.physicsBody?.categoryBitMask = BodyType.boxF.rawValue
            case "G":
                node.physicsBody?.categoryBitMask = BodyType.boxG.rawValue
            case "H":
                node.physicsBody?.categoryBitMask = BodyType.boxH.rawValue
            case "J":
                node.physicsBody?.categoryBitMask = BodyType.boxJ.rawValue
            case "K":
                node.physicsBody?.categoryBitMask = BodyType.boxK.rawValue
            case "L":
                node.physicsBody?.categoryBitMask = BodyType.boxL.rawValue
            default :
                node.physicsBody?.categoryBitMask = BodyType.boxQ.rawValue
            }
            
            node.physicsBody?.contactTestBitMask = BodyType.sphere.rawValue
            
            node.position = SCNVector3(
                x: somedist+0.1,
                y: -0.3,
                z: -1.9
            )
            somedist = somedist+0.4
            scene.rootNode.addChildNode(node)
            self.addText(string: "\(node.name ?? "/")", parent: node)
        }
    }
    
    func createLowerKeys(keys: [String], keynodes: [SCNNode])
    {
        let boxGeometry = SCNBox(
            width: 0.2,
            height: 0.2,
            length: 0.01,
            chamferRadius: 0.005
        )
        boxGeometry.firstMaterial = metalMaterial
        
        var somedist = Float(0)
        
        for node in keynodes
        {
            node.geometry = boxGeometry
            let xbox = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: node))
            node.physicsBody = xbox
            let indexOfnode = keynodes.firstIndex(of: node)
            node.name = keys[indexOfnode!]
            switch node.name {
            case "Z":
                node.physicsBody?.categoryBitMask = BodyType.boxZ.rawValue
            case "X":
                node.physicsBody?.categoryBitMask = BodyType.boxX.rawValue
            case "C":
                node.physicsBody?.categoryBitMask = BodyType.boxC.rawValue
            case "V":
                node.physicsBody?.categoryBitMask = BodyType.boxV.rawValue
            case "B":
                node.physicsBody?.categoryBitMask = BodyType.boxB.rawValue
            case "N":
                node.physicsBody?.categoryBitMask = BodyType.boxN.rawValue
            case "M":
                node.physicsBody?.categoryBitMask = BodyType.boxM.rawValue
            default :
                node.physicsBody?.categoryBitMask = BodyType.boxQ.rawValue
            }
            
            node.physicsBody?.contactTestBitMask = BodyType.sphere.rawValue
            
            node.position = SCNVector3(
                x: somedist+0.2,
                y: -0.6,
                z: -1.9
            )
            somedist = somedist+0.4
            scene.rootNode.addChildNode(node)
            self.addText(string: "\(node.name ?? "/")", parent: node)
        }
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        //print("Contact Happened!")
        //print(self.counterr)
        counterr = counterr+1
        
        var lastChar = ""
        var countofMainSentence = 0
        
        let fadeoutanimation = SCNAction.fadeOut(duration: 0.25)
        //contact.nodeA.runAction(fadeoutanimation)
        let fadeinanimation = SCNAction.fadeIn(duration: 0.25)
        
        let sequence = SCNAction.sequence([fadeoutanimation, fadeinanimation])
        contact.nodeA.runAction(sequence)
        
        if let name1 = contact.nodeA.name
        {
            if let name2 = contact.nodeB.name
            {
                print(name1, name2)
                countofMainSentence = mainSentence.count

                if countofMainSentence != 0
                {
                    lastChar = String(mainSentence.last!)
                    if name1 != lastChar
                    {
                        mainSentence.append(name1)
                        self.updateMainText(string: mainSentence)
                        print(mainSentence)
                    }
                }
                else
                {
                    mainSentence.append(name1)
                    self.updateMainText(string: mainSentence)
                    print(mainSentence)
                }
            }
        }
        
        //let fadeinanimation = SCNAction.fadeIn(duration: 0.2)
        //contact.nodeA.runAction(fadeinanimation)
        
    }
    
    func createTextNode(string: String) -> SCNNode {
        let text = SCNText(string: string, extrusionDepth: 0.1)
        text.font = UIFont.systemFont(ofSize: 1.0)
        text.flatness = 0.01
        text.firstMaterial?.diffuse.contents = UIColor.white

        let textNode = SCNNode(geometry: text)

        let fontSize = Float(0.04)
        textNode.scale = SCNVector3(fontSize, fontSize, fontSize)

        return textNode
    }
    
    func addText(string: String, parent: SCNNode) {
        let textNode = self.createTextNode(string: string)
        textNode.position = SCNVector3(
            x: -0.015,
            y: -0.05,
            z: 0.01
        )

        parent.addChildNode(textNode)
    }
    
    func addMainText(string: String, parent: SCNNode) {
        self.MaintextNode = self.createMainTextNode(string: string)
        MaintextNode.position = SCNVector3(
            x: 0,
            y: 0.2,
            z: -2
        )

        parent.addChildNode(MaintextNode)
    }
    
    func createMainTextNode(string: String) -> SCNNode {
        let text = SCNText(string: string, extrusionDepth: 0.1)
        text.font = UIFont.systemFont(ofSize: 2.0)
        text.flatness = 0.01
        text.firstMaterial?.diffuse.contents = UIColor.white
        self.Maintext = text

        let textNode = SCNNode(geometry: Maintext)

        let fontSize = Float(0.04)
        textNode.scale = SCNVector3(fontSize, fontSize, fontSize)

        return textNode
    }
    
    func updateMainText(string: String)
    {
        self.Maintext.string = string
    }
    
    fileprivate func setupEnvironment() {
        let environmentMap = UIImage(named: "apartmentBlurred")
        scene.lightingEnvironment.contents = environmentMap
        scene.lightingEnvironment.intensity = 1.5
    }
    
    func updateGeometry(with translation: SCNVector3, and rotation: SCNVector3, and indexPosition: SCNVector3) {
        //geometryNode.runAction(.move(by: translation, duration: 0))
        //geometryNode.eulerAngles = rotation
        
        if self.sphereNodeAdded == true
        {
            let skrrtranslation = SCNVector3(
                x: (-translation.x),
                y: (-translation.z),
                z: (-translation.y)
            )
            sphereNode.runAction(.move(by: skrrtranslation, duration: 0))
            sphereNode.eulerAngles = rotation
            print(sphereNode.position)
        }
        else
        {
            let indexTipPosition = SCNVector3(
                x: (indexPosition.x * 0.01),
                y: (-indexPosition.z * 0.01) - 0.5,
                z: (-indexPosition.y * 0.01)
            )
            sphereNode.position = indexTipPosition
            scene.rootNode.addChildNode(sphereNode)
            self.sphereNodeAdded = true
            print(sphereNode.position)
            
        }
    }
    
    func updatePositionAndOrientationOf(_ node: SCNNode, withPosition position: SCNVector3, relativeTo referenceNode: SCNNode) {
        let referenceNodeTransform = matrix_float4x4(referenceNode.transform)
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = node.transform

        // Setup a translation matrix with the desired position
        var translationMatrix = matrix_identity_float4x4
        translationMatrix.columns.3.x = -position.x
        translationMatrix.columns.3.y = -position.y
        translationMatrix.columns.3.z = -position.z

        // Combine the configured translation matrix with the referenceNode's transform to get the desired position AND orientation
        let updatedTransform = matrix_multiply(referenceNodeTransform, translationMatrix)
        node.transform = SCNMatrix4(updatedTransform)
        
        animation.toValue = SCNMatrix4(updatedTransform)
        animation.duration = 0.1
        node.addAnimation(animation, forKey: nil)
        //node.runAction(.move(to: newpalmpositon, duration: 0))
    }
    
    func matchCordinates(with indexPosition: SCNVector3, and palmPostion: SCNVector3, and gesture: Float)
    {
//        let indexTipPosition = SCNVector3(
//            x: (-indexPosition.x * 0.01),
//            y: (-indexPosition.z * 0.01) - 0.5,
//            z: (-indexPosition.y * 0.01)
//        )
        //print(indexTipPosition.x, indexTipPosition.y, indexTipPosition.z)
        
//        var ogcameraposition = sceneView.pointOfView?.position
//        var ogcameraeulerangles = sceneView.pointOfView?.eulerAngles
        
        //self.sphereNode.eulerAngles = ogcameraeulerangles!
        //self.sphereNode.orientation = sceneView.pointOfView?.orientation as! SCNQuaternion
        //self.sphereNode.rotation = sceneView.pointOfView?.rotation as! SCNVector4
        
//        var yyy = ogcameraposition!.y - ((palmPostion.z) * 4);
//        //recenter origin
//        var xxx = ogcameraposition!.x - ((palmPostion.x) * 4) + 1.3;
//        //scale
//        var zzz = ogcameraposition!.z - ((palmPostion.y) * 4);
//
//        let newpalmpositon = SCNVector3Make(xxx, yyy, zzz)
        
        //print(newpalmpositon)
        //sphereNode.runAction(.move(to: newpalmpositon, duration: 0))
        
        let sphereNodeDesiredPosition = SCNVector3Make(((indexPosition.x) * 2) - 1, ((indexPosition.z) * 1.5), ((indexPosition.y) * 2))
        let cameranode = sceneView.pointOfView
        //var smaplepos = SCNVector3Make(1, 1, 1)
        updatePositionAndOrientationOf(sphereNode, withPosition: sphereNodeDesiredPosition, relativeTo: cameranode!)
        print(sphereNode.position)
        
        
        /*
        let skrr = SCNVector3EqualToVector3(indexPosition, palmPostion)
        let indexpositionx = indexPosition.x
        let indexpositiony = indexPosition.y
        let indexpositionz = indexPosition.z
        let palmPostionx = palmPostion.x
        let palmPostiony = palmPostion.y
        let palmPostionz = palmPostion.z
        let isittrue = (indexpositionx-palmPostionx < 10) && (indexpositiony-palmPostiony < 10) && (indexpositionz-palmPostionz < 10)
        if skrr == true || isittrue == true
        {
            print("Gesture recognized")
        }
        */
    }
}

extension InteractiveARSceneManager {
    func runSession() {
        
        guard ARWorldTrackingConfiguration.isSupported else {
            let configuration = ARWorldTrackingConfiguration()
            sceneView.session.run(configuration)
            return
        }
        
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else {
            fatalError("People occlusion is not supported on this device.")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics.insert(.personSegmentationWithDepth)
        configuration.planeDetection = .horizontal
        sceneView.session.run(
            configuration,
            options: [
                .resetTracking,
                .removeExistingAnchors
            ]
        )
    }
    
    func pauseSession() {
        sceneView.session.pause()
    }
}

extension InteractiveARSceneManager: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let key = planeAnchor.identifier.uuidString
        let planeNode = NodeGenerator.generatePlaneFrom(planeAnchor: planeAnchor, physics: true, hidden: !self.showPlanes)
        node.addChildNode(planeNode)
        self.planes[key] = planeNode
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let key = planeAnchor.identifier.uuidString
        if let existingPlane = self.planes[key] {
            NodeGenerator.update(planeNode: existingPlane, from: planeAnchor, hidden: !self.showPlanes)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let key = planeAnchor.identifier.uuidString
        if let existingPlane = self.planes[key] {
            existingPlane.removeFromParentNode()
            self.planes.removeValue(forKey: key)
        }
    }
}
