import QtQuick 2.0
import Ubuntu.Components 1.1

import U1db 1.0 as U1db
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "utilities.js" as Utilities

Page {
    id: root
    title: "Paintings"
    // Don't use "anchors.fill: parent" on Page

    Rectangle {
        anchors.fill: parent

        GridView {
            anchors.margins: {
                right: units.gu(16)
                left: units.gu(2)
                bottom: units.gu(2)
                top: units.gu(2)
            }

            anchors.fill: parent
            model: modelQuery

            delegate: UbuntuShape {
                id: drawingItem
                width: units.gu(10)
                height: units.gu(10)
                image: Image {
                    source: contents.src
                }

                MouseArea {
                    id: input
                    anchors.fill: parent
                    onClicked: {
                        //Utilities.openDrawing(model);
                        paintView.canvasArea.openDrawing(model);
                        pageStack.push(paintView);
                    }
                    onPressAndHold: {
                        PopupUtils.open(itemPopoverComponent, drawingItem);
                    }
                    Component {
                        id: itemPopoverComponent
                        Popover {
                            id: itemPopover
                            Column {
                                anchors {
                                    top: parent.top
                                    right: parent.right
                                    left: parent.left
                                }
                                ListItem.Standard {
                                    text: i18n.tr("delete");
                                    onTriggered: {
                                        mirageDB.putDoc("", model.docId)
                                        print("deleted")
                                        // PopupUtils.open(deleteDialogComponent)
                                        // PopupUtils.close(itemPopover)
                                    }
                                }
                            }
                        }
                    }
                }
                // Component {
                //     id: deleteDialogComponent
                //     Dialog {
                //         id: deleteDialog
                //         title: "Delete Image"
                //         text: "Delete this image?"
                //         Button {
                //             text: "Yes"
                //             onClicked: {
                //                 PopupUtils.close(deleteDialog)

                //             }
                //         }
                //         Button {
                //             text: "No"
                //             onClicked: PopupUtils.close(deleteDialog)
                //         }
                //     }
                // }
            }
        }
        UbuntuShape {
            anchors {
                right: parent.right
                top: parent.top
            }
            anchors.margins: {
                right: units.gu(2)
                left: units.gu(2)
                bottom: units.gu(2)
                top: units.gu(2)
            }

            id: drawingItem
            width: units.gu(10)
            height: units.gu(10)
            image: Image {
                source: "icons/new-image-icon.png"
            }

            MouseArea {
                id: newImage
                anchors.fill: parent
                onClicked: {
                    paintView.canvasArea.newPainting()
                    pageStack.push(paintView);
                }
                onPressAndHold: {
                    PopupUtils.open(itemPopoverComponent, drawingItem);
                }
            }
        }


    }
}