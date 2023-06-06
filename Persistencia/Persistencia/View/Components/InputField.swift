//
//  TextField.swift
//  Persistencia
//
//  Created by Paulo Uchôa on 31/05/23.
//

import Foundation
import SwiftUI
import Combine

struct InputView: View {
    
    @Binding var text: String
    
    var title: String
    var placeholder: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .medium))
                
                    .padding(.vertical, 10)
                    .padding(.leading, 20)
                Spacer()
            }
            HStack {
                TextField(placeholder, text: $text)
                
                    .onReceive(Just(text)) { _ in if text.count > 30 {
                        text = String(text.prefix(30))
                    }}
                    .padding(.leading, 7)
                    .padding(.horizontal, 5)
                    .background(Color(red: 0, green: 0, blue: 0, opacity: 0.1))
                    .cornerRadius(20)
            }.padding(.horizontal, 20)
        }
    }
}
