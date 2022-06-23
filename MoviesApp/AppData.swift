//
//  AppData.swift
//  MoviesApp
//
//  Created by Saikiran Panuganti on 23/06/22.
//

import Foundation

class AppData {
    static var shared: AppData = AppData()
    
    private init() {
        
    }
    
    var menuData: [Menu] = []
    var homeData: [Playlist] = []
    var allHomeData: [String: HomeData] = [:]
}
