/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 * 
 *   Altereções para adaptação feitas por Juliano da Silva
 *   Criciuma/SC
 *   14-04-2019
 */

import QtQuick 2.5
import QtGraphicalEffects 1.0

Image {
    id: root
    source: "images/background.jpg"
    fillMode: Image.PreserveAspectCrop
    
    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }
        
        FontLoader {
         source: "../components/artwork/fonts/OpenSans-Light.ttf"
        }

        Text {
            id: date
            text:Qt.formatDateTime(new Date(),"dddd, hh:mm")
            font.pointSize: 32
            color: "#FFFFFF"
            opacity:0.95
            font { family: "OpenSans Light"; weight: Font.Light ;capitalization: Font.Capitalize}
            anchors.horizontalCenter: parent.horizontalCenter
            y: (parent.height - height) / 2.7
        }

        Image {
            id: logo
            property real size: units.gridUnit * 5
            anchors.centerIn: parent

            source: "images/tardis.svg"
            opacity: 1.0
            sourceSize.height: size
            sourceSize.width: size
            
            RotationAnimator on rotation {
                id: rotationAnimator1
                from: 0
                to: 360
                duration: 2500
                loops: Animation.Infinite
            }
            
            ParallelAnimation {
                ScaleAnimator  {
                    target: logo
                    from: 3
                    to: 0
                    duration: 3000
                    easing.type: Easing.OutInQuad
                    loops: Animation.Infinite
                }
                running: true
            }
        }
        
        Row {
            spacing: units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                right: parent.right
                rightMargin: units.gridUnit * 1.5
                margins: units.gridUnit
            }
            Image {
                source: "images/dr_who_banner.png"
                sourceSize.height: units.gridUnit * 10
                sourceSize.width: units.gridUnit * 10
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 200
        easing.type: Easing.InOutQuad
    }
}
