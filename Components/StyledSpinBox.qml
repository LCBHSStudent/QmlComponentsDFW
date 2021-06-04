import QtQuick 2.12
import QtQuick.Controls 2.12

SpinBox {
    id: control
    editable: true

    contentItem: TextInput {
        z: 2
        text: control.textFromValue(control.value, control.locale)
        font {
            family: application.fontFamily
            pixelSize: 14
        }
        color: application.normalFontColor
        selectByMouse: true
        selectionColor: application.foregroundColor
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        leftPadding: -10

        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: Qt.ImhFormattedNumbersOnly
    }

    up.indicator: Image {
        x: control.mirrored ? 0 : parent.width - width
        height: parent.height / 2
        fillMode: Image.PreserveAspectFit
        opacity: control.up.pressed? 0.6: 1.0
        
        source: "qrc:/icons/dark/toolpanel/elevator_up.png"
    }

    down.indicator: Image {
        x: control.mirrored ? 0 : parent.width - width
        y: parent.height / 2
        height: parent.height / 2
        opacity: control.down.pressed? 0.6: 1.0
        
        source: "qrc:/icons/dark/toolpanel/elevator_down.png"
    }

    background: Rectangle {
        implicitWidth: 90
        color: "transparent"
        radius: 7
        border.width: 1
        border.color: application.foregroundColor
    }
}
