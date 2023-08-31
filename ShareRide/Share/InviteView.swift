//
//  InviteView.swift
//  ShareRide
//
//  Created by OLING on 2023/08/26.
//

import SwiftUI

struct InviteView: View {
	@State var isSelected = false
	@State var myProfileIstoggle: Bool = false
	@State var text: String = ""
	
	@State var selectedArr = [false, false, false]
	
	@Binding var showModal: Bool
	@Binding var isModalPresented: Bool
	
	var body: some View{
		VStack {
			TopbarView()
			InfoTextfield()
			InfoCellView()
		}
		.navigationBarBackButtonHidden(true)
	}
}

private extension InviteView {
	@ViewBuilder
	func TopbarView() -> some View {
		HStack{
			Button {
				
			} label: {
				Image(systemName: "xmark")
					.font(Font.system(size: 20))
					.foregroundColor(.black)
			}
			Spacer()
			Text("동승자 선택")
				.foregroundColor(.black)
				.bold()
				.font(.system(size: 20))
			
			Spacer()
			
			Button {
				showModal = false
				isModalPresented = true
			} label: {
				Text("다음")
					.foregroundColor(.black)
					.font(.system(size: 16))
			}
		}
		.padding()
	}
	
	@ViewBuilder
	func InfoTextfield() -> some View {
		TextField("이름(초성), 전화번호 검색", text: $text)
			.padding()
			.frame(width: 356, height: 36)
			.font(.system(size: 16))
			.background(
				RoundedRectangle(cornerRadius: 4)
					.fill(Color(red: 0.96, green: 0.96, blue: 0.96))
			)
			.padding(12)
	}
	
	@ViewBuilder
	func InfoCellView() -> some View {
		ScrollView{
			VStack(spacing:0) {
				MyProfile()
				Rectangle()
					.frame(width: 356, height: 0.3)
					.foregroundColor(Color(red: 0.88, green: 0.88, blue: 0.88))
					.padding()
				FriendProfile()
				InfoCell()
			}
		}
	}
	
	@ViewBuilder
	func MyProfile() -> some View {
		VStack{
			HStack{
				Text("내 프로필")
					.foregroundColor(.black)
					.font(.system(size: 12))
				Spacer()
			}
			.padding(.horizontal)
			
			HStack{
				Image(mockSameStartInitUsers.first!.userImage)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 40, height: 40)
					.clipShape(Circle())
				Text(mockSameStartInitUsers.first!.userName)
					.foregroundColor(.black)
					.padding(.leading, 5)
				Spacer()
				Button {
					myProfileIstoggle.toggle()
				} label: {
					Circle()
						.frame(width: 20, height: 20)
						.foregroundColor(myProfileIstoggle ? Color.blue : .clear)
						.overlay(
							Circle()
								.stroke(Color(red: 0.86, green: 0.86, blue: 0.86), lineWidth: 2)
						)
				}
			}
			.padding(.horizontal)
			.padding(.vertical, 7)
		}
	}
	
	@ViewBuilder
	func FriendProfile() -> some View {
		HStack{
			Text("친구")
				.foregroundColor(.black)
				.font(.system(size: 12))
			Spacer()
		}
		.padding(.horizontal)
		.padding(.bottom, 4)
	}
	
	@ViewBuilder
	func InfoCell() -> some View {
		ForEach(mockDestinationList.indices, id: \.self) { index in
			HStack{
				let user = mockDestinationList[index]
				Image(user.userImage)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 40, height: 40)
					.clipShape(Circle())
				Text(user.userName)
					.foregroundColor(.black)
					.padding(.leading, 5)
				Spacer()
				Button {
					selectedArr[index].toggle()
				} label: {
					Circle()
						.frame(width: 20, height: 20)
						.foregroundColor(selectedArr[index] ? Color.blue : .clear)
						.overlay(
							Circle()
								.stroke(Color(red: 0.86, green: 0.86, blue: 0.86), lineWidth: 2)
						)
				}
			}
			.padding(.horizontal)
			.padding(.vertical, 7)
			
		}
	}
}
