import QtQuick 
import org.kde.plasma.configuration 

ConfigModel {
    ConfigCategory {
        id: configModel


        name: "General"
        icon: "configure"
        source: "config/ConfigGeneral.qml"
    }
}