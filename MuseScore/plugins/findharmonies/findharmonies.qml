import QtQuick 2.0
import MuseScore 1.0

MuseScore {

   version: "2.0"
   description: qsTr("This plugin adds basic chord names where it finds harmonies")
   menuPath: "Plugins.Notes." + qsTr("Find Harmonies")

   onRun: {

      if (typeof curScore === 'undefined') {
         Qt.quit();
      }

      var erkannt=0;
      var cursor = curScore.newCursor();

      for (var staff = 0; staff < curScore.nstaves; ++staff) {

         cursor.staff = staff;
         cursor.voice = 0;
         cursor.rewind(1);  // set cursor to first chord/rest
         while (!cursor.eos()) {

            if (cursor.isChord()) {

               var chord = cursor.chord();
               var text = null;

               if (chord.notes == 3) {

                  var grundton=chord.note(0).pitch;
                  var diff1=chord.note(1).pitch-grundton;
                  var diff2=chord.note(2).pitch-grundton;

                  if ((diff1==4)&&(diff2==7)) { //Dur-Akkord // en-US: n/a (guess: stop chord?)
                     ++erkannt;
                     text  = new Text(curScore);
                     text.text = tone(grundton%12);
                  }
                  if ((diff1==5)&&(diff2==9)){ //Dur-Akkord 1. Umkehrung // en-US: reversal
                     ++erkannt;
                     text  = new Text(curScore);
                     text.text = tone((grundton+5)%12)+"\u00B9";
                  }
                  if ((diff1==3)&&(diff2==8)){ //Dur-Akkord 2. Umkehrung // en-US: 2. reversal
                     ++erkannt;
                     text  = new Text(curScore);
                     text.text = tone((grundton+8)%12)+"\u00B2";
                  }
                  if ((diff1==3)&&(diff2==7)){ //Moll-Akkord // en-US: minor chord
                     ++erkannt;
                     text  = new Text(curScore);
                     text.text = tone(grundton%12)+"m";
                  }
                  if ((diff1==5)&&(diff2==8)){ //Moll-Akkord 1. Umkehrung // en-US: minor chord 1. reversal
                     ++erkannt;
                     text  = new Text(curScore);
                     text.text = tone((grundton+5)%12)+"m" + "\u00B9";
                  }
                  if ((diff1==4)&&(diff2==9)){ //Moll-Akkord 2. Umkehrung 
                                    // en-US: minor chord 1. reversal
                     ++erkannt;
                     text  = new Text(curScore);
                     text.text = tone((grundton+9)%12)+"m" + "\u00B2";
                  }
               } // end if chord.notes == 3

               if (chord.notes == 4) {

                  var grundton=chord.note(0).pitch;
                  var diff1=chord.note(1).pitch-grundton;
                  var diff2=chord.note(2).pitch-grundton;
                  var diff3=chord.note(3).pitch-grundton;

                  if ((diff1==4)&&(diff2==7)&&(diff3==10)) { //Septime-Akkord
                                        // en-US: n/a (guess: 7th chord)
                     ++erkannt;
                     text  = new Text(curScore);
                     text.text = tone(grundton%12)+"7";
                  }

                  if ((diff1==2)&&(diff2==6)&&(diff3==9)) { //Septime-Akkord 1. Umkehrung
                                                // en-US: n/a (guess: 7th chord) 1. reversal
                     ++erkannt;
                     text  = new Text(curScore);
                     text.text = tone((grundton+2)%12)+"7" + "\u00B9";
                  }

                  if ((diff1==3)&&(diff2==5)&&(diff3==9)) { //Septime-Akkord 2. Umkehrung
                                                // en-US: n/a (guess: 7th chord?) 1. reversal
                     ++erkannt;
                     text  = new Text(curScore);
                     text.text = tone((grundton+5)%12)+"7" + "\u00B2";
                  }

                  if ((diff1==3)&&(diff2==6)&&(diff3==8)) { //Septime-Akkord 3. Umkehrung
                                               // en-US: n/a (guess: 7th chord?) 1. reversal
                     ++erkannt;
                     text  = new Text(curScore);
                     text.text = tone((grundton+8)%12)+"7" + "\u00B3";
                  }

               } // end if chord.notes == 4

               /* Style and position chord names */
               if(text !== null) {
                  text.yOffset = -8;
                  text.defaultFont = new QFont("Arial", 8);
                  text.color = new QColor(255, 106, 0);

                  cursor.putStaffText(text);
               }

            } // end cursor.isChord()

            cursor.next();
         } // end while !cursor.eos()

      } // end for var staff = 0; staff < curScore.staves; ++staff, next staff

/*
      mb = new QMessageBox();
      mb.setWindowTitle("MuseScore: Harmony Names");
      mb.text=erkannt+" harmonies found";
      mb.exec();
*/

      Qt.quit();
   } // end onRun

   function tone(halbton) {
      var ton="?";
      if (halbton==0){
         ton="C";
      }
      if (halbton==1){
         ton="Db";
      }
      if (halbton==2){
         ton="D";
      }
      if (halbton==3){
         ton="Eb";
      }
      if (halbton==4){
         ton="E";
      }
      if (halbton==5){
         ton="F";
      }
      if (halbton==6){
         ton="Gb";
      }
      if (halbton==7){
         ton="G";
      }
      if (halbton==8){
         ton="Ab";
      }
      if (halbton==9){
         ton="A";
      }
      if (halbton==10){
         ton="Bb";
      }
      if (halbton==11){
         ton="B";
      }

      return(ton);
   } // end tone
}