import QtQuick 2.0
import Ubuntu.Components 1.1

// Checkerboard
Grid {
    id: checkerboard
    property int cellSide: units.gu(1)
    width: units.gu(43); height: units.gu(43)
    rows: height/cellSide; columns: width/cellSide
    Repeater {
        model: checkerboard.columns*checkerboard.rows
        Rectangle {
            width: checkerboard.cellSide; height: checkerboard.cellSide
            color: (index%2 == 0) ? "gray" : "white"
        }
    }
}