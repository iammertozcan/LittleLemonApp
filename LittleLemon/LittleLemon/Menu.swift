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
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Little Lemon")
                    .font(.largeTitle)
                    .padding()
                Text("Chicago")
                    .font(.title)
                    .padding()
                Text("We are family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .multilineTextAlignment(.center)
                    .padding()
                
                TextField("Search menu", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()
                ) { (dishes: [Dish]) in
                    List {
                        ForEach(dishes) { dish in
                            NavigationLink(destination: DishDetail(dish: dish)) {
                                HStack {
                                    Text("\(dish.title ?? "Unknown Title") - \(dish.price ?? "Unknown Price")")
                                    if let imageUrl = dish.image, let url = URL(string: imageUrl) {
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(5)
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
            }
            .onAppear {
                getMenuData()
            }
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    func getMenuData() {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(MenuList.self, from: data)
                    DispatchQueue.main.async {
                        PersistenceController.shared.clear()
                        saveToCoreData(menuItems: decodedData.menu)
                    }
                } catch {
                    print("JSON Decoding error: \(error)")
                }
            } else {
                if let error = error {
                    print("Network error: \(error.localizedDescription)")
                } else {
                    print("Unknown error")
                }
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
