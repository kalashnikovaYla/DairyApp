//
//  IntegerValueFormatter.swift
//  DairyApp
//
//  Created by sss on 06.05.2023.
//

import Charts

class IntegerValueFormatter: NSObject, ValueFormatter {
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(format: "%.0f", value)
    }
}
