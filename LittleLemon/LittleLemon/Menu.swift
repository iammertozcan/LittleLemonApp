//
//  Menu.swift
//  LittleLemon
//
//  Created by Mert Özcan on 20.05.2024.
//

import SwiftUI

struct Menu: View {
    @State private var menuItems: [MenuItem] = []
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            
            List {
                
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(MenuList.self, from: data)
                DispatchQueue.main.async {
                    self.menuItems = decodedData.menu
                }
            } catch {
                print("JSON Decoding error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
}

#Preview {
    Menu()
}
