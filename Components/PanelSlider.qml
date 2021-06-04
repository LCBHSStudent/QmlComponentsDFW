import QtQuick 2.15
import QtQuick.Controls 2.15

Slider {
    id: sliderRoot

    property int barHeight: 8
    implicitHeight: handler.width

    background: Rectangle {
        height: barHeight
        color: Qt.rgba(application.foregroundColor.r, application.foregroundColor.g, application.foregroundColor.b, 0.6)
        radius: height / 2

        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            height: parent.height
            width: handler.x + handler.radius
            radius: height / 2
            color: application.foregroundColor
        }
    }

    handle: Rectangle {
        id: handler
        x: sliderRoot.leftPadding + sliderRoot.visualPosition * (sliderRoot.availableWidth - width)
        y: sliderRoot.topPadding + sliderRoot.availableHeight / 2 - height / 2

        width: 14
        height: width
        radius: width / 2
        color: "#7781F4"
        border.width: 2
        border.color: "#FFFFFF"
    }
}
