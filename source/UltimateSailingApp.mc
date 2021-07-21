using Toybox.Application;
using Toybox.WatchUi;

class UltimateSailingApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }
    
    function onStop(state) {
    }
    function getInitialView() {
        var view = new UltimateSailingView();
        var delegate = new UltimateSailingDelegate(view);
        return [ view, delegate ];
    }

}