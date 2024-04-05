//
//  CategoryIcon.swift
//  SpendSmart
//
//  Created by dtrognn on 05/04/2024.
//

import SwiftUI

enum CategoryIcon: String, Identifiable, CaseIterable {
    case toga = "ic_toga"
    case award = "ic_award"
    case locker = "ic_locker"
    case eyeGlasses = "ic_eye_glasses"
    case paperBag = "ic_paper_bag"
    case paper = "ic_paper"
    case pencil = "ic_pencil"
    case book = "ic_book"
    case pen = "ic_pen"
    case shoes = "ic_shoes"
    case whiteBoard = "ic_white_board"
    case calculator = "ic_calculator"
    case laptop = "ic_laptop"
    case folder = "ic_folder"
    case ruler = "ic_ruler"
    case bell = "ic_bell"
    case paperPlane = "ic_paper_plane"
    case certificate = "ic_certificate"
    case clock = "ic_clock"
    case university = "ic_university"
    case mail = "ic_mail"
    case mappin = "ic_mappin"

    case bench = "ic_bench"
    case plane = "ic_plane"
    case beachBall = "ic_beach_ball"
    case camera = "ic_camera"
    case hawaiian = "ic_hawaiian"
    case bikini = "ic_bikini"
    case eyeGlasses2 = "ic_eye_glasses_2"
    case bbq = "ic_bbq"
    case slippers = "ic_slippers"
    case juice = "ic_juice"
    case coin = "ic_coin"
    case image = "ic_image"
    case watermelon = "ic_watermelon"
    case suitcase = "ic_suitcase"

    case carrier = "ic_carrier"
    case wrench = "ic_wrench"
    case apple = "ic_apple"
    case pizza = "ic_pizza"
    case cake = "ic_cake"
    case cupDink = "ic_cup_drink"
    case cake2 = "ic_cake_2"
    case icecream = "ic_ice_cream"
    case bloodDonation = "ic_blood_donation"
    case tooth = "ic_tooth"
    case vaccine = "ic_vaccine"

    case ac = "ic_ac"
    case iphone = "ic_iphone"
    case washingMachine = "ic_washing_machine"
    case wristWatch = "ic_wrist_watch"
    case joystick = "ic_joystick"
    case lamp = "ic_lamp"
    case tableLamp = "ic_table_lamp"

    var id: String { rawValue }

    var image: Image {
        return Image(rawValue)
    }
}
