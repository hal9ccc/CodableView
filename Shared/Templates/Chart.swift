//
//  Chart.swift
//  DeclarativeUI
//
//  Created by Matthias Schulze on 16.11.20.
//  Copyright © 2020 Hacking with Swift. All rights reserved.
//

import Foundation
import SwiftUI
import Shapes
import Charts

struct ChartModel: Decodable {
    let name: String
}

private struct ChartView: View {
    let model: ChartModel

    @State var matrixData: [[CGFloat]] = (0..<20).map { _ in (0..<3).map { _ in CGFloat.random(in: 0.00...0.33) } }
    
    var body: some View {
        Chart(data: matrixData)
            .chartStyle(
                StackedAreaChartStyle(.quadCurve, colors: [.yellow, .orange, .red])
            )
            .background(
                Color.gray.opacity(0.1)
                    .overlay(
                        GridPattern(verticalLines: matrixData.count)
                            .inset(by: 1)
                            .stroke(Color.red.opacity(0.2), style: .init(lineWidth: 1, lineCap: .round))
                    )
            )
            .cornerRadius(16)
            .padding()
    }
}


//struct ChartTemplate: CVElement {
//    let id:    String?
//    let model: ChartModel
//    
//    func render() -> AnyView {
//        ChartView(model: model).toAnyView()
//    }
//}

struct ChartView_Previews: PreviewProvider {
    
    static var previews: some View {
        let matrixData: [[CGFloat]] = (0..<20).map { _ in (0...3).map { _ in CGFloat.random(in: 0.00...0.33) } }

        Chart(data: matrixData)
            .chartStyle(
                //StackedAreaChartStyle(.quadCurve, colors: [.yellow, .orange, .red])
                StackedColumnChartStyle(spacing: 10, colors: [.yellow, .orange, .red])
            )
            .background(
                Color.gray.opacity(0.1)
                    .overlay(
                        GridPattern(verticalLines: matrixData.count )
                            .inset(by: 1)
                            .stroke(Color.red.opacity(0.2), style: .init(lineWidth: 1, lineCap: .round))
                    )
            )
            .cornerRadius(16)
            .padding()
    }
}
