import QtQuick 2.12
import QtQuick.Controls 2.12

ScrollBar {
    id: scrollRoot

    implicitWidth: 14

    property bool isVert: scrollRoot.orientation === Qt.Vertical
    property int  indicatorPadding: 0
    minimumSize: 0.2

    background: Rectangle {
        id: scrollBg
        color: "#5E5D6E"
        radius: width / 2
        Rectangle {
            x: indicatorPadding / 2
            y: indicatorPadding / 2
            width: isVert? parent.width - indicatorPadding: parent.height - indicatorPadding
            height: width
            radius: width / 2
            color: "#5E5D6E"
            border.width: 2
            border.color: "#B9BAC9"
        }
        Rectangle {
            x: isVert? indicatorPadding / 2: parent.width - width - indicatorPadding / 2
            y: isVert? parent.height - height - indicatorPadding / 2: indicatorPadding / 2
            width: isVert? parent.width - indicatorPadding: parent.height - indicatorPadding
            height: width
            radius: width / 2
            color: "#5E5D6E"
            border.width: 2
            border.color: "#B9BAC9"
        }
    }

    contentItem: Rectangle {
        id: bar
        // transform: Scale {}
        Rectangle {
            anchors.centerIn: parent
            visible: true
            width: isVert? parent.width: Math.max(parent.width - scrollRoot.height * 2, 1)
            height: isVert? Math.max(parent.height - scrollRoot.width * 2, 1): parent.height
            color: "#B9BAC9"
            radius: Math.min(width / 2, height / 2)
        }
        color: "transparent"
    }
}
