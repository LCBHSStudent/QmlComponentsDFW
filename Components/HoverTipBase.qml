import QtQuick 2.12

Rectangle {
    id: toolTipRect
    
    radius: 4
    color: "#33000000"
    implicitWidth: Math.min(350, toolTipText.implicitWidth + 13)
    height: toolTipText.contentHeight + 8
    
    property string text: ""
    
    UIConfig { id: uiconfig }
    
    ThemeText {
        id: toolTipText
        
        text: toolTipRect.text
        
        anchors.fill: parent
        anchors.topMargin: 4
        anchors.bottomMargin: 4
        anchors.leftMargin: 6
        anchors.rightMargin: 7
        clip: false
        wrapMode: Text.WrapAnywhere
    }
    
    onTextChanged: {
        if (text.length !== 0) {
            update()
            tooltip.show()
        }
    }
}
