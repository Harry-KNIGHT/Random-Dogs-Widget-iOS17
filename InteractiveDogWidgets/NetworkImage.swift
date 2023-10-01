//
//  NetworkImage.swift
//  InteractiveDogWidgetsExtension
//
//  Created by Elliot Knight on 30/09/2023.
//

import SwiftUI

struct NetworkImage: View {
	let url: URL?
	var body: some View {
		Group {
			if let url = url, let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
				Image(uiImage: uiImage)
					.resizable()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
			else {
				Text("Ça marche pas")
			}
		}
	}
}
