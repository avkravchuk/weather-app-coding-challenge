//
//  NetworkErrorView.swift
//  weather app
//
//  Created by Aleksey Krauchuk on 19/08/2024.
//

import SwiftUI

struct NetworkErrorView: View {
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: "wifi.slash")
                .foregroundStyle(.red)
            Text("Network connection seems to be offline.\nPlease check your connection.")
                .multilineTextAlignment(.center)
                .font(.footnote)
        }
    }
}

#Preview {
    NetworkErrorView()
}
