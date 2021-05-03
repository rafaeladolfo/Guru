//
//  StocksListView.swift
//  Guru
//
//  Created by Rafael Adolfo  on 03/05/21.
//

import SwiftUI

struct StocksListView: View {

    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizationUtil.String.myList)
                .padding(.leading, 15)
                .padding(.top, -30)
                .font(.system(size: 35).bold())
            ScrollView {
                LazyVStack {
                    StockItem()
                    StockItem()
                }

            }
            Spacer()
        }
    }
}

struct StockItem: View {

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("MXRF11")
                Text("Maxi Renda")
                    .font(.system(size: 10))
            }
            .padding(15)
            Spacer()
            VStack(alignment: .trailing) {
                Text("10,51")
                Text("-0,57%")
                    .font(.system(size: 14))
                    .foregroundColor(.red)
            }
            .padding(15)
        }
        .frame(minWidth: UIScreen.main.bounds.width - 60)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 0.1)
                .frame(minWidth: UIScreen.main.bounds.width - 60)
                .frame(minHeight: 40)
                .shadow(color: .primary, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10, y: 10)
        )
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }
}
