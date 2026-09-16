import QtQuick 2.0
import Sailfish.Silica 1.0

IconButton
{
    id: root

    // -----------------------------------------------------------------------

    property bool active
    property int direction

    // -----------------------------------------------------------------------

    icon.source: active ? "image://theme/icon-l-pause" : "image://theme/icon-l-play"
    icon.mirror: direction < 0 ? true : false
    icon.rotation: !active && direction < 0 ? 180 : 0
    onClicked:
    {
        if (!settings.animationEnabled || settings.animationDirection === direction)
            settings.animationEnabled = !settings.animationEnabled;

        settings.animationDirection = direction;
        settings.trackNow = false;
    }

    // -----------------------------------------------------------------------

    Image
    {
        id: activeIndicator

        source: "../gfx/play.png"
        anchors { centerIn: parent }
        width: parent.width * 1.15
        height: width
        opacity: root.active ? 0.35 : 0.0

        // fade in/out
        Behavior on opacity
        {
            NumberAnimation
            {
                id: fadeAnimation

                duration: 200
            }
        }
        // rotate while active
        SequentialAnimation on rotation
        {
            running: true
            paused: !root.active || fadeAnimation.running
            loops: Animation.Infinite

            NumberAnimation { from: 0; to: 360 * root.direction; duration: 2000 }
        }
    }
}
