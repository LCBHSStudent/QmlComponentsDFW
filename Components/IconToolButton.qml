import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: icBtnRoot

    clip: false
    
    property int iconSize
    width: iconSize
    height: iconSize
    
    property double reactAreaFactor: 1.0
    
    property alias iconSource: icon.source
    property alias iconScale: icon.scale
    property alias enabled: icBtnArea.enabled
    property alias hoverEnabled: icBtnArea.hoverEnabled
    property alias iconOpacity: icon.opacity
    property color bgColor: "transparent"

    property alias tooltip: tip.text
    property alias cursorShape: icBtnArea.cursorShape
    property alias containsMouse: icBtnArea.containsMouse
    
    property real pressedOpacity: 0.6
    property real disabledOpacity: 0.7

    property bool checked: false
    property bool checkable: false
    
    Rectangle {
        id: btnBg

        visible: checked || icBtnArea.containsMouse

        color: bgColor
        anchors.fill: parent
    }

    Image {
        id: icon
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        opacity: icBtnRoot.enabled? 
            icBtnArea.pressed? pressedOpacity: 1.0: disabledOpacity
    }

    signal clicked()
    signal pressedAndHeld()
    signal holdFinished()

    // Behavior on opacity {
    //     PropertyAnimation { duration: 50 }
    // }

    MouseArea {
        id: icBtnArea
        anchors.centerIn: parent

        width: reactAreaFactor * icBtnRoot.width
        height: reactAreaFactor * icBtnRoot.height
    
        hoverEnabled: true
        property bool pressAndHeld: false
        
        onPressAndHold: {
            pressAndHeld = true
            pressedAndHeld()
        }
        onReleased: {
            if (pressAndHeld) {
                holdFinished()
                pressAndHeld = false
            }

            if (checkable) {
                checked = !checked
            }
            icBtnRoot.clicked()

            tip.enabled = tooltip.length
        }
    }
    
    HoverTip {
        id: tip
        enabled: tooltip.length
        fallthrough: icBtnArea
    }
}
