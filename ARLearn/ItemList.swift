//
//  ItemList.swift
//  ARLearn
//
//  Created by Davin on 19/12/19.
//  Copyright © 2019 Leanbs. All rights reserved.
//

import Foundation
import SceneKit

class ItemList {
    func addShip() -> SCNNode {
        let node = SCNNode()
        let scene = SCNScene(named: "art.scnassets/cup.scn")
        let nodeArray = scene!.rootNode.childNodes
        
        for childNode in nodeArray {
            node.addChildNode(childNode)
        }
        
         node.scale = SCNVector3(0.02, 0.02, 0.02)
        
        return node
    }
}
