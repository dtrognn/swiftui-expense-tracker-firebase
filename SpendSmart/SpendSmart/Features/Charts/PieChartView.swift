//
//  PieChartView.swift
//  SpendSmart
//
//  Created by dtrognn on 11/04/2024.
//

import Charts
import SwiftUI

struct PieChartConfiguration {
    let datas: [ChartData]
}

class PieChartVM: BaseViewModel {
    private let datas: [ChartData]
    private(set) var selectedData: ChartData?

    @Published var rawSelection: Double?
    var title: String {
        guard let selectedData else { return "Chon category" }
        return selectedData.type.name
    }

    init(_ datas: [ChartData]) {
        self.datas = datas
    }

    func isSelected(_ data: ChartData) -> Bool {
        return data == selectedData
    }

    func updateDataSelected() {
        guard let rawSelection else { return }
        let data = selectedData(for: rawSelection)
        guard data != selectedData else { return }
        selectedData = data
    }

    private func selectedData(for value: Double) -> ChartData {
        var total = 0.0
        for element in datas {
            total += element.count
            if value <= total {
                return element
            }
        }
        return datas.last!
    }
}

struct PieChartView: View {
    @StateObject private var vm: PieChartVM
    private var configuration: PieChartConfiguration

    init(_ configuration: PieChartConfiguration) {
        self.configuration = configuration
        self._vm = StateObject(wrappedValue: PieChartVM(configuration.datas))
    }

    var body: some View {
        Chart(configuration.datas) { dataPoint in
            let isSelected = vm.isSelected(dataPoint)

            SectorMark(
                angle: .value(dataPoint.type.name, dataPoint.count),
                innerRadius: .ratio(0.5),
                outerRadius: .ratio(isSelected ? 1 : 0.9),
                angularInset: 2.0
            ).cornerRadius(5)
                .foregroundStyle(by: .value("Type", dataPoint.type.name))
                .opacity(isSelected ? 1 : 0.8)
        }.chartAngleSelection(value: $vm.rawSelection)
            .chartBackground { chartProxy in
                GeometryReader { proxy in
                    let frame = proxy[chartProxy.plotAreaFrame]
                    getAnotationView().position(x: frame.midX, y: frame.midY)
                }
            }
            .frame(maxWidth: 300)
            .aspectRatio(1, contentMode: .fit)
            .onChange(of: vm.rawSelection, vm.updateDataSelected)
            .animation(.bouncy, value: vm.selectedData)
    }
}

private extension PieChartView {
    @ViewBuilder
    func getAnotationView() -> some View {
        if let dataSelected = vm.selectedData {
            VStack(spacing: AppStyle.layout.mediumSpace) {
                Text(dataSelected.type.name)
                    .font(AppStyle.font.semibold14)
                    .foregroundColor(AppStyle.theme.textNormalColor)

                Text(String(format: "%.1f", dataSelected.count))
                    .font(AppStyle.font.semibold14)
                    .foregroundColor(AppStyle.theme.textNormalColor)
            }.asAnyView
        } else {
            Text(language("Chart_A_06"))
                .font(AppStyle.font.regular14)
                .foregroundColor(AppStyle.theme.textNormalColor)
                .asAnyView
        }
    }
}
