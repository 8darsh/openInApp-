//
//  appView.swift
//  openInAppAssignment
//
//  Created by Adarsh Singh on 20/05/24.
//

import SwiftUI

struct appView: View {
    init(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBlue
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // Optional: Set large title text color

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    @State private var greeting:String = ""
    var body: some View {
        
        NavigationStack{
            ScrollView{
                VStack{
                    Section{
                        Text(greeting)
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.gray)
                            .bold()
                            .padding(.leading)
                            .padding(.top)
                        Text("Adarsh Singh 👋")
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                            .padding(.leading)
                            .padding(.bottom)
                    }
                    Section{
                        DashboardChartView()
                    }
                    Section{
                        LinksView()
                    }
                    
                }
                .onAppear{
                    updateGreeting()
                }
            }
            
        }.navigationTitle("Dashboard")
            
            
    }
    
    func updateGreeting(){
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour{
        case 5..<12:
            greeting = "Good Morning"
        case 12..<17:
            greeting = "Good Afternoon"
        case 17..<21:
            greeting = "Good Evening"
        default:
            greeting = "Good Night"
        }

        
    }
}

#Preview {
    NavigationStack{
        appView()
    }
}
