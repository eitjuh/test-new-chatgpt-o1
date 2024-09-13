//
//  ContentView.swift
//  test-new-chatgpt-o1
//
//  Created by Jesse Eilers on 13/09/2024.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        SpriteView(scene: GameScene(size: UIScreen.main.bounds.size))
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
