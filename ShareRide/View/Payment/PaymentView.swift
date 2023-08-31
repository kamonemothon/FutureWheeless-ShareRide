//
//  PaymentView.swift
//  ShareRide
//
//  Created by 김예림 on 2023/09/01.
//

import Foundation
import SwiftUI

struct PaymentOneView: View {
    var body: some View {
        NavigationLink {
            PaymentTwoView()
                .navigationBarBackButtonHidden()
        } label: {
            Image("1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        }
    }
}

struct PaymentTwoView: View {
    var body: some View {
        NavigationLink {
            PaymentThreeView()
                .navigationBarBackButtonHidden()
        } label: {
            Image("2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        }
    }
}

struct PaymentThreeView: View {
    var body: some View {
        NavigationLink {
            PaymentFourView()
                .navigationBarBackButtonHidden()
        } label: {
            Image("3")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        }
    }
}

struct PaymentFourView: View {
    var body: some View {
        NavigationLink {
            PaymentFiveView()
                .navigationBarBackButtonHidden()
        } label: {
            Image("4")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        }
    }
}

struct PaymentFiveView: View {
    var body: some View {
        NavigationLink {
            PaymentSixView()
                .navigationBarBackButtonHidden()
        } label: {
            Image("5")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        }
    }
}

struct PaymentSixView: View {
    var body: some View {
        NavigationLink {
            PaymentSevenView()
                .navigationBarBackButtonHidden()
        } label: {
            Image("6")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        }
    }
}

struct PaymentSevenView: View {
    var body: some View {
        Image("7")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}
