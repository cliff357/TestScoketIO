//
//  SocketTutorialManager.swift
//  TestSocketIO
//
//  Created by Cliff Chan on 25/11/2021.
//

import Foundation

import UIKit
import SocketIO

class SocketTutorialManager {

	// MARK: - Delegate
	weak var delegate: SocketPositionManagerDelegate?

	// MARK: - Properties
	let manager = SocketManager(socketURL: URL(string: "http://localhost:3000/")!, config: [.log(false), .compress])
	var socket: SocketIOClient? = nil

	// MARK: - Life Cycle
	init() {
	}

	func start(){
		setupSocket()
		setupSocketEvents()
		socket?.connect()
	}
	func stop() {
		socket?.removeAllHandlers()
	}

	// MARK: - Socket Setups
	func setupSocket() {
		self.socket = manager.defaultSocket
	}

	
	func setupSocketEvents() {

		socket?.on(clientEvent: .connect) {data, ack in
			self.delegate?.didConnect()
		}

		socket?.on("drawing") { (data, ack) in
			print("drawing")
			guard let dataInfo = data.first else { return }
			if let response: SocketPosition = try? SocketParser.convert(data: dataInfo) {
				let position = CGPoint.init(x: response.x, y: response.y)
				self.delegate?.didReceive(point: position)
//				self.delegate?.didReceive(position: position)
			}
		}

	}

	// MARK: - Socket Emits
	func socketChanged(position: SocketPosition) {
		let info: [String : Any] = [
			"x": Double(position.x),
			"y": Double(position.y)
		]
		socket?.emit("drawing", info)
	}

}
