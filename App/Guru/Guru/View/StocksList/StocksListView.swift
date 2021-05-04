//
//  StocksListView.swift
//  Guru
//
//  Created by Rafael Adolfo  on 03/05/21.
//

import SwiftUI

struct StocksListView: View {
    @StateObject var viewModel = CryptoStocksViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizationUtil.String.myList)
                .padding(.leading, 15)
                .padding(.top, -30)
                .font(.system(size: 35).bold())
            ZStack {
                switch viewModel.state {
                case .idle:
                    Color.clear.onAppear(perform: viewModel.fetchCryptoStocks)
                case .loading:
                    Color.clear
                case .failed(let error):
                    ErrorView(errorMessage: error)
                case .loaded:
                    ScrollView {
                        LazyVStack {
                            ForEach(0..<viewModel.model.count, id:\.self) { index in
                                StockItem(model: $viewModel.model[index])
                            }
                        }
                    }
                    .onReceive(viewModel.timer, perform: { _ in
                        viewModel.fetchCryptoStocks()
                    })
                    Spacer()
                }
            }
        }
    }
}

struct StockItem: View {
    @Binding var model: CryptoStock
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(alignment: .top) {
            WebImage(url: model.iconUrl)
                .clipShape(Circle())
                .frame(width: 40, height: 40)
                .padding(.top, 15)

            VStack(alignment: .leading) {
                Text(model.symbol)
                Text(model.name)
                    .font(.system(size: 10))
            }
            .padding(15)
            Spacer()
            VStack(alignment: .trailing) {
                Text(String(format: "%.02f", locale: Locale.current, model.price))
                Text(String(format: model.percentageOneHour < 0 ? "%.02f" : "+%.02f", model.percentageOneHour) + "%")
                    .font(.system(size: 14))
                    .foregroundColor(model.percentageOneHour < 0 ? .red : .green)
            }
            .padding(15)
        }
        .frame(width: UIScreen.main.bounds.width - 40)
        .padding(.top, 2)
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .background(Color(colorScheme == .dark ? .secondarySystemBackground : .systemBackground))
        .cornerRadius(5)
        .shadow(color: colorScheme == .dark ? .clear : Color(.systemGray4),radius: 2, x: 0, y:2)

    }
}
