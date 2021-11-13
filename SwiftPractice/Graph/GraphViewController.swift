//
//  GraphViewController.swift
//  SwiftPractice
//
//  Created by Yu-Chun Hsu on 2021/6/14.
//  Copyright © 2021 PCNB2003010. All rights reserved.
//

import Foundation
import UIKit

class BaseGraph: NSObject {
    var nodes: [BaseNode]?
    override init() {
        super.init()
        self.nodes = []
    }
}

class BaseNode: NSObject {
    let value: Int
    var edges: Set<Int>?
    init(value: Int) {
        self.value = value
        self.edges = []
        super.init()
    }
}

class GraphViewController: UIViewController {
    
    @IBOutlet weak var indexTextField: UITextField!
    
    var graphsDict = ["1":["2", "3"], "2":["1"], "3":["1", "6", "7"], "6":["3"], "7":["3"]]
   
    var myGraph: BaseGraph?
    
    static func instantiate() -> GraphViewController
    {
        return UIStoryboard(name: "Tutorials", bundle: nil).instantiateViewController(withIdentifier: "GraphViewController") as! GraphViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGraph = generateGraph()
        // Do any additional setup after loading the view.
        _ = isNodesConnected(1, 2)
        _ = isNodesConnected(3, 2)
        _ = isNodesConnected(3, 4)
        _ = isNodesConnected(3, 7)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addEdge(2, 3)
        _ = isNodesConnected(3, 2)
        removeEdge(1, 3)
        _ = isNodesConnected(1, 3)
        removeEdge(2, 3)
        _ = isNodesConnected(2, 3)
    }
    
    func generateGraph() -> BaseGraph {
        let graph = BaseGraph.init()
        
        for (node, edge) in graphsDict {
            if let value = Int(node) {
                let node = BaseNode.init(value: value)
                for connectedNode in edge {
                    if let connectedNodeIdx = Int(connectedNode) {
                        node.edges?.insert(connectedNodeIdx)
                    }
                }
                graph.nodes?.append(node)
            }
        }
        print ("[generateGraph] successfully")
        return graph
    }
    
    @IBAction func didValueChanged(_ sender: Any) {
        guard let indexTextField = sender as? UITextField, let text = indexTextField.text else {
            return
        }
        let indexValue:NSInteger = Int(text) ?? -1
        logConnectNode(nodeIdx: indexValue)
    }
    
    func logConnectNode(nodeIdx: Int) {
        guard nodeIdx >= 0 else {
            return
        }
        
        print("[logConnectNode] \(nodeIdx) => \(String(describing: graphsDict[String(nodeIdx)]))")
    }
    
    func isNodeExisted(nodeIdx: Int) -> Bool {
        return ((myGraph?.nodes?.filter({$0.value == nodeIdx}).count ?? 0) > 0)
    }
    
    func isNodesConnected(_ startNodeIdx: Int, _ endNodeIdx: Int) -> Bool {
        let isConnected = myGraph?.nodes?.filter({$0.value == startNodeIdx}).first?.edges?.contains(endNodeIdx) ?? false
        print ("\(startNodeIdx) and \(endNodeIdx) are connected => return \(isConnected)")
        return isConnected
    }
    
    func addEdge(_ startNodeIdx: Int, _ endNodeIdx: Int) {
        if (isNodesConnected(startNodeIdx, endNodeIdx)) {
            return
        }
        let startNode = myGraph?.nodes?.filter({$0.value == startNodeIdx}).first ?? BaseNode.init(value: startNodeIdx)
        let endNode = myGraph?.nodes?.filter({$0.value == endNodeIdx}).first ?? BaseNode.init(value: endNodeIdx)
        
        startNode.edges?.insert(endNodeIdx)
        endNode.edges?.insert(startNodeIdx)
        
        if (!isNodeExisted(nodeIdx: startNodeIdx)) {
            myGraph?.nodes?.append(startNode)
        }
        
        if (!isNodeExisted(nodeIdx: endNodeIdx)) {
            myGraph?.nodes?.append(endNode)
        }
        print ("[addEdge] \(startNodeIdx) and \(endNodeIdx) are connected")
    }
    
    func removeEdge(_ startNodeIdx: Int, _ endNodeIdx: Int) {
        if (!isNodesConnected(startNodeIdx, endNodeIdx)) {
            return
        }
        let startNode = myGraph?.nodes?.filter({$0.value == startNodeIdx}).first
        let endNode = myGraph?.nodes?.filter({$0.value == endNodeIdx}).first
        
        startNode!.edges?.remove(endNodeIdx)
        endNode!.edges?.remove(startNodeIdx)
        print ("[removeEdge] \(startNodeIdx) and \(endNodeIdx) are disconnected")
    }
}

