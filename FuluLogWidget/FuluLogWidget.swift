//
//  FuluLogWidget.swift
//  FuluLogWidget
//
//  Created by t&a on 2022/11/10.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let count = UserDefaults(suiteName: "group.com.ame.FuluLog")?.integer(forKey: "count")
        var entry = SimpleEntry(date: Date())
        entry.count = count ?? 0
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var count:Int = 0
}

struct FuluLogWidgetEntryView : View {
    var entry: Provider.Entry

    func getYear() -> String{
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        df.locale = Locale(identifier: "ja_JP")
        return df.string(from: Date())
    }
    var body: some View {
        VStack{
            Spacer()
            Group{
                HStack(spacing:0){
                    Text("\(getYear())")
                    Text("年度")
                }.padding(.bottom,3)
                Text("未申請のふるさと納税")
            }.font(.system(size: 12)).foregroundColor(.gray)
        
            Spacer()
            HStack{
                Text("\(entry.count)").font(.system(size: 30)).foregroundColor(Color("ThemaColor"))
                Text("個").font(.system(size: 15)).offset(x: 0, y: 6)
            }.padding(5)
            Spacer()
        }
        
    }
}

@main
struct FuluLogWidget: Widget {
    let kind: String = "FuluLogWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FuluLogWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("FuluLogWidget")
        .description("今年度の未申請のワンストップの個数を表示します。")
    }
}

struct FuluLogWidget_Previews: PreviewProvider {
    static var previews: some View {
        FuluLogWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
