//
//  HideKeyBoard.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 11/05/23.
//

import Foundation
import SwiftUI

//#if canImport(UIKit)
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
//#endif


