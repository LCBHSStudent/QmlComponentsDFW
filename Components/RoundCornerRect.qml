import QtQuick.Shapes 1.15
import QtQuick 2.15

Shape {
    id: rcRect

    property double cornerRadius: 5

    property alias color: path.fillColor
    property alias strokeColor: path.strokeColor
    property alias strokeWidth: path.strokeWidth
    
    property bool ltEnabled: false
    property bool rtEnabled: false
    property bool rbEnabled: false
    property bool lbEnabled: false

    layer.enabled: true
    layer.samples: 8

    ShapePath {
        id: path
        strokeColor: "#00FFFFFF"
        fillRule: ShapePath.WindingFill
        startX: ltEnabled? cornerRadius : 0
        startY: 0

        Behavior on fillColor {
            PropertyAnimation { duration: 50 }
        }

        PathLine {
            x: rtEnabled? rcRect.width - cornerRadius: rcRect.width
            y: 0
        }
        PathArc {
            x: rcRect.width
            y: rtEnabled? cornerRadius: 0
            radiusX: rtEnabled? cornerRadius: 0
            radiusY: rtEnabled? cornerRadius: 0
        }

        PathLine {
            x: rcRect.width
            y: rbEnabled? rcRect.height - cornerRadius: rcRect.height
        }
        PathArc {
            x: rbEnabled? rcRect.width - cornerRadius: rcRect.width
            y: rcRect.height
            radiusX: rbEnabled? cornerRadius: 0
            radiusY: rbEnabled? cornerRadius: 0
        }
        PathLine {
            x: lbEnabled? cornerRadius : 0
            y: rcRect.height
        }
        PathArc {
            x: 0
            y: lbEnabled? rcRect.height - cornerRadius: rcRect.height
            radiusX: lbEnabled? cornerRadius: 0
            radiusY: lbEnabled? cornerRadius: 0
        }

        PathLine {
            x: 0
            y: ltEnabled? cornerRadius: 0
        }
        PathArc {
            x: ltEnabled? cornerRadius: 0
            y: 0
            radiusX: ltEnabled? cornerRadius: 0
            radiusY: ltEnabled? cornerRadius: 0
        }
    }
}
