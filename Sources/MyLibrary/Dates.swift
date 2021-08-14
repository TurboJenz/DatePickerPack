import SwiftUI

@available(iOS 14.0, *)
public struct DatePicker: View {
    @AppStorage("Test") var ny = ""
    @State var currentYears = 1...5
    @State private var selection = 0
    @State var days:Int = 1
    @State var month = "Januar"
    @State var year: Int = 0
    @State var months = ["", "Januar", "Februar", "Marts", "April",
                         "Maj", "Juni", "Juli", "August", "September",
                         "Oktober", "November", "December"]
    @State var currentYear = Calendar.current.dateComponents([.year], from: Date())
    let todaysDay = Calendar.current.dateComponents([.day], from: Date())
    let todaysMonth = Calendar.current.dateComponents([.month], from: Date())
    let componentsWidth:CGFloat = (UIScreen.main.bounds.size.width / 3) - 10
    public init() {
        self.year = 0
    }
    public var body: some View {
        VStack{
            HStack{
                Picker(selection: $days, label: Text("Days")) {
                    ForEach(1...31, id: \.self) { item in
                        Text("\(item)").tag("\(item)")
                            .lineLimit(1)
                            .font(.system(size: 20))
                    }
                }
                .onChange(of: days, perform: { _ in
                    sigHej()
                })
                .frame(maxWidth: componentsWidth)
                .clipped()
                .offset(x: 4)
                Picker(selection: $month, label: Text("Month")) {
                    ForEach(months.dropFirst(), id: \.self) { item in
                        Text("\(item)").tag("\(item)")
                            .lineLimit(1)
                            .font(.system(size: 20))
                    }
                }
                .onChange(of: month, perform: { _ in
                    sigHej()
                })
                .frame(maxWidth: componentsWidth)
                .clipped()
                .offset(x: -4)
                Picker(selection: $year, label: Text("Years")) {
                    ForEach(currentYears.reversed(), id: \.self) { item in
                        Text("\(String(item))").tag("\(item)")
                            .lineLimit(1)
                            .font(.system(size: 20))
                    }
                }
                .onChange(of: year, perform: { _ in
                    sigHej()
                })
                .frame(maxWidth: componentsWidth)
                .clipped()
                .offset(x: -12)
            }
            .onAppear {
                let startYear = Int(currentYear.year!) - 50
                let currentYearNow = Int(currentYear.year!)
                currentYears = startYear...currentYearNow
                days = Int(todaysDay.day!)
                year = Int(currentYear.year!)
                month = months[Int(todaysMonth.month!)]
            }
        }
    }
    public func sigHej() {
        ny = "\(String(format: "%02d", days))-\(String(format: "%02d", monthToNumber(month: month)))-\(year)"
    }
    public func sigDato() -> String {
        return ny
    }
    public func monthToNumber(month: String) -> Int {
        switch month {
        case "Januar": return 1
        case "Februar": return 2
        case "Marts": return 3
        case "April": return 4
        case "Maj": return 5
        case "Juni": return 6
        case "Juli": return 7
        case "August": return 8
        case "September": return 9
        case "Oktober": return 10
        case "November": return 11
        default: return 12
        }
    }
}



