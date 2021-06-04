import QtQuick 2.12
import QtQuick.Controls 2.12
import DFW.Components 1.0

TextField {
    id: fieldRoot
    
    property int suffixMargin: 5
    property alias suffix: suffixText.text
    
    background: Rectangle {
        color: "transparent"
        border.width: 1
        border.color: uiconfig.controlBorderColor
    }
    
    horizontalAlignment: TextField.AlignHCenter
    font {
        family: uiconfig.fontFamily
        pixelSize: 14
    }
    
    ThemeText {
        id: suffixText
        color: uiconfig.lighterFontColor
        anchors{
            left: parent.right
            leftMargin: suffixMargin
            verticalCenter: parent.verticalCenter        
        }
    }
    
    Connections {
        target: uiconfig
        function onResetFocus() {
            fieldRoot.focus = false
        }
    }
    
    CursorArea {
        anchors.fill: parent
        cursor: Qt.IBeamCursor
    }
}
