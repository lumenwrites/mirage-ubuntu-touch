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
        id: root
        Column {
            spacing: units.gu(1)
            anchors {
                fill: parent
            }

            Rectangle {
                id: toolbar
                width: units.gu(4)
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                }
                color: UbuntuColors.coolGrey

                Column {
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.top
                        topMargin: units.gu(1)
                    }
                    spacing: units.gu(2)
                    
                    Rectangle {
                        id: open_color_picker
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                        }
                        width: units.gu(3)
                        height: units.gu(3)
                        color: Qt.darker(UbuntuColors.coolGrey)
                    }

                    
                    Column {
                        id: opacity
                        anchors {
                            left: parent.left
                            right: parent.right
                            
                        }
                        spacing: units.gu(0.5)
                        Repeater {
                            model: 8
                            Rectangle {
                                width: units.gu(3)
                                height: units.gu(3)
                                anchors {
                                    horizontalCenter: parent.horizontalCenter
                                }
                                color: Qt.darker(UbuntuColors.coolGrey)
                            }
                        }
                    } // END opacity

                    Rectangle {
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                        }
                        height: units.gu(32)
                        width: toolbar.width - units.gu(0.5)
                        color: UbuntuColors.coolGrey //Qt.darker(UbuntuColors.coolGrey)

                        Slider {
                            anchors {
                                //top: parent.top
                                //bottom: parent.bottom
                                //verticalCenter: parent.verticalCenter
                            }
                            id: brush_size
                            function formatValue(v) { return v.toFixed(2) }
                            minimumValue: 0.1
                            maximumValue: 64
                            value: 20
                            live: true
                            transform: Rotation { origin.x: 0; origin.y: 0;
                            axis { x: 0; y: 0; z: 1 } angle: 90 }
                            x: units.gu(4.2)
                            y: units.gu(1)
                            width: units.gu(30)
                        }
                    } // END brush_size
                }

                Rectangle {
                    id: color_picker
                    anchors {
                        left: toolbar.right
                    }
                    width: units.gu(64)
                    height: units.gu(64)
                    color: Qt.darker(UbuntuColors.coolGrey)
                    opacity: 0
                    property color paintColor: Qt.rgba(1,0,0,0.5)
                } // END color_picker
                
            } // END toolbar

            Canvas {
                id: canvas
                property real lastX
                property real lastY
                property color paintColor: color_picker.paintColor
                opacity: 0.5

                anchors {
                    left: toolbar.right
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }


                onPaint: {
                    var ctx = getContext("2d")
                    ctx.lineWidth = brush_size.value
                    ctx.strokeStyle = canvas.paintColor
                    ctx.fillStyle = canvas.paintColor                    
                    ctx.beginPath()
                    ctx.moveTo(lastX, lastY)
                    lastX = mouse_area.mouseX
                    lastY = mouse_area.mouseY
                    // ctx.lineTo(lastX, lastY)

                    // ctx.fillRect(mouse_area.mouseX-brush_size.value/2, 
                    // mouse_area.mouseY-brush_size.value/2,
                    // brush_size.value,
                    // brush_size.value )

                    ctx.beginPath();
                    ctx.arc(lastX, lastY, 10, 0, Math.PI*2, true); 
                    ctx.closePath();
                    ctx.fill();

                    //ctx.arcTo(lastX, lastY, lastX, lastY, 20)

                    //ctx.stroke()
                }

                MouseArea {
                    id: mouse_area
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

        } // END Column
    }
}

