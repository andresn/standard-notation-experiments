import QtQuick 2.0
import MuseScore 1.0

MuseScore {

    version: "2.0"
    description: qsTr("This plugin adds the name of a chord based on ")
    menuPath: "Plugins.Chords." + qsTr("Name Chords") // this does not work, why?

    function getChordName (notes) {

        var rootNote = null,
            inversion = null,
            inversions = ["\u00B9", "\u00B2"], // unicode for superscript "1", "2" (e.g. to represent C Major first, or second inversion)
            chordName = '',
            form = '',
            firstNote = notes[0],
            firstNotePitch = firstNote.pitch,
            intervals;

        if(notes.length === 3) {

            intervals = [ notes[1].pitch - firstNotePitch, notes[2].pitch - firstNotePitch ];

            console.log("notes[0]: ");
            console.log(notes[0]);
            console.log("notes[0].pitch: ");
            console.log(notes[0].pitch);
            console.log("notes[1].pitch: ");
            console.log(notes[1].pitch);
            console.log("notes[2].pitch: ");
            console.log(notes[2].pitch);

            console.log("firstNote: ");
            console.log(firstNote);
            console.log("notes[1].pitch - firstNotePitch: ");
            console.log(notes[1].pitch - firstNotePitch);
            console.log("intervals[0]: ");
            console.log(intervals[0]);
            console.log("intervals[1]: ");
            console.log(intervals[1]);

            /* Major chord */
            if(intervals[0] === 4 && intervals[1] === 7) {
                rootNote = notes[0];
            }

            /* ... first inversion */
            if(intervals[0] === 3 && intervals[1] === 8) {
                rootNote = notes[2];
                inversion = 0;
            }

            /* ... second inversion */
            if(intervals[0] === 5 && intervals[1] === 9) {
                rootNote = notes[1];
                inversion = 1;
            }

            /* Minor chord */
            if(intervals[0] === 3 && intervals[1] === 7) {
                rootNote = notes[0];
                form = 'm';
            }

            /* ... first inversion */
            if(intervals[0] === 4 && intervals[1] === 9) {
                rootNote = notes[2];
                inversion = 0;
                form = 'm';
            }

            /* ... second inversion */
            if(intervals[0] === 5 && intervals[1] === 8) {
                rootNote = notes[1];
                inversion = 1;
                form = 'm';
            }

        }

        console.log('what root?');
        console.log(rootNote);

        if(rootNote !== null) {
            chordName = getNoteName(rootNote) + form;
        }

        if(chordName !== '' && inversion !== null) {
            chordName += inversions[inversion];
        }

        console.log('chordName: ');
        console.log(chordName);
        console.log('notes[0]: ');
        console.log(getNoteName(notes[0]));
        console.log('notes[1]: ');
        console.log(getNoteName(notes[1]));
        console.log('notes[2]: ');
        console.log(getNoteName(notes[2]));

        return chordName;

    }

    function getNoteName(note) {

        var noteName = '';

        if (typeof note.tpc === 'undefined') { // like for grace notes ?!?
            return;
        }

        switch (note.tpc) {

            case  6: noteName = qsTr("Fb"); break;
            case  7: noteName = qsTr("Cb"); break;
            case  8: noteName = qsTr("Gb"); break;
            case  9: noteName = qsTr("Db"); break;
            case 10: noteName = qsTr("Ab"); break;
            case 11: noteName = qsTr("Eb"); break;
            case 12: noteName = qsTr("Bb"); break;
            case 13: noteName = qsTr("F") ; break;
            case 14: noteName = qsTr("C") ; break;
            case 15: noteName = qsTr("G") ; break;
            case 16: noteName = qsTr("D") ; break;
            case 17: noteName = qsTr("A") ; break;
            case 18: noteName = qsTr("E") ; break;
            case 19: noteName = qsTr("B") ; break;
            case 20: noteName = qsTr("F#"); break;
            case 21: noteName = qsTr("C#"); break;
            case 22: noteName = qsTr("G#"); break;
            case 23: noteName = qsTr("D#"); break;
            case 24: noteName = qsTr("A#"); break;
            case 25: noteName = qsTr("E#"); break;
            case 26: noteName = qsTr("B#"); break;

            default: noteName = qsTr(""); break;

        } // end switch tpc

        return noteName;

    }

    onRun: {

        if (typeof curScore === 'undefined') {
            Qt.quit();
        }

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

                    // console.log('cursor.element.notes.length: ' + cursor.element.notes.length);

                    if (
                        cursor.element &&
                        cursor.element.type === Element.CHORD &&
                        cursor.element.notes &&
                        ( cursor.element.notes.length === 3 || cursor.element.notes.length === 4 )
                    ) {

                        var staffText,
                            chordName = getChordName(cursor.element.notes);

                        console.log('chordName: ');
                        console.log(chordName);

                        if(chordName !== '') {
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