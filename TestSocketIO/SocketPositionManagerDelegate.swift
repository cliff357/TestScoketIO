//
//  SocketPositionManagerDelegate.swift
//  TestSocketIO
//
//  Created by Cliff Chan on 25/11/2021.
//

import Foundation
import UIKit

protocol SocketPositionManagerDelegate: class {
	func didConnect()
	func didReceive(position: SocketPosition)
	func didReceive(point: CGPoint)
}
