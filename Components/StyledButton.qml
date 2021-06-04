import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: btnBase

    color: normalColor

    property color normalColor: uiconfig.darkerSpaceColor
    property color pressedColor: Qt.darker(normalColor, 1.2)
    property color hoverColor: Qt.lighter(normalColor, 1.2)
    
    radius: 6

    property alias enabled: btnArea.enabled
    property alias hoverEnabled: btnArea.hoverEnabled

    signal clicked()
    signal doubleClicked()
    signal pressAndHold()
    signal pressed()
    signal released()
    
    property alias text: btnText.text
    property alias spacing: contentRow.spacing
    
    property string iconSource: ""
    property real   iconScale: 1.0
    property alias  font: btnText.font
    property bool   checkable: false
    property bool   leftIcon: false
    property bool   rightIcon: false

    Behavior on scale {
        PropertyAnimation { duration: 100 }
    }

    MouseArea {
        id: btnArea
        anchors.fill: parent
        
        onPressed: {
            btnBase.pressed()
            color = pressedColor
        }
        onEntered: {
            if (!checkable)
                color = hoverColor
        }
        onExited: {
            if (!checkable)
                color = normalColor
        }

        onReleased: {
            btnBase.released()
            if (!checkable)
                color = normalColor
        }
        onClicked: {
            btnBase.clicked()
        }
        onPressAndHold: {
            btnBase.pressAndHold()
        }
    }

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: text.length? 5: 0
        Image {
            id: btnIconLeft
            visible: leftIcon
            source: iconSource
            opacity: btnBase.enabled? 1: 0.6

            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: btnText
            color: btnBase.enabled? uiconfig.normalFontColor: Qt.darker(uiconfig.normalFontColor, 1.4)
            anchors.verticalCenterOffset: -1
            visible: text.length
        
            font {
                family: uiconfig.fontFamily
                pixelSize: 14
            }

            anchors.verticalCenter: parent.verticalCenter

            verticalAlignment: Text.AlignVCenter
        }

        Image {
            id: btnIconRight
            visible: rightIcon
            source: iconSource
            opacity: btnBase.enabled? 1: 0.6

            anchors.verticalCenter: parent.verticalCenter
        }
    }

    
}
