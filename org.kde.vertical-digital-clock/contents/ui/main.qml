import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root
    readonly property bool showSeconds: plasmoid.configuration.showSeconds
    readonly property bool use24h: plasmoid.configuration.use24h
    readonly property real fontScale: plasmoid.configuration.fontScale
    readonly property string fontFamily: "JetBrains Mono NL"
    readonly property bool tightSpacing: plasmoid.configuration.tightSpacing
    Plasmoid.backgroundHints: PlasmaCore.Types.ConfigurableBackground


    // Clock tick — use a simple Timer to avoid deprecated engines
    property date now: new Date()
    Timer {
        interval: root.showSeconds ? 1000 : 60000
        repeat: true; running: true
        onTriggered: root.now = new Date()
    }

    // Format helpers
    function two(n) { return (n < 10 ? "0" : "") + n }
    function hoursStr(date) {
        var h = date.getHours()
        if (use24h) return two(h)
        var h12 = h % 12; if (h12 === 0) h12 = 12
        return two(h12)
    }
    function minutesStr(date) { return two(date.getMinutes()) }
    function secondsStr(date) { return two(date.getSeconds()) }

    // Layout
    implicitWidth: Math.max(hoursLabel.implicitWidth, minutesLabel.implicitWidth) + Kirigami.Units.smallSpacing*2
    implicitHeight: hoursLabel.implicitHeight + minutesLabel.implicitHeight + (showSeconds ? secondsLabel.implicitHeight : 0) + Kirigami.Units.smallSpacing*2 + (tightSpacing ? -Kirigami.Units.smallSpacing : Kirigami.Units.smallSpacing)

    Kirigami.Theme.inherit: true

    ColumnLayout {
        id: column
        anchors.centerIn: parent
        spacing: tightSpacing ? -78 : Kirigami.Units.smallSpacing
        QQC2.Label {
            id: hoursLabel
            text: hoursStr(root.now)
            font.pointSize: 86 * fontScale
            font.family: fontFamily
            font.weight: Font.Bold
            font.letterSpacing: 4
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        QQC2.Label {
            id: minutesLabel
            text: minutesStr(root.now)
            font.pointSize: 86 * fontScale
            font.family: fontFamily
            font.weight: Font.Bold
            font.letterSpacing: 4
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        QQC2.Label {
            id: secondsLabel
            visible: showSeconds
            text: secondsStr(root.now) + (use24h ? "" : (root.now.getHours() < 12 ? " AM" : " PM"))
            opacity: 0.8
            font.pointSize: Kirigami.Theme.defaultFont.pointSize * (fontScale * 0.5)
                font.family: fontFamily
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }
    }

    // Hover + click to open standard clock/calendar popup if available
    PlasmaCore.ToolTipArea {
        anchors.fill: parent
        mainText: Qt.formatDateTime(root.now, Qt.DefaultLocaleLongDate)
    }
}