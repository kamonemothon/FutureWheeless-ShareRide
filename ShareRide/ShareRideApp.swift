import SwiftUI

@main
struct ShareRideApp: App {
	@State private var showMainView = false
	@State private var showModal = false

	var body: some Scene {
		WindowGroup {
			if showMainView {
				NavigationStack {
					NavigationLink {
						TogetherOptionView()
					} label: {
						Image("main")
							.resizable()
							.edgesIgnoringSafeArea(.all)
					}
				}
			} else {
				Image("splash")
					.onAppear {
						DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
							withAnimation {
								showMainView = true
							}
						}
					}
			}
		}
	}
}
