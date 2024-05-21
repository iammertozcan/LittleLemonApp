//
//  DishDetail.swift
//  LittleLemon
//
//  Created by Mert Özcan on 21.05.2024.
//

import SwiftUI

struct DishDetail: View {
    let dish: Dish
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(dish.title ?? "Unknown Title")
                .font(.largeTitle)
                .padding()
            
            if let imageUrl = dish.image, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                    default:
                        ProgressView()
                    }
                }
                .frame(width: 200, height: 200)
            }
            
            Text("Price: \(dish.price ?? "Unknown Price")")
                .font(.title)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Dish Details")
    }
}

struct DishDetail_Previews: PreviewProvider {
    static var previews: some View {
        let dish = Dish(context: PersistenceController.preview.container.viewContext)
        dish.title = "Greek Salad"
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        dish.price = "$10.00"
        
        return DishDetail(dish: dish)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
