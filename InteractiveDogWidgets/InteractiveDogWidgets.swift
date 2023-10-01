//
//  InteractiveDogWidgets.swift
//  InteractiveDogWidgets
//
//  Created by Elliot Knight on 30/09/2023.
//

import WidgetKit
import SwiftUI
import DogApi

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
		SimpleEntry(
			date: Date(),
			emoji: "😀",
			dog: .init(
				imageUrl: "https://images.dog.ceo/breeds/poodle-medium/PXL_20210220_100624962.jpg"
			)
		)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
		let entry = SimpleEntry(
			date: Date(),
			emoji: "😀",
			dog: .init(
				imageUrl: "https://images.dog.ceo/breeds/poodle-medium/PXL_20210220_100624962.jpg"
			)
		)
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
		VStack {
			NetworkImage(url: URL(string: entry.dog.imageUrl))
				.cornerRadius(10)
			Spacer()
			Button(intent: DogSearch()) {
				Image(systemName: "shuffle")
					.foregroundStyle(.white)
					.font(.title3)
					.frame(maxWidth: .infinity)
			}
			.buttonBorderShape(.roundedRectangle(radius: 10))
			.buttonStyle(.borderedProminent)
			.accessibilityLabel("Look random dog")
        }
    }
}

struct InteractiveDogWidgets: Widget {
	let kind: String = "InteractiveDogWidgets"

	var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: Provider()) { entry in
			InteractiveDogWidgetsEntryView(entry: entry)
				.containerBackground(.fill.tertiary, for: .widget)
		}
		.configurationDisplayName("Random dogs")
		.description("Look cute dogs on your widget")
	}
}

#Preview(as: .systemSmall) {
    InteractiveDogWidgets()
} timeline: {
	SimpleEntry(date: .now, emoji: "😀", dog: .init(imageUrl: ""))
	SimpleEntry(date: .now, emoji: "🤩", dog: .init(imageUrl: ""))
}
