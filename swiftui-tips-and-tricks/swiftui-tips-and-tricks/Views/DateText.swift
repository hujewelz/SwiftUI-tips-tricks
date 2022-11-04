//
//  DateText.swift
//  swiftui-tips-and-tricks
//
//  Created by luobobo on 2022/11/5.
//

import SwiftUI

struct DateText: View {
    var body: some View {
        List {
            Section {
                Text(Date().formatted(date: .complete, time: .complete))
                Text(Date().formatted(date: .long, time: .standard))
                Text(Date().formatted(date: .numeric, time:  .shortened))
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                Text(Date().formatted(date: .omitted, time: .complete))
                Text(Date(), formatter: customFormatStyle)
            }
            
            Section {
                Text(Date(), style: .date)
                Text(Date(), style: .time)
                
                // 相对于当前时间的时间间隔，自动更新
                Text(Date().addingTimeInterval(60 * 60), style: .relative)
                
                // 定时器，自动更新
                Text(Date().addingTimeInterval(60 * 60), style: .timer)
            }
        }
    }
}

private var customFormatStyle: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE, dd MM"
    return formatter
}()


struct DataText_Previews: PreviewProvider {
    static var previews: some View {
        DateText()
    }
}
