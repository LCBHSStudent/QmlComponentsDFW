import QtQuick 2.15
import QtQuick.Controls 2.15

Slider {
    id: sliderRoot

    background: Rectangle {
        x: sliderRoot.leftPadding
        y: sliderRoot.topPadding + sliderRoot.availableHeight / 2 - height / 2

        width: vertical? 5: parent.width
        height: vertical? parent.height: 5
        color: enabled? "#FEFEFE": "#A9A9AD"
        border.color: "#84848D"
        border.width: 1
        radius: (vertical? width: height) / 2

        anchors.centerIn: parent
    }

    handle: Rectangle {
        x: vertical? 
            sliderRoot.leftPadding + sliderRoot.availableWidth / 2 - width / 2:
            sliderRoot.leftPadding + sliderRoot.visualPosition * (sliderRoot.availableWidth - width)
        y: vertical?
            sliderRoot.topPadding + sliderRoot.visualPosition * (sliderRoot.availableHeight - height):
            sliderRoot.topPadding + sliderRoot.availableHeight / 2 - height / 2

        width: 14
        height: width
        radius: width / 2
        color: enabled? "#7781F4": "#575DA7"
    }
}