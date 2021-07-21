using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;

class UltimateSailingDelegate extends Ui.BehaviorDelegate {

	var myView;
    var myRaceTimer;
    var myTimer;
	var myFeedBack;
	
    function initialize(view) {
        BehaviorDelegate.initialize();
        myView = view;
        
        myRaceTimer = new UltimateSailingTimer();
        
        myFeedBack = new UltimateSailingFeedBack();
        
        myTimer = new Timer.Timer();
        myTimer.start(method(:timerCallback), 1000, true);        
    }
    
    
    /* -- Overridden methods -- */
    function onMenu() {
        return true;
    }

    function onBack() {
        Ui.popView(Ui.SLIDE_RIGHT);
        return true;
    }

    function onSelect() { //This is typically triggered by the Start/Enter button (KEY_ENTER) or by a CLICK_TYPE_TAP ClickEvent on a touch screen.
        myRaceTimer.togglePause();

        updateRaceTimer();
        Ui.requestUpdate();
        return true;
    }

    function onPreviousPage() {  //This is typically triggered by the up button (KEY_UP) or by a SWIPE_DOWN SwipeEvent on a touch screen.
		myRaceTimer.reset();
        updateRaceTimer();
		Ui.requestUpdate();
    }

    function onNextPage() { //This is typically triggered by the down button (KEY_DOWN) or by a SWIPE_UP SwipeEvent on a touch screen.
		myRaceTimer.specialAction();
        updateRaceTimer();
        Ui.requestUpdate();
    }

    /* -- Local methods -- */
    function timerCallback() {
        var now = Time.now();

        var info = Gregorian.info(now, Time.FORMAT_SHORT);
        var timeString = Lang.format(
            "$1$:$2$:$3$",
            [
                info.hour.format("%.2d"),
                info.min.format("%.2d"),
                info.sec.format("%.2d")
            ]
        );
        myView.findDrawableById("topLabel").setText(timeString);

        updateRaceTimer();

        Ui.requestUpdate();
    }

    function updateRaceTimer() {
        var minutes = myRaceTimer.getMinutes();
        var seconds = myRaceTimer.getSeconds();
        var timerString = Lang.format(
                "$1$:$2$",
                [minutes.format("%.2d"), seconds.format("%.2d")]
        );
        
        if (myRaceTimer.isCountingDown()) {
        	myFeedBack.poke(minutes, seconds);
        }
        
        myView.findDrawableById("centerLabel").setText(timerString);
        myRaceTimer.countdown();
    }

}