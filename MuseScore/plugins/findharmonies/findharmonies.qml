import QtQuick 2.0
import MuseScore 1.0

MuseScore {
   version: "2.0"
   description: qsTr("This plugin adds the name of a chord based on ")
   menuPath: "Plugins.Chords." + qsTr("Name Chords") // this does not work, why?

   function getChordName (rootNote) {

         var text = '';

         if (typeof rootNote.tpc === "undefined") { // like for grace notes ?!?
            return;
         }

         switch (rootNote.tpc) {

            case  6: text = qsTr("Fb"); break;
            case  7: text = qsTr("Cb"); break;
            case  8: text = qsTr("Gb"); break;
            case  9: text = qsTr("Db"); break;
            case 10: text = qsTr("Ab"); break;
            case 11: text = qsTr("Eb"); break;
            case 12: text = qsTr("Bb"); break;
            case 13: text = qsTr("F") ; break;
            case 14: text = qsTr("C") ; break;
            case 15: text = qsTr("G") ; break;
            case 16: text = qsTr("D") ; break;
            case 17: text = qsTr("A") ; break;
            case 18: text = qsTr("E") ; break;
            case 19: text = qsTr("B") ; break;
            case 20: text = qsTr("F#"); break;
            case 21: text = qsTr("C#"); break;
            case 22: text = qsTr("G#"); break;
            case 23: text = qsTr("D#"); break;
            case 24: text = qsTr("A#"); break;
            case 25: text = qsTr("E#"); break;
            case 26: text = qsTr("B#"); break;

            default: text = qsTr(""); break;

         } // end switch tpc

      return text;
   }

   onRun: {

      if (typeof curScore === 'undefined')
         Qt.quit();

      var cursor = curScore.newCursor(),
          startStaff,
          endStaff,
          endTick,
          fullScore = false;

      cursor.rewind(1);

      if (!cursor.segment) { // no selection
         fullScore = true;
         startStaff = 0; // start with 1st staff
         endStaff  = curScore.nstaves - 1; // and end with last
      } else {

         startStaff = cursor.staffIdx;
         cursor.rewind(2);

         if (cursor.tick === 0) {
            // this happens when the selection includes
            // the last measure of the score.
            // rewind(2) goes behind the last segment (where
            // there's none) and sets tick=0
            endTick = curScore.lastSegment.tick + 1;
         } else {
            endTick = cursor.tick;
         }

         endStaff = cursor.staffIdx;
      }

      // console.log('startStaff: ' + startStaff);
      // console.log('endStaff: ' + endStaff);
      // console.log('curScore.nstaves: ' + curScore.nstaves);
      // console.log('endTick: ' + endTick);
      // console.log('cursor.tick: ' + cursor.tick);
      // console.log('curScore.lastSegment.tick: ' + curScore.lastSegment.tick);

      for (var staff = startStaff; staff <= endStaff; staff++) {

         // console.log('staff: ');
         // console.log(staff);

         for (var voice = 0; voice < 4; voice++) {

            // console.log('### Voice: ');
            // console.log(voice);

            cursor.rewind(1); // beginning of selection
            cursor.voice = voice;
            cursor.staffIdx = staff;

            if (fullScore) { // no selection
               cursor.rewind(0); // beginning of score
            }

            while (cursor.segment && (fullScore || cursor.tick < endTick)) {

               // console.log('while');
               // console.log('cursor.segment: ' + cursor.segment);
               // console.log('cursor.segment.tick: ' + cursor.segment.tick);
               // console.log('cursor.segment.type: ' + cursor.segment.type);
               // console.log('cursor.tick: ' + cursor.tick);
               // console.log('endTick: ' + endTick);

               if (cursor.element && cursor.element.type === Element.CHORD) {

                  console.log('cursor.element.notes.length: ' + cursor.element.notes.length);

                  var notes = cursor.element.notes,
                      staffText,
                      chordName = null;

                  if(notes.length === 3) {
                     var rootNote = notes[0],
                         rootNotePitch = rootNote.pitch,
                         intervals = [ notes[1].pitch - rootNotePitch, notes[2].pitch - rootNotePitch ];

                     console.log("notes[0]: ");
                     console.log(notes[0]);
                     console.log("notes[0].pitch: ");
                     console.log(notes[0].pitch);
                     console.log("notes[1].pitch: ");
                     console.log(notes[1].pitch);
                     console.log("notes[2].pitch: ");
                     console.log(notes[2].pitch);

                     console.log("rootNote: ");
                     console.log(rootNote);
                     console.log("notes[1].pitch - rootNotePitch: ");
                     console.log(notes[1].pitch - rootNotePitch);
                     console.log("intervals[0]: ");
                     console.log(intervals[0]);
                     console.log("intervals[1]: ");
                     console.log(intervals[1]);
                     
                     if(intervals[0] === 4 && intervals[1] === 7) {
                        chordName = getChordName(rootNote);
                     }
                     
                  }

                  console.log('chordName: ');
                  console.log(chordName);

                  if(chordName !== null) {
                     staffText = newElement(Element.STAFF_TEXT);
                     staffText.text = chordName;
                     staffText.pos.x = 1;
                     cursor.add(staffText);
                  }

               } // end if CHORD

               cursor.next();
            } // end while segment
         } // end for voice
      } // end for staff

      Qt.quit();
   } // end onRun
}