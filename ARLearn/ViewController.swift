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
    private var selectedNode = SCNNode()
    private var items = ItemList()
    
    private lazy var stackView: UIStackView = {
        let addButton = createButton(title: "+")
        let removeButton = createButton(title: "-")
        let rotateLButton = createButton(title: "<")
        let rotateRButton = createButton(title: ">")
        
        var stackView = UIStackView(arrangedSubviews: [addButton, removeButton, rotateLButton, rotateRButton])
        
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var bottomBar: UIView = {
        let bottom = UIView()
        bottom.backgroundColor = .white
        bottom.translatesAutoresizingMaskIntoConstraints = false
        
        return bottom
    }()
    
    private lazy var safeAreaInset: UIEdgeInsets = {
        if #available(iOS 11.0, *), let windowInset = UIApplication.shared.keyWindow?.safeAreaInsets {
            return windowInset
        }
        return .zero
    }()
    
    func setupView() {
        bottomBar.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: bottomBar.heightAnchor),
            stackView.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor),
        ])
        
        self.view.addSubview(bottomBar)
        
        NSLayoutConstraint.activate([
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func setupSceneView() {
        view.addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.delegate = self
                
        // to show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sceneView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sceneView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor ).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSceneView()
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
    
    // MARK: - Utilities function
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
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
