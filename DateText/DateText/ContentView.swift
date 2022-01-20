//
//  ContentView.swift
//  DateText
//
//  Created by luobobo on 2022/1/20.
//

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                Text(Date().formatted(date: .complete, time: .complete))
                Text(Date().formatted(date: .long, time: .standard))
                Text(Date().formatted(date: .numeric, time:  .shortened))
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                Text(Date().formatted(date: .omitted, time: .complete))
                Text(Date(), formatter: customFormatStyle)
            }
            
            Group {
                Text(Date(), style: .date)
                Text(Date(), style: .time)
                
                // 相对于当前时间的时间间隔，自动更新
                Text(Date().addingTimeInterval(60 * 60), style: .relative)
                
                // 定时器，自动更新
                Text(Date().addingTimeInterval(60 * 60), style: .timer)
            }
            
            Spacer()
        }
        .padding()
        
    }
    
    
}

private var customFormatStyle: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE, dd MM"
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
