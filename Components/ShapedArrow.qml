import QtQuick 2.15
import QtQuick.Shapes 1.15

Shape {
    id: sptArrow
    
    property double margin: 1
    property alias color: path.fillColor

    smooth: true
    antialiasing: true

    ShapePath {
        id: path

        strokeColor: "transparent"

        startX: sptArrow.margin
        startY: 0
                
        PathLine {
            x: sptArrow.width / 2;
            y: sptArrow.height - 2 * sptArrow.margin 
        }
        PathLine { 
            x: sptArrow.width - sptArrow.margin;
            y: 0
        }
        PathLine { 
            x: sptArrow.width;
            y: sptArrow.margin 
        }
         PathLine { 
            x: sptArrow.width / 2;
            y: sptArrow.height 
        }
        PathLine { 
            x: 0; 
            y: sptArrow.margin 
        }
    }
}