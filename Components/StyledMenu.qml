import QtQuick 2.12
import QtQuick.Controls 2.12

Menu {
    id: menuRoot
    topPadding: 2
    bottomPadding: 2

    delegate: MenuItem {
        id: menuItem
        implicitHeight: 34

        font {
            family: application.fontFamily
            pixelSize: 14
        }
        arrow: Canvas {
            anchors.verticalCenter: parent.verticalCenter
            x: parent.width - width
            implicitWidth: menuItem.implicitHeight / 2
            implicitHeight: implicitWidth
            visible: menuItem.subMenu
            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = application.normalFontColor
                ctx.moveTo(width - 10, height / 2)
                ctx.lineTo(0, height / 2 - 5)
                ctx.lineTo(0, height / 2 + 5)
                ctx.closePath()
                ctx.fill()
            }
        }

        indicator: Item {
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 2
            anchors.left: parent.left
            anchors.leftMargin: 3
            implicitWidth: menuItem.implicitHeight / 2
            implicitHeight: implicitWidth
            Rectangle {
                width: height
                height: parent.width
                anchors.centerIn: parent
                visible: menuItem.checkable
                border.color: application.lighterSpaceColor
                radius: 3
                Rectangle {
                    width: parent.width * 0.8
                    height: width
                    anchors.centerIn: parent
                    visible: menuItem.checked
                    color: application.foregroundColor
                    radius: 3
                }
            }
        }

        contentItem: Text {
            leftPadding: menuItem.indicator.width
            rightPadding: menuItem.arrow.width
            text: menuItem.text
            font: menuItem.font
            opacity: enabled ? 1.0 : 0.3
            color: application.normalFontColor
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            anchors.fill: parent
            opacity: enabled ? 1 : 0.3
            color: menuItem.highlighted ? "#6065B0" : "transparent"
        }
    }

    // background: Rectangle {
    //     anchors.fill: parent
    //     color: "transparent"
    // }
}