//
//  ContentView.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/27/21.
//

import SwiftUI

struct WelcomeScreen: View {
	var content:[[String:String]] =
	[
		[
			"title" : "Welcome",
			"detail" : "To the world's largest anime & manga database and community.",
			"image1" :  "welcome2",
			"image2" : "welcome3",
			"image3" : "welcome4"
		],[
			"title" : "Stay up to Date",
			"detail" : "Discover the latest from Japan.",
			"image1" :  "welcome6",
			"image2" : "welcome8",
			"image3" : "welcome5"
		],[
			"title" : "Create your list",
			"detail" : "Use your list to organize and track what titles you've completed, your current progress, what you plan to watch or read and so much more.",
			"image1" :  "welcome10",
			"image2" : "welcome11",
			"image3" : "welcome13"
		]
	]
	@State var index:Int = 0
	@State var isNavigationLinkHidden:Bool = true
	var body: some View {
		NavigationView {
			
			ZStack {
				Color("blue1")
					.ignoresSafeArea()
				GeometryReader { proxy in
					let width = proxy.size.width
					let height = proxy.size.height
					VStack{ // main Vstack
						Spacer()
						VStack{ // For the grid
							HStack{
								Image(content[index]["image1"] ?? "welcome1")
									.resizable()
									.aspectRatio(contentMode: .fill)
									.frame(width: 150, height: height / 3.5)
									.cornerRadius(15)
								
								Image(content[index]["image2"] ?? "welcome1")
									.resizable()
									.aspectRatio(contentMode: .fill)
									.frame(width: 150, height: height / 3.5)
									.cornerRadius(15)
							}
							//						Spacer()
							Image(content[index]["image3"] ?? "welcome1")
								.resizable()
								.aspectRatio(contentMode: .fill)
								.frame(width: 300, height: height / 4)
								.cornerRadius(20)
						} // end of the grid
						Spacer()
						VStack { // bottom card
							Text(content[index]["title"]!)
								.font(.largeTitle)
								.foregroundColor(Color("dark"))
								.frame(width: width, height: height / 10, alignment: .leading)
								.fixedSize(horizontal: false, vertical: true)
								.padding( .leading)
							Text(content[index]["detail"]!)
								.foregroundColor(Color("dark"))
								.frame(width: width, height: height / 9, alignment: .leading)
								.fixedSize(horizontal: false, vertical: true)
								.padding(.leading)
							
							HStack {
								ProgressView(value: Double(index) + 1, total: 3)
									.progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
									.padding(.horizontal, 50)
								
								if !isNavigationLinkHidden {
									NavigationLink(destination: LoginScreen().navigationBarBackButtonHidden(true)) {
										Image(systemName: "arrow.right")
									}.padding(.trailing)
								} else {
									Button(action: {
										index += 1
										if index >= content.count - 1{
											isNavigationLinkHidden.toggle()
										}
									}) {
										Image(systemName: "arrow.right")
									}.padding(.trailing)
								}

							}
							
							.frame(width: width, height: height / 20, alignment: .center)
							Spacer()
						}
						.frame(width: width, height: height / 3, alignment: .bottom)
						.background(RoundedCorners(tl: 35, tr: 35, bl: 0, br: 0)
										.fill(Color.white).edgesIgnoringSafeArea(.bottom))
						
					}
				} // geom reader
				
			}
			.navigationBarTitle("")
			.navigationBarHidden(true)
			.navigationBarBackButtonHidden(true)
		}
		
		
	}
}


struct RoundedCorners: Shape {
	var tl: CGFloat = 0.0
	var tr: CGFloat = 0.0
	var bl: CGFloat = 0.0
	var br: CGFloat = 0.0
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
		
		let w = rect.size.width
		let h = rect.size.height
		
		// Make sure we do not exceed the size of the rectangle
		let tr = min(min(self.tr, h/2), w/2)
		let tl = min(min(self.tl, h/2), w/2)
		let bl = min(min(self.bl, h/2), w/2)
		let br = min(min(self.br, h/2), w/2)
		
		path.move(to: CGPoint(x: w / 2.0, y: 0))
		path.addLine(to: CGPoint(x: w - tr, y: 0))
		path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
					startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
		
		path.addLine(to: CGPoint(x: w, y: h - br))
		path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
					startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
		
		path.addLine(to: CGPoint(x: bl, y: h))
		path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
					startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
		
		path.addLine(to: CGPoint(x: 0, y: tl))
		path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
					startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
		path.closeSubpath()
		
		return path
	}
}








struct WelcomeScreen_Previews: PreviewProvider {
	static var previews: some View {
		let _ = [
			"iPhone 13 Pro Max",
			"iPhone 13",
			"iPhone 13 mini",
			"iPhone SE 2nd gen","iPhone SE",
			"iPhone 11 Pro Max",
			"iPhone 11 Pro",
			"iPhone 11",
			"iPhone 8 Plus",
			"iPhone SE 1st gen",
			"iPhone 4S"
		]
		WelcomeScreen()
			.previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
			.previewDisplayName("iPhone 8 Plus")
	}
}


