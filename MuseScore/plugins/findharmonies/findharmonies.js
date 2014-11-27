
//
// This is ECMAScript code (ECMA-262 aka "Java Script")
//


//---------------------------------------------------------
//    init
//    this function will be called on startup of mscore
//---------------------------------------------------------

function init() {
  // print("Find harmonies plugin");
}

//-------------------------------------------------------------------
//    run
//    this function will be called when activating the
//    plugin menu entry
//
//    global Variables:
//    pluginPath - contains the plugin path; file separator is "/"
//-------------------------------------------------------------------

function run(){
  var erkannt=0
  var cursor = new Cursor(curScore);
  for (var staff = 0; staff < curScore.staves; ++staff) {
    cursor.staff = staff;
    cursor.voice = 0;
    cursor.rewind();  // set cursor to first chord/rest
    while (!cursor.eos()) {
      if (cursor.isChord()) {
        var chord = cursor.chord();
        if (chord.notes == 3) {
          var grundton=chord.note(0).pitch;
          var diff1=chord.note(1).pitch-grundton;
          var diff2=chord.note(2).pitch-grundton;
          if ((diff1==4)&&(diff2==7)){ //Dur-Akkord // en-US: n/a (guess: stop chord?)
            ++erkannt;
            var text  = new Text(curScore);
            text.text = tone(grundton%12);
            cursor.putStaffText(text);
          }
          if ((diff1==5)&&(diff2==9)){ //Dur-Akkord 1. Umkehrung // en-US: reversal
            ++erkannt;
            var text  = new Text(curScore);
            text.text = tone((grundton+5)%12)+"¹";
            cursor.putStaffText(text);
          }
          if ((diff1==3)&&(diff2==8)){ //Dur-Akkord 2. Umkehrung // en-US: 2. reversal
            ++erkannt;
            var text  = new Text(curScore);
            text.text = tone((grundton+8)%12)+"²";
            cursor.putStaffText(text);
          }
          if ((diff1==3)&&(diff2==7)){ //Moll-Akkord // en-US: minor chord
            ++erkannt;
            var text  = new Text(curScore);
            text.text = tone(grundton%12)+"m";
            cursor.putStaffText(text);
          }
          if ((diff1==5)&&(diff2==8)){ //Moll-Akkord 1. Umkehrung // en-US: minor chord 1. reversal
            ++erkannt;
            var text  = new Text(curScore);
            text.text = tone((grundton+5)%12)+"m¹";
            cursor.putStaffText(text);
          }
          if ((diff1==4)&&(diff2==9)){ //Moll-Akkord 2. Umkehrung 
                                       // en-US: minor chord 1. reversal
            ++erkannt;
            var text  = new Text(curScore);
            text.text = tone((grundton+9)%12)+"m²";
            cursor.putStaffText(text);
          }
        }
        if (chord.notes == 4) {
          var grundton=chord.note(0).pitch;
          var diff1=chord.note(1).pitch-grundton;
          var diff2=chord.note(2).pitch-grundton;
          var diff3=chord.note(3).pitch-grundton;
          if ((diff1==4)&&(diff2==7)&&(diff3==10)){ //Septime-Akkord
                                                    // en-US: n/a (guess: 7th chord?)
            ++erkannt;
            var text  = new Text(curScore);
            text.text = tone(grundton%12)+"7";
            cursor.putStaffText(text);
          }
          if ((diff1==2)&&(diff2==6)&&(diff3==9)){ //Septime-Akkord 1. Umkehrung
                                                   // en-US: n/a (guess: 7th chord?) 1. reversal
            ++erkannt;
            var text  = new Text(curScore);
            text.text = tone((grundton+2)%12)+"7¹";
            cursor.putStaffText(text);
          }
          if ((diff1==3)&&(diff2==5)&&(diff3==9)){ //Septime-Akkord 2. Umkehrung
                                                   // en-US: n/a (guess: 7th chord?) 1. reversal
            ++erkannt;
            var text  = new Text(curScore);
            text.text = tone((grundton+5)%12)+"7²";
            cursor.putStaffText(text);
          }
          if ((diff1==3)&&(diff2==6)&&(diff3==8)){ //Septime-Akkord 3. Umkehrung
                                                  // en-US: n/a (guess: 7th chord?) 1. reversal
            ++erkannt;
            var text  = new Text(curScore);
            text.text = tone((grundton+8)%12)+"7³";
            cursor.putStaffText(text);
          }
        }
      }
      cursor.next();
    }
  } //Next staff
  mb = new QMessageBox();
  mb.setWindowTitle("MuseScore: Harmony Names");
  mb.text=erkannt+" harmonies found";
  mb.exec();
}


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
}



//---------------------------------------------------------
//    menu:  defines were the function will be placed
//           in the MuseScore menu structure
//---------------------------------------------------------

var mscorePlugin = {
  menu: 'Plugins.Find harmonies',
  init: init,
  run:  run
};

mscorePlugin;