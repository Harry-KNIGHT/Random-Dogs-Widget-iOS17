//
//  InteractiveDogWidgets.swift
//  InteractiveDogWidgets
//
//  Created by Elliot Knight on 30/09/2023.
//

import WidgetKit
import SwiftUI
import API
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
		SimpleEntry(date: Date(), emoji: "😀", dog: .init(imageUrl: ""))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀", dog: .init(imageUrl: ""))
        completion(entry)
    }

	@MainActor
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {

			Task {
				do {
					let dog = try await DogServiceDefault().fetchRandomDog()
					let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
					let entry = SimpleEntry(date: entryDate, emoji: "😀", dog: dog)
					entries.append(entry)
					
					let timeline = Timeline(entries: entries, policy: .atEnd)
					completion(timeline)
				} catch {
					throw error
				}
			}
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
	let dog: DogData
}

struct InteractiveDogWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
		ZStack {
			NetworkImage(url: URL(string: entry.dog.imageUrl))
			Button(intent: DogSearch()) {
				Text("Another doggo")
					.foregroundStyle(.white)
			}
			.background(Color.black)
			.cornerRadius(10)
        }
    }
}

struct InteractiveDogWidgets: Widget {
    let kind: String = "InteractiveDogWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                InteractiveDogWidgetsEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                InteractiveDogWidgetsEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    InteractiveDogWidgets()
} timeline: {
	SimpleEntry(date: .now, emoji: "😀", dog: .init(imageUrl: ""))
	SimpleEntry(date: .now, emoji: "🤩", dog: .init(imageUrl: ""))
}
