//
//  linkModel.swift
//  openInAppAssignment
//
//  Created by Adarsh Singh on 21/05/24.
//

import Foundation

struct linkModel: Decodable {
    let data: DashboardData
}

struct DashboardData: Decodable {
    let recent_links: [Link]
    let top_links: [Link]
    let overall_url_chart: [String: Int]
}

struct Link: Decodable {
    let web_link: String
    let title: String
    let total_clicks: Int
    let created_at: String
    let original_image: String?
}



