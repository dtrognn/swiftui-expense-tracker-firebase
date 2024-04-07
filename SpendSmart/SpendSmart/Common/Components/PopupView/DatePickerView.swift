//
//  DatePickerView.swift
//  SpendSmart
//
//  Created by dtrognn on 07/04/2024.
//

import SwiftUI

protocol IPopupView {
    var tag: Int { get }
}

class DatePickerVM: ObservableObject {
    @Published var dateSelected: DateSelected

    init(dateSelected: DateSelected) {
        self.dateSelected = dateSelected
    }
}

enum DateType {
    case day
    case month
    case year
}

class DateSelected {
    var day: Int
    var month: Int
    var year: Int

    init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }

    var toDate: Date {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: year, month: month, day: day)
        return calendar.date(from: dateComponents) ?? Date()
    }
}

struct DatePickerView: View, IPopupView {
    var tag: Int = 200

    @StateObject private var store: DatePickerVM

    private var dateType: DateType
    private var onSelect: (DateSelected) -> Void
    private var isLimitYear: Bool?

    @State private var selectedDay: Int = 1
    @State private var selectedMonth: Int = 1
    @State private var selectedYear: Int = 2023

    private let PICKER_HEIFHT: CGFloat = 200.0
    private let PICKER_WIDTH: CGFloat = 100.0

    init(dateDefault: DateSelected,
         dateType: DateType,
         isLimitYear: Bool? = nil,
         onSelect: @escaping ((DateSelected) -> Void))
    {
        self._store = StateObject(wrappedValue: DatePickerVM(dateSelected: dateDefault))
        self.dateType = dateType
        self.onSelect = onSelect
        self.isLimitYear = isLimitYear

        switch dateType {
        case .day:
            self._selectedDay = State(wrappedValue: dateDefault.day)
            self._selectedMonth = State(wrappedValue: dateDefault.month)
            self._selectedYear = State(wrappedValue: dateDefault.year)
        case .month:
            self._selectedMonth = State(wrappedValue: dateDefault.month)
            self._selectedYear = State(wrappedValue: dateDefault.year)
        case .year:
            self._selectedYear = State(wrappedValue: dateDefault.year)
        }
    }

    var body: some View {
        ZStack {
            AppStyle.theme.backgroundPopupColor

            VStack(spacing: AppStyle.layout.standardSpace) {
                headerView

                HStack(spacing: AppStyle.layout.zero) {
                    switch dateType {
                    case .day:
                        datePickerView
                        monthPickerView
                        yearPickerView
                    case .month:
                        monthPickerView
                        yearPickerView
                    case .year:
                        yearPickerView
                    }
                }.frame(height: PICKER_HEIFHT)
                    .padding(.top, AppStyle.layout.mediumSpace)
                    .onChange(of: selectedMonth) { newMonth in
                        selectedDay = min(selectedDay, numberOfDaysInMonth(month: newMonth, year: selectedYear))
                    }.onChange(of: selectedYear) { newYear in
                        selectedDay = min(selectedDay, numberOfDaysInMonth(month: selectedMonth, year: newYear))
                    }

                selectButton
                    .padding(.horizontal, AppStyle.layout.standardSpace)
                    .padding(.bottom, AppStyle.layout.standardSpace)
            }.applyShadowView()
                .padding(.horizontal, AppStyle.layout.standardSpace)
        }.ignoresSafeArea()
    }
}

private extension DatePickerView {
    var datePickerView: some View {
        GeometryReader { geo in
            VStack(spacing: AppStyle.layout.zero) {
                dayText
                Picker("", selection: $selectedDay) {
                    ForEach(1 ... numberOfDaysInMonth(month: selectedMonth, year: selectedYear), id: \.self) { index in
                        Text(String(index)).tag(index)
                    }
                }.frame(width: geo.size.width)
                    .labelsHidden()
                    .pickerStyle(.wheel)
            }
        }
    }

    var monthPickerView: some View {
        GeometryReader { geo in
            VStack(spacing: AppStyle.layout.zero) {
                monthText
                Picker("", selection: $selectedMonth) {
                    ForEach(1 ... 12, id: \.self) { index in
                        Text(String(index)).tag(index)
                    }
                }.frame(width: geo.size.width)
                    .labelsHidden()
                    .pickerStyle(.wheel)
            }
        }
    }

    var yearPickerView: some View {
        GeometryReader { geo in
            VStack(spacing: AppStyle.layout.zero) {
                yearText
                Picker("", selection: $selectedYear) {
                    ForEach(getRangeOfYear(), id: \.self) { index in
                        Text(String(index)).tag(index)
                    }
                }.frame(width: geo.size.width)
                    .labelsHidden()
                    .pickerStyle(.wheel)
            }
        }
    }

    func getRangeOfYear() -> Range<Int> {
        if isLimitYear != nil {
            return 2000 ..< getMaximumYear() + 1
        } else {
            return 2000 ..< 2050
        }
    }

    func numberOfDaysInMonth(month: Int, year: Int) -> Int {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: year, month: month)
        if let date = calendar.date(from: dateComponents),
           let range = calendar.range(of: .day, in: .month, for: date)
        {
            return range.count
        }
        return 0
    }

    func getMaximumYear() -> Int {
        return Calendar.current.component(.year, from: Date())
    }
}

private extension DatePickerView {
    var closeButton: some View {
        Button {
            self.hide()
        } label: {
            Image("ic_xmark")
                .resizable()
                .applyTheme()
                .frame(width: 14, height: 14)
                .frame(width: AppStyle.layout.standardButtonHeight, height: AppStyle.layout.standardButtonHeight)
        }
    }

    var selectButton: some View {
        Button {
            let dateSelected = DateSelected(day: selectedDay, month: selectedMonth, year: selectedYear)
            onSelect(dateSelected)
            self.hide()
        } label: {
            Text(language("Date_Picker_A_04"))
        }.buttonStyle(.standard())
    }

    var titleText: some View {
        let titleMap: [DateType: String] = [
            .day: "Date_Picker_A_01",
            .month: "Date_Picker_A_02",
            .year: "Date_Picker_A_03"
        ]

        guard let titleKey = titleMap[dateType] else {
            return Text("")
        }

        return Text(language(titleKey))
            .font(AppStyle.font.medium16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var headerView: some View {
        VStack(spacing: AppStyle.layout.zero) {
            ZStack {
                HStack(spacing: AppStyle.layout.zero) {
                    closeButton
                    Spacer()
                }.padding(.horizontal, AppStyle.layout.mediumSpace)
                HStack {
                    titleText
                }
            }
            StraightLine()
        }
    }

    var dayText: some View {
        Text(language("Date_Picker_A_05"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var monthText: some View {
        Text(language("Date_Picker_A_06"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }

    var yearText: some View {
        Text(language("Date_Picker_A_07"))
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNormalColor)
    }
}
