import QtQuick 2.0
import Ubuntu.Components 1.1
import "ColorUtils.js" as ColorUtils

Item {
    id: root
    property alias paintColor:  sb.paintColor
    //property alias selectedColor:  sb.selectedColor //remove it?
    z: 10

    Rectangle {
        id: sb
        width: units.gu(40)
        height: units.gu(40)
        color: Qt.darker(UbuntuColors.coolGrey)
        z: 10

        // Qt.lighter to setup default painting color
        property color paintColor: selectedColor
        property color selectedColor: ColorUtils.hsba(hueSlider.value, sbPicker.saturation,sbPicker.brightness, 1)//toolbar.brushOpacity for flow

        Component.onCompleted: {
            paintColor = "#FFEBC8" //warm
            paintColor = "#F9D4A3" //another warm
            paintColor = "#1C0101" //dark red
            paintColor = "#BFCCFF" //cold
            paintColor = "#DEE4FF" //cold




        }

        onSelectedColorChanged: {
            paintColor = selectedColor
            //can't bind directly because I want to change paintColor by picking color from canvas
        }

        property real hue: hueSlider.value
        property real saturation: sbPicker.saturation
        property real brightness: sbPicker.brightness


        SBGradient {
            id: sbPicker
            hueColor : ColorUtils.hsba(hueSlider.value, 1, 1, 1)
        }

        HueSlider{
            id: hueSlider
            anchors {
                left: sb.right
            }
        }
    } // END color_picker
}