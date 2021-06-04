import QtQuick 2.12

Text {
    property int fontSize: 12
    
    color: uiconfig.normalFontColor
    font {
        family: uiconfig.fontFamily
        pixelSize: fontSize
    }
}
