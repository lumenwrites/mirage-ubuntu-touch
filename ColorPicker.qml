import QtQuick 2.0
import Ubuntu.Components 1.1
import "ColorUtils.js" as ColorUtils

Rectangle {
    id: root
    width: units.gu(40)
    height: units.gu(40)
    color: Qt.darker(UbuntuColors.coolGrey)
    z: 10

    property color paintColor: ColorUtils.hsba(hueSlider.value, sbPicker.saturation,
    sbPicker.brightness, toolbar.brush_opacity)

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
            left: root.right
        }
    }
} // END color_picker