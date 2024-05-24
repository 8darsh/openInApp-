//
//  LinksView.swift
//  openInAppAssignment
//
//  Created by Adarsh Singh on 21/05/24.
//

import SwiftUI
import SafariServices
struct LinksView: View {
    @StateObject private var viewModel = linkViewModel()
    @State private var selectedSegment: Segment = .recentLinks

    enum Segment: String, CaseIterable, Identifiable {
        case recentLinks = "Recent Links"
        case topLinks = "Top Links"
        
        var id: String { self.rawValue }
    }
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
       
        
            }

    var body: some View {
        NavigationView {
            
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    VStack {
                        Picker("Select Data", selection: $selectedSegment) {
                            ForEach(Segment.allCases) { segment in
                                Text(segment.rawValue).tag(segment)
                            }
                        }
                        
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()

                        if selectedSegment == .recentLinks {
                            ListView(links: viewModel.links?.data.recent_links ?? [])
                        } else {
                            ListView(links: viewModel.links?.data.top_links ?? [])
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchLinks()
            }
        }
    }
}

struct ListView: View {
    let links: [Link]

    var body: some View {
        List(links) { link in
            VStack(alignment: .leading){
                HStack(alignment: .top) {
                    VStack{
                        AsyncImage(url: URL(string: link.original_image ?? "nil")){
                            image in
                            image.image?.resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }.frame(width: 50, height: 50)
                        .cornerRadius(8)
                    VStack(alignment: .leading){
                        Text(link.title)
                            .font(.subheadline)
                            .lineLimit(2)
                            
                        Text("\(link.created_at)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            

                    }.padding()
                    
                    VStack {
                        Text("\(link.total_clicks)")
                            .font(.subheadline)
                            
                        Text("Clicks")
                            .font(.caption)

                    }.padding()
                    
                    
                }
                Divider()
                Text(link.web_link)
                    .foregroundStyle(.blue)
                    
                
            }

            
        }
    }
}

extension Link: Identifiable {
    var id: String { web_link }
}

#Preview {
    LinksView()
}
