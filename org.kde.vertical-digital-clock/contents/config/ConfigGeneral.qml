import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: page
    
    property alias cfg_showSeconds: showSecondsCheckBox.checked
    property alias cfg_use24h: use24hCheckBox.checked
    property alias cfg_fontScale: fontScaleSpinBox.value
    property alias cfg_tightSpacing: tightSpacingCheckBox.checked
    property alias cfg_fontFamily: fontTextField.text
    
    QQC2.CheckBox {
        id: showSecondsCheckBox
        text: "Show seconds"
        Kirigami.FormData.label: "Display:"
    }
    
    QQC2.CheckBox {
        id: use24hCheckBox
        text: "Use 24-hour format"
    }
    
    QQC2.CheckBox {
        id: tightSpacingCheckBox
        text: "Tight spacing between time elements"
    }

    QQC2.TextField {
        id: fontTextField
        placeholderText: "Enter font name (leave empty for system default)"
        Kirigami.FormData.label: "Font family:"
    }
    
    QQC2.SpinBox {
        id: fontScaleSpinBox
        Kirigami.FormData.label: "Font size multiplier:"
        from: 50
        to: 500
        stepSize: 10
        value: 160
        
        textFromValue: function(value, locale) {
            return (value / 100).toFixed(1) + "x"
        }
        
        valueFromText: function(text, locale) {
            return parseFloat(text) * 100
        }
    }
}