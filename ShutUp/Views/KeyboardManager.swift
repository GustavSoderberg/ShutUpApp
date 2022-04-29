/**
 
 - Description:
 The KeyboardManager provides the values needed for the autoscroll functionality of the keyboard
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import Foundation
import UIKit
import Combine
import SwiftUI

class KeyboardManager: ObservableObject {
    @Published var isVisible = false
    
    
    var keyboardCancellable: Cancellable?
    
    init(){
        keyboardCancellable = NotificationCenter.default
            .publisher(for: UIWindow.keyboardWillShowNotification)
            .sink{[weak self] notification in
                guard let self = self else { return }
                
                guard let userInfo = notification.userInfo else {return}
                guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                
                self.isVisible = keyboardFrame.minY < UIScreen.main.bounds.height
                    
                    
            }
        
    }
    
    
}
