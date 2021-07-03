//
//  ViewController.swift
//  swiftcharts
//
//  Created by Nitesh  on 03/07/21.
//

import UIKit
import Charts

class MainViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "HOME"
        navigationController?.navigationBar.prefersLargeTitles = true
        createBarChart()
    }
    
    func createBarChart() {
        // create bar chart
        let size = view.frame.size.width
        let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        
        
        // configure the axis
        
        
        
//        barChart.xAxis.drawAxisLineEnabled = false
//        barChart.xAxis.drawGridLinesEnabled = false
//
//        barChart.leftAxis.drawAxisLineEnabled = false
//        barChart.leftAxis.drawGridLinesEnabled = false
//
//        barChart.rightAxis.drawAxisLineEnabled = false
//        barChart.rightAxis.drawGridLinesEnabled = false
        
        let xAxis = barChart.xAxis
        xAxis.valueFormatter = IndexAxisValueFormatter(values: ["us", "uk", "spain", "germany", "portugal", "india", "germany", "portugal", "india", "germany", "portugal", "india"])
        xAxis.labelRotationAngle = -25
        xAxis.labelPosition = .bottom
        xAxis.setLabelCount(10, force: false)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        
        let leftYAxis = barChart.leftAxis
        leftYAxis.setLabelCount(6, force: true)
        leftYAxis.axisMinimum = 0
        leftYAxis.axisMaximum = 20
        leftYAxis.drawAxisLineEnabled = false
        leftYAxis.drawGridLinesEnabled = false
        
        let rightYAxis = barChart.rightAxis
        rightYAxis.enabled = false
        rightYAxis.drawGridLinesEnabled = false
        rightYAxis.drawAxisLineEnabled = false
        
        
//        yAxis.accessibilityElementsHidden = true
        
        // configure legend
        let legend = barChart.legend
        legend.direction = .rightToLeft
        
        
        // supply data
        var entriesOne = [BarChartDataEntry]()
        var entriesTwo = [BarChartDataEntry]()
        for x in 0..<10 {
            
            entriesOne.append(
                BarChartDataEntry(
                    x: Double(x),
                    y: Double.random(in: 0...30)
                )
            )
            
            entriesTwo.append(
                BarChartDataEntry(
                    x: Double(x),
                    y: Double.random(in: 0...70)
                )
            )
        }
        let dataSetOne = BarChartDataSet(entries: entriesOne, label: "Data One")
        let dataSetTwo = BarChartDataSet(entries: entriesOne, label: "Data Two")
        
        
        //properties to bar chart
        
//        barChartDataSet.barBorderWidth = 2
//        barChartDataSet.barBorderColor = .label
        

//        dataSetOne.colors = [
//            NSUIColor(cgColor: UIColor.systemRed.cgColor),
//            NSUIColor(cgColor: UIColor.systemGray.cgColor),
//            NSUIColor(cgColor: UIColor.systemGreen.cgColor),
//            NSUIColor(cgColor: UIColor.systemOrange.cgColor),
//            NSUIColor(cgColor: UIColor.systemGreen.cgColor),
//            NSUIColor(cgColor: UIColor.systemBlue.cgColor),
//            NSUIColor(cgColor: UIColor.systemPink.cgColor),
//            NSUIColor(cgColor: UIColor.systemTeal.cgColor)
//        ]
        dataSetOne.colors = ChartColorTemplates.joyful()
//        dataSetTwo.colors = [ChartColorTemplates.joyful()]
        
        let data = BarChartData(dataSet: dataSetOne)
//        let data = BarChartData(dataSets: [dataSetOne, dataSetTwo])
        barChart.data = data
        barChart.delegate = self
//        barChart.animate(xAxisDuration: 2.0)
//        barChart.animate(yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        view.addSubview(barChart)
        view.addSubview(label)
        barChart.center = view.center
        label.anchor(top: nil, left: nil, bottom: barChart.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: size, height: 34)
        
    }
}

extension MainViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        self.label.text = "Value: \(entry.x.description) + \(entry.y.description)"
        print(chartView.drawMarkers)
        print("\(highlight.description) + \(highlight.dataIndex) + \(highlight.dataSetIndex)")
    }
}




// MARK: - UIView Extentions

/// extention for anchoring on button, uiview, tableview, collectionview etc
extension UIView {
    
    /// Autolayout Axis Anchors
    /// - Parameters:
    ///   - top: Top
    ///   - left: Left
    ///   - bottom: Bottom
    ///   - right: Right
    ///   - paddingTop: Padding Top
    ///   - paddingLeft: Padding Left
    ///   - paddingBottom: Padding Bottom
    ///   - paddingRight: Padding Right
    ///   - width: Width
    ///   - height: Height
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
