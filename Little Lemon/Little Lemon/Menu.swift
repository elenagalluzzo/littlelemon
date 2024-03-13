//
//  Menu.swift
//  Little Lemon
//
//  Created by Elena Galluzzo on 2024-03-12.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("""
                "We are a family owned
                 Mediterranean restaurant,
                 focused on traditional
                 recipes served with a
                 modern twist.
                """)
            TextField("Search menu", text: $searchText)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id:\.self) { dish in
                        HStack {
                            Text((dish.title ?? "") + " $" + (String(format: "%.2f", dish.price ?? "")))
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
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
        PersistenceController.shared.clear()
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let menuList = try? decoder.decode(MenuList.self, from: data) {
                    for item in menuList.menu {
                        let newDish = Dish(context: viewContext)
                        newDish.title = item.title
                        newDish.image = item.image
                        newDish.price = item.price
                    }
                    try? viewContext.save()
                }
            }
        }
        task.resume()
        
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText == "" {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}

#Preview {
    Menu()
}
