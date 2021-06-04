import QtQuick 2.12
import QtQuick.Controls 2.12

CheckBox {
    id: control
    checked: true

    font {
        family: uiconfig.fontFamily
        pixelSize: 14
    }
    spacing: 5
    leftPadding: 5
    topPadding: 0
    bottomPadding: 0
    
    property bool indicatorBorder: false

    // control.down && control.checked
    indicator: Rectangle {
        width: 20
        height: 20
        x: control.leftPadding
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        border.width: 1
        border.color: uiconfig.controlBorderColor
        Image {
            anchors.fill: parent
            anchors.margins: parent.border.width
            source: indicatorBorder? 
                        control.checked? "qrc:/classic/controllers/checkbox_border_checked.png":
                                         "qrc:/classic/controllers/checkbox_border_unchecked.png":
                        control.checked? "qrc:/classic/controllers/checkbox_noborder_checked.png":
                                         "qrc:/classic/controllers/checkbox_noborder_unchecked.png"
        }
    }

    

    contentItem: ThemeText {
        text: control.text
        opacity: enabled ? 1.0 : 0.3
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -1
        leftPadding: control.indicator.width + control.spacing
    }
}
