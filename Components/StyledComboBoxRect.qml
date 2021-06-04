import QtQuick 2.12
import QtQuick.Controls 2.12

ComboBox {
    id: boxRoot
    
    font {
        family: uiconfig.fontFamily
        pixelSize: 12
    }
    height: 30

    delegate: ItemDelegate {
        width: boxRoot.width - 2
        x: 1
        implicitHeight: boxRoot.height
        leftPadding: 20
        rightPadding: 20

        contentItem: Row {
            spacing: 26
            anchors.centerIn: parent
            ThemeText {
                text: modelData[0]
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            Image {
                visible: modelData[1].length
                source: visible? modelData[1]: ""
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        highlighted: boxRoot.highlightedIndex === index
        background: Rectangle {
            color: highlighted? uiconfig.controlHighlightColor: "transparent"

            Rectangle {
                visible: boxRoot.currentIndex === index
                width: 4
                height: width
                radius: width / 2
                color: "#FFFFFF"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left 
                anchors.leftMargin: 10
            }
        }
    }

    indicator: Image {
        id: indicatorImg
        source: "qrc:/classic/controllers/arrow_down.png"
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
        }
        height: parent.height
        width: height
    }

    contentItem: Row {
        anchors.fill: parent
        leftPadding: 20
        rightPadding: 20
        spacing: 26
        
        ThemeText {
            text: boxRoot.model[boxRoot.currentIndex][0]
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        
        Image {
            visible: boxRoot.model[boxRoot.currentIndex][1].length
            source: visible? boxRoot.model[boxRoot.currentIndex][1]: ""
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    background: Rectangle {
        width: boxPopup.width
        height: parent.height
        border.color: uiconfig.controlBorderColor
        border.width: 1
        color: uiconfig.backgroundColor
    }

    popup: Popup {
        id: boxPopup
        width: boxRoot.width
        implicitHeight: contentItem.implicitHeight
        padding: 0
        topPadding: 1
        bottomPadding: 1
        y: 4 + boxRoot.height
        
        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight + 2
            model: boxRoot.popup.visible? boxRoot.delegateModel: null
            currentIndex: boxRoot.highlightedIndex
            boundsBehavior: Flickable.StopAtBounds
        }

        background: Rectangle {
            color: uiconfig.lighterSpaceColor
            border.width: 1
            border.color: uiconfig.controlBorderColor
        }
    }
    
    Component.onCompleted: {
        uiconfig.alphaColor(Qt.rgba(0, 0, 0, 1))
    }
}
