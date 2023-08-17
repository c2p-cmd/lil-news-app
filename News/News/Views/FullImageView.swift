//
//  FullImageView.swift
//  News
//
//  Created by Sharan Thakur on 17/08/23.
//

import SwiftUI

struct FullImageView<I: View>: View {
    var image: () -> I
    var buttonCloseAction: () -> Void
    
    var body: some View {
        image()
        .navigationBarBackButtonHidden(false)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close", action: self.buttonCloseAction)
            }
        }
    }
}
