import QtQuick 2.12
import QtQuick.Controls 2.12

ComboBox {
    id: boxRoot

    font {
        family: application.fontFamily
        pixelSize: 14
    }

    delegate: ItemDelegate {
        leftPadding: 10
        width: boxRoot.width - 4
        implicitHeight: 24
        contentItem: Text {
            text: modelData
            color: application.normalFontColor
            font: boxRoot.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: boxRoot.highlightedIndex === index
        background: Rectangle {
            color: highlighted? "#5F65B0": "transparent"
            radius: boxRoot.model.length - 1 === index? 8: 0
            Rectangle {
                visible: boxRoot.model.length - 1 === index && highlighted
                color: "#5F65B0"
                width: parent.width
                height: 4
            }
        }
    }

    indicator: Image {
        id: indicatorImg
        source: "qrc:/icons/dark/btn_leadin.png"
        anchors {
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: 1
            right: parent.right
            rightMargin: -parent.height * 12 / 40
        }
        height: parent.height / 26 * 40
        width: height
        Behavior on rotation {
            PropertyAnimation {
                duration: 100
            }
        }
        Component.onCompleted: {
            console.debug(width)
        }
        rotation: boxPopup.visible? -90: 0
    }

    contentItem: Text {
        leftPadding: 12
        rightPadding: 0
        width: parent.width
        text: boxRoot.displayText
        font: boxRoot.font
        color: application.normalFontColor
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    background: Rectangle {
        width: boxPopup.width
        height: parent.height + boxPopup.height
        border.color: application.foregroundColor
        border.width: 2
        radius: 12
        color: application.lighterSpaceColor
    }

    popup: Popup {
        id: boxPopup
        y: boxRoot.height - 1
        width: boxRoot.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight + 2
            model: boxRoot.popup.visible ? boxRoot.delegateModel : null
            currentIndex: boxRoot.highlightedIndex
            boundsBehavior: Flickable.StopAtBounds
        }

        background: Rectangle {
            color: "transparent"
        }
    }
}