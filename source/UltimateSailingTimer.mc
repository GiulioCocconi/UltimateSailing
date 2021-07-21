using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;

class UltimateSailingTimer {

    /* -- Attributes -- */    
    var status;
    var minutes2start;
	var time2start;
	
    /* -- Constructor -- */
    function initialize() {
    	minutes2start = 5;
        reset();
    }
    
    function reset() {
    	status = 1;
    	time2start = minutes2start * Gregorian.SECONDS_PER_MINUTE;
    	pause();
  	}
  	
    /* -- Global methods -- */
    function togglePause() {
        if (isPaused()) { // Se è in pausa, resume
            resume();
        } else if (isCountingDown()) { // Se è in corso il countdown metti in pausa
            pause();
        } else { // Se sei in gara, porta lo stato a countdown e metti in pausa
        	reset();
       	}
    }

	function specialAction() {
		if (isCountingDown()) {
			syncDown();
		} else {
			if (minutes2start == 5) { minutes2start = 2; }
			else if (minutes2start == 2) { minutes2start = 3; }
			else if (minutes2start == 3) { minutes2start = 5; }
			reset();
		}
	}
	
    function pause() {
        status = 0;
    }

    function resume() {
		status = 1;
    }

	function setTime(min, sec) {
		time2start = min * Gregorian.SECONDS_PER_MINUTE + sec;
		if (time2start < 0) {
			time2start = 0;
		}
	}
	
	function syncDown() {
		setTime(getMinutes(), 0);
	}
	
    function getDuration() {
        return time2start;
    }

    function getSeconds() {
        return getDuration().abs() % Gregorian.SECONDS_PER_MINUTE;
    }

    function getMinutes() {
        return Math.floor(getDuration().abs() / Gregorian.SECONDS_PER_MINUTE);
    }

    function isPaused() {
        return status == 0;
    }
    
    function isCountingDown() {
        return status == 1;
    }
    
    function isRacing() {
    	return status == 2;
   }

	function countdown() {
		if (!isPaused()) {
			if (getDuration() > 0) {
				time2start -= 1;
			} else {
				time2start = 0;
				status = 2;
			}
		}
	}
}