//
//  ViewController.swift
//  ARLearn
//
//  Created by Davin on 11/12/19.
//  Copyright © 2019 Leanbs. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    private var sceneView = ARSCNView()
    
    private lazy var bottomBar: UIView = {
        let bottom = UIView()
        bottom.backgroundColor = .white
        bottom.frame = CGRect(x: 0, y: view.frame.size.height - 72, width: view.frame.size.width, height: 72)
        bottom.bounds.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        bottom.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let addButton = createButton(title: "+")
        addButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        let removeButton = createButton(title: "-")
        removeButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        let rotateLButton = createButton(title: "<")
        rotateLButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        let rotateRButton = createButton(title: ">")
        rotateRButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        var stackView = UIStackView(arrangedSubviews: [addButton, removeButton, rotateLButton, rotateRButton])
        stackView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80)
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        bottom.addSubview(stackView)
        
        return bottom
    }()
    
    func setupView() {
        self.view.addSubview(bottomBar)
    }
    
    func setupSceneView() {
        view.addSubview(sceneView)
        
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.delegate = self
        
        // to show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sceneView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        sceneView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSceneView()
        registerGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    private func registerGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(gestureRecognizer: UIGestureRecognizer) {
        let sceneLocation = gestureRecognizer.view as! ARSCNView
        let touchLocation = gestureRecognizer.location(in: sceneLocation)
        
        let hitResult = self.sceneView.hitTest(touchLocation, types: [.existingPlaneUsingExtent, .estimatedHorizontalPlane])
        
        if hitResult.count > 0 {
//            guard let hitTestResult = hitResult.first else {
//                return
//            }
            
            print("hit")
        }
    }
    
    // MARK: - Utilities function
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 56)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 12
        return button
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
