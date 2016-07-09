<h1>Notenames</h1>

<img src="http://content.screencast.com/users/andresn/folders/Jing/media/18eed7ad-a2dc-4216-97ed-dd2f6dead3df/00000137.png"/>

NOTE: This only works for Musescore 1.3 and below. Also, color and note formatting works for only MuseScore 1.3 and below. Chord names plugin in the above picture also available in this repo [here](https://github.com/andresn/standard-notation-experiments/blob/master/MuseScore/plugins/findharmonies/Readme.md)

<h2>To install plugin:</h2>

<h3>Mac</h3>
On Mac OS X, MuseScore looks for plugins in the MuseScore bundle in /Applications/MuseScore.app/Contents/Resources/plugins and in ~/Library/Application Support/MusE/MuseScore/plugins. To be able to move files in the app bundle, right click (Control-click) on MuseScore.app and choose "Show package contents" to reveal the Contents directory. Be careful to use Contents/Resources/plugins and not Contents/plugins.

<h3>Windows</h3>
MuseScore looks for plugins in %ProgramFiles%\MuseScore\Plugins (resp. %ProgramFiles(x86)%\MuseScore\Plugins for the 64-bit versions) and in %LOCALAPPDATA%\MusE\MuseScore\plugins on Vista and Seven or C:\Documents and Settings\USERNAME\Local Settings\Application Data\MusE\MuseScore\plugins (adjusted to your language version) on XP.

<h3>Linux</h3>
In Linux, MuseScore looks for plugins in /usr/share/mscore-1.2/plugins and in ~/.local/share/data/MusE/MuseScore/plugins.
In any of the above cases, restart MuseScore to allow the new plugin(s) to load.
In MuseScore 2.0+ the plugin then needs to get enabled in Menu -> Edit -> Preferences -> Plugins, followed by another restart.
Prior to MuseScore 2.0 a score needs to be open for the Plugins menu to become available.

Plugin's original instructions (retrieved on 11/2014 for MusesScore 1.3):<br />
https://web.archive.org/web/20141224083216/http://musescore.org/en/handbook/plugins

<h2>Plugin's original repo and description:</h2>
Source: http://musescore.org/project/notenames

This Plugin for MuseScore is derived from the [Note Names plugin] (http://musescore.org/en/handbook/plugins#notenames) that comes as part of MuseScore and is meant to replace that.
It adds the note names of all notes in either the current selection or all voices of all staves in the entire score as staff text (above/below the staff) and uses note names according to the locale MuseScore is configured for rather than just the English note names C, D, E, F, G, A, B.
So the output changes with the setting of Menu -> Edit -> Preferences... -> General -> Language, resp. if that is set to 'System', the output depends on the language setting of your PC.
As a further extensions it also names notes with sharps, double sharps and double flats and the notename moves aside a bit, if it would otherwise collide with the note.

Available locales: English, German, Dutch, Japanese, Italian, French, Spanish, Portuguese, Russian, Romainan, Danish, Norwegian, Swedish, Polish, Slovak, Czech and Greek.

The double sharp and double flat notes as well as Fb, Cb, E# and B# still need translation into Spanish, Portuguese, Russian, Romanian and Greek, help is more than welcome.

If you also want it to show courtesy- and microtonal accidentals, change `false` to `true` in the plugin code. Note however, that none of these have yet been translated, and their 'clear text' names can be rather long (e.g. "mirrored-flat-slash").

If you want a separator different from ",", change the corresponding variable in the plugin code, you can also change it to "\n" to get the note names stacked vertically, but in that case most probably also need to modify the position it gets printed.

To use the plugin, you must first install it according to the [instructions in the Handbook] (https://web.archive.org/web/20141224083216/http://musescore.org/en/handbook/plugins) (retrieved on 11/2014 for Musescore 1.3).

The idea for this plugin stems from a [discussion in the forum] (http://musescore.org/en/node/16786), the microtonal extension from [another discussion in the forum] (http://musescore.org/en/node/16870).

