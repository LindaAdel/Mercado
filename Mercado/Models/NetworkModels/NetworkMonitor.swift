//
//  NetworkMonitor.swift
//  Mercado
//
//  Created by Dina ElShabassy on 6/6/21.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor : NWPathMonitor
    
    public private(set) var isConnected : Bool = false{
        didSet{
            NotificationCenter.default.post(name: .internetNotification, object: nil, userInfo:["isConnected":isConnected])
        }
    }
    
    
    public private(set) var connectionType : ConnectionType = .unKnown
    
    enum ConnectionType{
        case wifi
        case cellular
        case ethernet
        case unKnown
    }
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
        
            self?.connectionType = .wifi
            
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring(){
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }
        else if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }
        else{
            connectionType = .unKnown
        }
    }
    
}
