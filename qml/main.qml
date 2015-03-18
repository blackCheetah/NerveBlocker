import QtQuick 2.2
import QtQuick.Controls 1.2
import UllApp 1.0

ApplicationWindow {
    property string yellowMain: "#f7e967"
    property string yellowLight: "#fffd89"
    property string blueMain: "#04bfbf"
    property string blueLight: "#1fdada"
    property string backgroundGrey: "#222222"


    visible: true
    width: 533
    height: 800
    title: qsTr("UllApp")
    color: "white"

    FontLoader { id: birdFont; source: "fonts/LittleBird.ttf" }
    FontLoader { id: scoreFont; source: "fonts/whysoserious.ttf" }
    FontLoader { id: orangeFont; source: "fonts/orange.ttf" }
    FontLoader { id: ubuntu; source: "fonts/Ubuntu-R.ttf" }


    StackView {
        id: mainArea
        anchors.fill: parent
        focus: true // important - otherwise we'll get no key events

        //stops animation between stack changes
        delegate: StackViewDelegate {
            pushTransition: StackViewTransition{}
        }

        Component.onCompleted: {
            push(component_mainMenu);
        }

        // Android back-button
        Keys.onReleased: {
           if (event.key === Qt.Key_Back) {
               event.accepted = true;
               mainArea.pop(null);
           }
        }
    }

    Component {
        id: component_GameFinished
        FinishedScreen {
            onMainMenuClicked: {
                mainArea.pop();
                mainArea.pop();
            }
            onPlayAgainClicked: {
                gamehandler.newGame(gamehandler.game.mode);
                mainArea.pop();
                mainArea.pop();
                if(gamehandler.game.mode===Mode.VIDEO){
                    mainArea.push(component_video);
                }
                else{
                    mainArea.push(component_game);
                    mainArea.currentItem.startTimer();
                }
            }
        }
    }

    Component {
        id: component_game
        Game {
            id: gameInstance
            game: gamehandler.game
            onGameMenuClicked: {
                mainArea.pop();
            }
            onGameSummaryClicked: {
                mainArea.push(component_GameFinished);
            }
        }
    }

    Component {
        id: component_instructional
        StartMenuInstruction {
            onBackButtonClicked: {
                mainArea.pop();
            }
        }

    }
    Component {
        id: component_video
        VideoTask {
            onGameMenuClicked: {
                mainArea.pop();
            }
            onGameSummaryClicked: {
                mainArea.push(component_GameFinished);
            }
        }
    }

    Component {
        id: component_annotation
        AnnotationTask {
            onGameMenuClicked: {
                mainArea.pop();
            }
            onGameSummaryClicked: {
                mainArea.push(component_GameFinished);
            }
        }
    }


    Component {
        id: component_mainMenu
        StartMenu {
            id: mainMenu

            onBeginnerClicked: {
                gamehandler.newGame(Mode.NORMAL);
                mainArea.push(component_game);
            }
            onTimedClicked: {
                gamehandler.newGame(Mode.TIMED);
                mainArea.push(component_game);
                mainArea.currentItem.startTimer();
            }
            onTutorialClicked: {
                gamehandler.newGame(Mode.TUTORIAL);
                mainArea.push(component_game);
            }
            onVideoClicked: {
                gamehandler.newGame(Mode.VIDEO);
                mainArea.push(component_video);
            }
            onInstructionalClicked: {
                gamehandler.newGame(Mode.NONE);
                mainArea.push(component_instructional);
            }
            onAnnotationClicked: {
                gamehandler.newGame(Mode.DRAG);
                mainArea.push(component_annotation);
            }
        }
    }

}
