//
//  KeyboardManager.swift
//  ShutUp
//
//  Created by Calle Höglund on 2022-04-13.
//

import Foundation
import UIKit
import Combine
import SwiftUI

class KeyboardManager: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    @Published var isVisible = false
    @Published var topFrame: CGFloat?
    
    
    var keyboardCancellable: Cancellable?
    
    init(){
        keyboardCancellable = NotificationCenter.default
            .publisher(for: UIWindow.keyboardWillShowNotification)
            .sink{[weak self] notification in
                guard let self = self else { return }
                
                guard let userInfo = notification.userInfo else {return}
                guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                
                self.topFrame = keyboardFrame.maxY
                
                
                
                self.isVisible = keyboardFrame.minY < UIScreen.main.bounds.height
                    
                    
                self.keyboardHeight = self.isVisible ? keyboardFrame.height : 0
                    
                
                
            }
        
        
        
    }
    
    
}
