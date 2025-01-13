// create by Emre ORHAN

import SwiftUI

struct SavedListView: View {
    @Binding var savedEntries: [BirthdayEntry]
    
    func daysUntil(_ date: Date) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let nextBirthday = calendar.nextDate(after: now, matching: calendar.dateComponents([.month, .day], from: date), matchingPolicy: .nextTimePreservingSmallerComponents) ?? date
        return calendar.dateComponents([.day], from: now, to: nextBirthday).day ?? 0
    }
    
    var body: some View {
        NavigationView {
            List(savedEntries) { entry in
                VStack(alignment: .leading) {
                    Text(entry.name)
                        .font(.headline)
                    Text(entry.gender == "Kadın" ? "Doğum günü kızı" : "Doğum günü çocuğu")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        Text(entry.date, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        Spacer()
                        Text("\(daysUntil(entry.date)) gün kaldı")
                            .font(.subheadline)
                            .foregroundColor(.green)
                    
                    }

                    }
                }
                .navigationTitle("Doğum Günleri")
            }
        }
    }
    

