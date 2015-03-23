import QtQuick 2.4

Rectangle {
    signal gameMenuClicked()
    signal gameSummaryClicked()

    property var task: gamehandler.game.currentAnnotationTask
    property bool active: true
    property int commonStartingY: taskImage.height/2

    color: backgroundGrey


    Image {
        id: taskImage
        width: parent.width*11/12
        height: sourceSize.height*width/sourceSize.width
        anchors.bottom: botMenu.top
        anchors.bottomMargin: parent.width/20
        anchors.horizontalCenter: parent.horizontalCenter

        fillMode: Image.PreserveAspectFit
        source: task.imagePath


        //Mapped image
        Image{
            id:mappedImage
            anchors.fill: parent
            source: "gameImages/1_map.png"
        }
        Canvas {
            id: canvas
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect (0, 0, width, height);
                ctx.strokeStyle = "white"
                ctx.lineWidth = parent.height/80
                ctx.beginPath()
                ctx.moveTo(point1.x+point1.width/2,point1.y+point1.height/2)
                ctx.lineTo(point2.x+point2.width/2,point2.y+point2.height/2)
                ctx.lineTo(point3.x+point3.width/2,point3.y+point3.height/2)
                ctx.lineTo(point4.x+point4.width/2,point4.y+point4.height/2)
                ctx.lineTo(point5.x+point5.width/2,point5.y+point5.height/2)

                ctx.stroke()

            }
        }
        Repeater{
            model: 5
            AnnotationPoint {
                y: commonStartingY
                onDragActive: canvas.requestPaint();

            }
        }

        AnnotationPoint {
            id: point1
            x: parent.width/18
            y: commonStartingY
            onDragActive: canvas.requestPaint();

        }
        AnnotationPoint {
            id: point2
            x: parent.width*5/18
            y: commonStartingY
            onDragActive: canvas.requestPaint();

        }
        AnnotationPoint {
            id: point3
            x: parent.width*9/18
            y: commonStartingY
            onDragActive: canvas.requestPaint();

        }
        AnnotationPoint {
            id: point4
            x: parent.width*13/18
            y: commonStartingY
            onDragActive: canvas.requestPaint();
        }
        AnnotationPoint {
            id: point5
            x: parent.width*17/18
            y: commonStartingY
            onDragActive: canvas.requestPaint();
        }

    }


    //MENU button
    MenuButton {
        id: botMenu
        onMenuClicked: {
            gameMenuClicked();
        }
    }

    NextButton {
        id: botNext
        arrowVisible: false;

        onNextClicked: {

            //CONFIRM
            if(active){
                arrowVisible = true;
                active = false;
                /*console.log("x: "+ taskImage.sourceSize.width*point1.x/taskImage.width + " y: " +taskImage.sourceSize.height*point1.y/taskImage.height+"\n");
                console.log("x: "+ taskImage.sourceSize.width*point2.x/taskImage.width + " y: " +taskImage.sourceSize.height*point2.y/taskImage.height+"\n");
                console.log("x: "+ taskImage.sourceSize.width*point3.x/taskImage.width+ " y: " +taskImage.sourceSize.height*point3.y/taskImage.height+"\n");
                console.log("x: "+ taskImage.sourceSize.width*point4.x/taskImage.width+ " y: " +taskImage.sourceSize.height*point4.y/taskImage.height+"\n");
                console.log("x: "+ taskImage.sourceSize.width*point5.x/taskImage.width+ " y: " +taskImage.sourceSize.height*point5.y/taskImage.height+"\n");
           */ }

            //NEXT, Game done
            else {
                gameSummaryClicked();
            }
        }
    }
}

