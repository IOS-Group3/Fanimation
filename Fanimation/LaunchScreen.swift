//
//  LaunchScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/31/21.
//

import SwiftUI

struct LaunchScreen: View {
	@State var showMainView: Bool = false
	@State var bowAnimation: Bool = false
    var body: some View {
		ZStack {
			Color("blue1").edgesIgnoringSafeArea(.all)
			GeometryReader { proxy in
				let size = proxy.size
				
				ZStack{
					HStack (alignment: .bottom, spacing : -100){
						Image("playstore")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: size.width / 1.9, height: size.width / 1.9)
						Text("animation")
							.font(.title)
							.fontWeight(.heavy)
							.foregroundColor(.white)
							.multilineTextAlignment(.leading)
							.frame(width: size.width / 1.9, height: size.width / 1.9)
					}
				}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				Circle()
					.trim(from: 0, to: bowAnimation ? 0.6 : 0)
					.stroke(
						.linearGradient(.init(colors: [
							Color("light"),
							Color("blue3"),
							Color("blue3"),
							Color("blue3"),
							Color("blue2"),
							Color("blue2"),
							Color("blue1"),
							Color("blue1"),
							Color("blue1"),
//							Color("dark")
							
						]), startPoint: .leading, endPoint: .trailing),
						style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)
					)
					.frame(width: size.width / 1.5, height: size.width / 1.5)
					.rotationEffect(.init(degrees: -200))
					.offset(x : 75, y:220)
			}
			
		}.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
				withAnimation(.linear(duration: 1)) {
					bowAnimation.toggle()
				}
			}
		}
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
