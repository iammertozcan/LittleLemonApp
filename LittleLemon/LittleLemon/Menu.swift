//
//  Menu.swift
//  LittleLemon
//
//  Created by Mert Özcan on 20.05.2024.
//

import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var menuItems: [MenuItem] = []
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            
            FetchedObjects(fetchRequest: dishes) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            Text("\(dish.title) - \(dish.price)")
                                .font(.headline)
                            if let url = URL(string: dish.image) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                    default:
                                        ProgressView()
                                    }
                                }
                                .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        clearDatabase()
        
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
    
    func saveToCoreData(menuItems: [MenuItem]) {
        clearDatabase()
        for item in menuItems {
            let dish = Dish(context: viewContext)
            dish.title = item.title
            dish.image = item.image
            dish.price = item.price
        }
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save data. \(error), \(error.userInfo)")
        }
    }
    
    func clearDatabase() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Dish.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch {
            print("Failed to clear database: \(error)")
        }
    }
    
}

#Preview {
    Menu()
}
