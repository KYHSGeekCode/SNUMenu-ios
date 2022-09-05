//
//  ContentView.swift
//  snu restaurant
//
//  Created by 양현서 on 2022/09/05.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject private var viewModel = MainViewModel(
        restaurantRepository: RestaurantRepository(
            networkRestaurantDataSource: NetworkRestaurantDataSource(),
            localRestaurantDataSource: LocalRestaurantDataSource()
        )
    )

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.menus, id: \.self) { menu in
                    NavigationLink {
                        Text(menu.breakfast ?? "아침 없음")
                        Text(menu.lunch ?? "점심 없음")
                        Text(menu.dinner ?? "저녁 없음")
                    } label: {
                        Text("\(menu.restaurant)")
                    }
                }
            }
                .navigationBarItems(
                leading: Button(action: {
                    viewModel.yesterday()
                }, label: {
                    Image(systemName: "arrow.left")
                }),
                trailing: Button(action: {
                    viewModel.tomorrow()
                }, label: {
                    Image(systemName: "arrow.right")
                })
            )
                .navigationTitle("\(viewModel.date, formatter: DateFormatter.day)")
        }.onAppear {
            viewModel.refreshData()
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension DateFormatter {
    static let day: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}