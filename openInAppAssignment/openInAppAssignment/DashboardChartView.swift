//
//  DashboardChartView.swift
//  openInAppAssignment
//
//  Created by Adarsh Singh on 21/05/24.
//

import SwiftUI
import Charts
struct DashboardChartView: View {
    @StateObject private var viewModel = linkViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                if viewModel.isLoading{
                    ProgressView("Loading...")
                }else if let errorMessage = viewModel.errorMessage{
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }else{
                    if let data = viewModel.links?.data.overall_url_chart{
                        LinkChartView(data: data)
                            .frame(height: 150)
                            .padding()
                            
                    }else{
                        Text("No data available.")
                    }
                }
            }
            .onAppear{
                viewModel.fetchLinks()
            }
        }
    }
}

struct LinkChartView: View {
    let data: [String:Int]
    var body: some View {
        Chart{
            ForEach(data.sorted(by: <), id: \.key){
                hour , clicks in
                LineMark(x: .value("Hour", hour), y: .value("Clicks", clicks))
                    .annotation(position: .top) {
                        Text("\(clicks)")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
            }
        }
        
    }
}
#Preview {
    DashboardChartView()
}
