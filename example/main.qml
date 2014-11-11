import QtQuick 2.0
import Ubuntu.Components 1.1

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    
    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.rayalez.mirage"
    
    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true
    
    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false
    
    width: units.gu(100)
    height: units.gu(75)
    
    Page {
        Column {
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
            }
            
            Row {
                id: toolbar
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: units.gu(1)
                }
                //property variant activeSquare: red
                property color paintColor: "#33B5E5"
                spacing: 4
                Repeater {
                    model:["#33B5E5","#99CC00","#FFBB33","#FF4444"]
                    ColorSquare {
                        id: red
                        color: modelData
                        active: parent.paintColor == color
                        onClicked: {
                            parent.paintColor = color
                        }
                    }
                }
                ColorPicker{}
            }
            
            Rectangle {
                anchors.fill: canvas
                border.color: "#666666"
                border.width: 4
            }

            Canvas {
                id: canvas
                anchors {
                    left: parent.left
                    right: parent.right
                    top: toolbar.bottom
                    bottom: parent.bottom
                    margins: 8
                }
                property real lastX
                property real lastY
                property color color: toolbar.paintColor
                onPaint: {
                    var ctx = getContext('2d')
                    ctx.lineWidth = 1.5
                    ctx.strokeStyle = canvas.color
                    ctx.beginPath()
                    ctx.moveTo(lastX, lastY)
                    lastX = area.mouseX
                    lastY = area.mouseY
                    ctx.lineTo(lastX, lastY)
                    ctx.stroke()
                }
                MouseArea {
                    id: area
                    anchors.fill: parent
                    onPressed: {
                        canvas.lastX = mouseX
                        canvas.lastY = mouseY
                    }
                    onPositionChanged: {
                        canvas.requestPaint()
                    }
                }
            }
            
            Canvas {
                
            }
            
        } // END Column
    }
}

