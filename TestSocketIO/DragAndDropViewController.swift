//
//  DragAndDropViewController.swift
//  TestSocketIO
//
//  Created by Cliff Chan on 25/11/2021.
//

import UIKit

class DragAndDropViewController: UIViewController,SocketPositionManagerDelegate {

	@IBOutlet weak var viewDrag: UIView!
	var socketManager = SocketTutorialManager()
	
	override func viewDidLoad() {
        super.viewDidLoad()

		var panGesture = UIPanGestureRecognizer()
		
		panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
		viewDrag.isUserInteractionEnabled = true
		viewDrag.addGestureRecognizer(panGesture)
		
		socketManager.delegate = self
		socketManager.start()
    }
	
	@objc func draggedView(_ sender:UIPanGestureRecognizer){
		self.view.bringSubviewToFront(viewDrag)
		let translation = sender.translation(in: self.view)
		viewDrag.center = CGPoint(x: viewDrag.center.x + translation.x, y: viewDrag.center.y + translation.y)
		sender.setTranslation(CGPoint.zero, in: self.view)
		socketManager.socketChanged(position: SocketPosition(x: viewDrag.center.x, y: viewDrag.center.y))
	}
	
	func didConnect() {
		print("connected")
	}
	
	func didReceive(position: SocketPosition) {
		print("received")
		viewDrag.center = CGPoint(x: position.x, y: position.y)
	}
	
	func didReceive(point: CGPoint) {
		print("received")
		viewDrag.center = point
	}
}

