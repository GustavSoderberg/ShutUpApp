//
//  NetworkManager.swift
//  ShutUp
//
//  Created by Calle Höglund on 2022-04-25.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected: Bool?
    
    init(){
        
        monitor.pathUpdateHandler = { path in
            
            
            if path.status != .satisfied{
                print("not connected")
                self.isConnected = false
            }
//            else if path.usesInterfaceType(.cellular){
//                print("3/4/5g internet")
//            }
//            else if path.usesInterfaceType(.wifi){
//                print("wifi internet")
//            }
//            else if path.usesInterfaceType(.wiredEthernet){
//                print("wired internet")
//            }
                
            if path.status == .satisfied{
                print("net u have")
                self.isConnected = true
            }
            
            
        }
        
        monitor.start(queue: queue)
    }
    
    
}

