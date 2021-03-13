import QtQuick 2.0
import QtMultimedia 5.12

Item {
    id: r
    width: 640
    height: 360

    Camera {
        id: camera

        imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

        exposure {
            exposureCompensation: -1.0
            exposureMode: Camera.ExposurePortrait
        }

        flash.mode: Camera.FlashRedEyeReduction

        imageCapture {
            onImageCaptured: {
                photoPreview.source = preview  // Show the preview in an Image
            }
        }
    }
    MediaPlayer{
        id: mpc
        source: '/dev/video0'
        autoLoad: true
        autoPlay: true

    }

    VideoOutput {
        source: mpc//camera
        anchors.fill: parent
        focus : visible // to receive focus and capture key events when visible
    }

    Image {
        id: photoPreview
    }
    Component.onCompleted: {
        console.log('Camara Hablititada: '+camera.availability)
    }
}
