//
//  ShowContactInfo.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 02/06/23.
//

import Foundation
import SwiftUI

struct Description: View {
    var title: String = ""
    var info: String = ""
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 5)
                .padding(.top, 10)
            
            Text(info)
                .font(.system(size: 17, weight: .regular))
                .padding(.leading, 5)
        }
    }
}
