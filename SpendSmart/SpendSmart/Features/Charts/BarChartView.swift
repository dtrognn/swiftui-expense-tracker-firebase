//
//  BarChartView.swift
//  SpendSmart
//
//  Created by dtrognn on 09/04/2024.
//

import Charts
import SwiftUI

struct BarChartConfiguration {
    let data: [ChartData]
    let height: CGFloat
}

struct BarChartView: View {
    private var configuration: BarChartConfiguration

    init(configuration: BarChartConfiguration) {
        self.configuration = configuration
    }

    var body: some View {
        Chart {
            ForEach(configuration.data) { dataPoint in
                BarMark(x: .value(language("Chart_A_01"), dataPoint.type.name),
                        y: .value(language("Chart_A_02"), dataPoint.count))
                    .foregroundStyle(dataPoint.type.getColor().color)
                    .foregroundStyle(by: .value("Type", dataPoint.type.name))
                    .annotation {
                        Text(String(format: "%.0f", dataPoint.count))
                            .font(AppStyle.font.regular12)
                            .foregroundColor(dataPoint.type.getColor().color)
                    }
            }
        }.aspectRatio(1, contentMode: .fit)
    }
}
