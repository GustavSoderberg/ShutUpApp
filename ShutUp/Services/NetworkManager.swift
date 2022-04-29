/**
 
 - Description:
 The Network Manager determines if the user is connected to the internet or not and updates a bool accordingly
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

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
            
            if path.status == .satisfied{
                print("net u have")
                
                self.isConnected = true
            }
            
            
        }
        
        monitor.start(queue: queue)
    }
    
    
}

