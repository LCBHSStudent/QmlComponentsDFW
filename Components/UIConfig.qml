import QtQuick 2.12

MouseArea {
    id: palette
    
    signal resetFocus()
    
    // color group
    readonly property color lighterSpaceColor: "#3E3D4C"
    readonly property color darkerSpaceColor: "#2D2C39"
    readonly property color normalFontColor: "#FFFFFF"
    readonly property color lighterFontColor: "#E6FFFFFF"
    readonly property color backgroundColor: "#292833"
    readonly property color foregroundColor: "#2D8CF0"
    readonly property color normalButtonColor: "#3E3D4C"
    
    readonly property color controlHighlightColor: "#2A2836"
    readonly property color controlBorderColor: "#5E5F72"
    
    function alphaColor(color, alpha) {
        return Qt.rgba(color.r, color.g, color.b, alpha)
    }
    
    // font group
    readonly property string fontFamily: "Microsoft YaHei"
    
    anchors.fill: parent
    propagateComposedEvents: true
    onPressed: {
        mouse.accepted = false
        resetFocus()
    }
}
