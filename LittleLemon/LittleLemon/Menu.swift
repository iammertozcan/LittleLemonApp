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
    @State private var isDataFetched: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                navigationBar
                heroSection
                orderDeliveryText
                menuBreakdown
                fetchedMenuItems
            }
            .onAppear {
                getMenuData()
            }
        }
    }
    
    private var navigationBar: some View {
        HStack {
            Spacer()
            Spacer()
            Image("logo")
            Spacer()
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 50, height: 50)
        }
        .padding(.horizontal)
    }
    
    private var heroSection: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.yellow)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Chicago")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                Image("hero-image")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .cornerRadius(8)
            }
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                TextField("Search Menu", text: $searchText)
                    .padding(0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding()
        .background(Color(red: 73/255, green: 94/255, blue: 87/255))
    }
    
    private var orderDeliveryText: some View {
        HStack {
            Text("ORDER FOR DELIVERY!")
                .font(.system(size: 20, weight: .bold))
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var menuBreakdown: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                categoryButton(title: "Starters")
                categoryButton(title: "Mains")
                categoryButton(title: "Desserts")
                categoryButton(title: "Drinks")
            }
            .padding(.horizontal)
        }
    }
    
    private func categoryButton(title: String) -> some View {
        Button(action: {
            print("\(title)")
        }) {
            Text(title)
                .padding()
                .background(Color(red: 237/255, green: 239/255, blue: 238/255))
                .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                .cornerRadius(30)
        }
    }
    
    private var fetchedMenuItems: some View {
        FetchedObjects(
            predicate: buildPredicate(),
            sortDescriptors: buildSortDescriptors()
        ) { (dishes: [Dish]) in
            List {
                ForEach(dishes) { dish in
                    NavigationLink(destination: DishDetail(dish: dish)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(dish.title ?? "Unknown Title")")
                                    .font(.headline)
                                Text("$\(dish.price ?? "Unknown Price")")
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            if let imageUrl = dish.image, let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 0))
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
        for item in menuItems {
            let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "title == %@", item.title)
            
            do {
                let results = try viewContext.fetch(fetchRequest)
                if results.isEmpty {
                    let dish = Dish(context: viewContext)
                    dish.title = item.title
                    dish.image = item.image
                    dish.price = item.price
                }
            } catch {
                print("Failed to fetch dish: \(error)")
            }
        }
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save data. \(error), \(error.userInfo)")
        }
    }
}

#Preview {
    Menu()
}
