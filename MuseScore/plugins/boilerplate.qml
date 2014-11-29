import QtQuick 2.0
import MuseScore 1.0

MuseScore {
   menuPath: "Plugins.colornotes"

   onRun: {
      console.log("hello plugin developer");
      var cursor = curScore.newCursor();
      Qt.quit()
   }
}