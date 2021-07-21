using Toybox.Attention;

class UltimateSailingFeedBack {

    /* -- Attributes -- */
    const myLongVibe = [new Attention.VibeProfile(100, 2000)];
    const myShortVibe = [new Attention.VibeProfile(100, 500)];
 

    /* -- Constructor -- */
    function initialize() {
    }

    /* -- Global methods -- */
    function poke(minutes, seconds) {
        if (minutes == 0 && seconds == 0) {
            // Start!
            vibrate(myLongVibe);
            System.println(1);
        } else if (minutes == 0 && seconds <= 5) {
            // Last 5 seconds
            vibrate(myShortVibe);
           	System.println(2);
            
        } else if (minutes == 0 && seconds % 10 == 0) {
            // Every 10 sec the last minute
            vibrate(myShortVibe);
            System.println(3);
            
        } else if (minutes != 5 && seconds == 0) {
            // Every minute
            vibrate(myShortVibe);
            System.println(5);
            
        }
    }

    /* -- Local methods -- */
    function vibrate(vibe) {
        if (Attention has :vibrate) {
            Attention.vibrate(vibe);
        }
    }

}
