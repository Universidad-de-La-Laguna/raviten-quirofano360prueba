<!DOCTYPE html>
<html lang="es">
<head>

    <title>Tour_Quirofano</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" id="metaViewport" content="user-scalable=no, initial-scale=1, width=device-width, viewport-fit=cover" data-tdv-general-scale="0.5"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <link href="/static/assets/Content/bootstrap.min.css" rel="stylesheet" />
    <script src="/static/assets/Scripts/jquery-3.6.0.min.js"></script>
    <script src="/static/assets/Scripts/bootstrap.min.js"></script>
    <script src="/static/assets/Scripts/jsmain.js"></script>

    <link rel="preload" href="/static/assets/Tour_Quirofano/locale/es.txt?v=1620666713386" as="fetch" crossorigin="anonymous">
    <script>
        fetch('/static/assets/Tour_Quirofano/locale/es.txt?v=1620666713386', {
            method: 'GET',
            credentials: 'include',
            mode: 'cors',
        })
    </script>
    <link rel="stylesheet" href="/static/styles.css">
    <link rel="preload" href="/static/assets/Tour_Quirofano/script.js?v=1620666713386" as="script"/>
    <link rel="preload" href="/static/assets/Tour_Quirofano/media/panorama_510A6D6D_5BB9_3298_41D0_2360519098CF_0/r/2/0_0.jpg?v=1620666713386" as="image"/>
    <link rel="preload" href="/static/assets/Tour_Quirofano/media/panorama_510A6D6D_5BB9_3298_41D0_2360519098CF_0/l/2/0_0.jpg?v=1620666713386" as="image"/>
    <link rel="preload" href="/static/assets/Tour_Quirofano/media/panorama_510A6D6D_5BB9_3298_41D0_2360519098CF_0/u/2/0_0.jpg?v=1620666713386" as="image"/>
    <link rel="preload" href="/static/assets/Tour_Quirofano/media/panorama_510A6D6D_5BB9_3298_41D0_2360519098CF_0/d/2/0_0.jpg?v=1620666713386" as="image"/>
    <link rel="preload" href="/static/assets/Tour_Quirofano/media/panorama_510A6D6D_5BB9_3298_41D0_2360519098CF_0/f/2/0_0.jpg?v=1620666713386" as="image"/>
    <link rel="preload" href="/static/assets/Tour_Quirofano/media/panorama_510A6D6D_5BB9_3298_41D0_2360519098CF_0/b/2/0_0.jpg?v=1620666713386" as="image"/>
    <meta name="description" content="Virtual Tour"/>
    <meta name="theme-color" content="#000000"/>
    <script src="/static/assets/Tour_Quirofano/lib/tdvplayer.js?v=1620666713386"></script>
    <script src="/static/assets/Tour_Quirofano/script.js?v=1620666713386"></script>
    <script type="text/javascript">
        var tour;
        var devicesUrl = {"general":"/static/assets/Tour_Quirofano/script_general.js?v=1620666713386","mobile":"/static/assets/Tour_Quirofano/script_mobile.js?v=1620666713386"};

        (function()
        {
            var deviceType = ['general'];
            if(TDV.PlayerAPI.mobile)
                deviceType.unshift('mobile');
            if(TDV.PlayerAPI.device == TDV.PlayerAPI.DEVICE_IPAD)
                deviceType.unshift('ipad');
            var url;
            for(var i=0; i<deviceType.length; ++i) {
                var d = deviceType[i];
                if(d in devicesUrl) {
                    url = devicesUrl[d];
                    break;
                }
            }
            if(typeof url == "object") {
                var orient = TDV.PlayerAPI.getOrientation();
                if(orient in url) {
                    url = url[orient];
                }
            }
            var link = document.createElement('link');
            link.rel = 'preload';
            link.href = url;
            link.as = 'script';
            var el = document.getElementsByTagName('script')[0];
            el.parentNode.insertBefore(link, el);
        })();

        function loadTour()
        {
            if(tour) return;

            var settings = new TDV.PlayerSettings();
            settings.set(TDV.PlayerSettings.CONTAINER, document.getElementById('viewer'));
            settings.set(TDV.PlayerSettings.WEBVR_POLYFILL_URL, 'static/assets/Tour_Quirofano/lib/WebVRPolyfill.js?v=1620666713386');
            settings.set(TDV.PlayerSettings.HLS_URL, 'static/assets/Tour_Quirofano/lib/Hls.js?v=1620666713386');
            settings.set(TDV.PlayerSettings.QUERY_STRING_PARAMETERS, 'v=1620666713386');

            tour = new TDV.Tour(settings, devicesUrl);
            tour.bind(TDV.Tour.EVENT_TOUR_INITIALIZED, onVirtualTourInit);
            tour.bind(TDV.Tour.EVENT_TOUR_LOADED, onVirtualTourLoaded);
            tour.bind(TDV.Tour.EVENT_TOUR_ENDED, onVirtualTourEnded);
            tour.load();
        }

        function pauseTour()
        {
            if(!tour)
                return;

            tour.pause();
        }

        function resumeTour()
        {
            if(!tour)
                return;

            tour.resume();
        }

        function onVirtualTourInit()
        {
            var updateTexts = function() {
                document.title = this.trans("tour.name")
            };

            tour.locManager.bind(TDV.Tour.LocaleManager.EVENT_LOCALE_CHANGED, updateTexts.bind(tour.locManager));

            if (tour.player.cookiesEnabled)
                enableCookies();
            else
                tour.player.bind('enableCookies', enableCookies);
        }

        function onVirtualTourLoaded()
        {
            disposePreloader();
        }

        function onVirtualTourEnded()
        {

        }

        function enableCookies()
        {

        }

        function setMediaByIndex(index) {
            if(!tour)
                return;

            tour.setMediaByIndex(index);
        }

        function setMediaByName(name)
        {
            if(!tour)
                return;

            tour.setMediaByName(name);
        }

        function showPreloader()
        {
            var preloadContainer = document.getElementById('preloadContainer');
            if(preloadContainer != undefined)
                preloadContainer.style.opacity = 1;
        }

        function disposePreloader()
        {
            var preloadContainer = document.getElementById('preloadContainer');
            if(preloadContainer == undefined)
                return;

            var transitionEndName = transitionEndEventName();
            if(transitionEndName)
            {
                preloadContainer.addEventListener(transitionEndName, hide, false);
                preloadContainer.style.opacity = 0;
                setTimeout(hide, 500); //Force hide. Some cases the transitionend event isn't dispatched with an iFrame.
            }
            else
            {
                hide();
            }

            function hide()
            {

                preloadContainer.style.visibility = 'hidden';
                preloadContainer.style.display = 'none';
                var videoList = preloadContainer.getElementsByTagName("video");
                for(var i=0; i<videoList.length; ++i)
                {
                    var video = videoList[i];
                    video.pause();
                    while (video.children.length)
                        video.removeChild(video.children[0]);
                }
            }

            function transitionEndEventName () {
                var el = document.createElement('div');
                var transitions = {
                    'transition':'transitionend',
                    'OTransition':'otransitionend',
                    'MozTransition':'transitionend',
                    'WebkitTransition':'webkitTransitionEnd'
                };

                var t;
                for (t in transitions) {
                    if (el.style[t] !== undefined) {
                        return transitions[t];
                    }
                }

                return undefined;
            }
        }

        function onBodyClick(){
            document.body.removeEventListener("click", onBodyClick);
            document.body.removeEventListener("touchend", onBodyClick);

        }

        function onLoad() {
            if (/AppleWebKit/.test(navigator.userAgent) && /Mobile\/\w+/.test(navigator.userAgent))
            {
                var inIFrame = false;
                try
                {
                    inIFrame = (window.self !== window.top);
                }
                catch (e)
                {
                    inIFrame = true;
                }
                if (!inIFrame)
                {
                    var onResize = function(async)
                    {
                        [0, 250, 1000, 2000].forEach(function(delay)
                        {
                            setTimeout(function()
                            {
                                var viewer = document.querySelector('#viewer');
                                var scale = window.innerWidth / document.documentElement.clientWidth;
                                var width = document.documentElement.clientWidth;
                                var height = Math.round(window.innerHeight / scale);
                                viewer.style.width = width + 'px';
                                viewer.style.height = height + 'px';
                                viewer.style.left = Math.round((window.innerWidth - width) * 0.5) + 'px';
                                viewer.style.top = Math.round((window.innerHeight - height) * 0.5) + 'px';
                                viewer.style.transform = 'scale(' + scale + ', ' + scale + ')';
                                window.scrollTo(0,0);
                            }, delay);
                        });
                    };
                    var onTouchEnd = function()
                    {
                        document.body.removeEventListener("touchend", onTouchEnd);
                        clearInterval(resizeIntervalId);
                        onResize();
                        if (/CriOS/.test(navigator.userAgent))
                            setInterval(onResize, 4000);
                    };
                    document.body.addEventListener("touchend", onTouchEnd);
                    var resizeIntervalId = setInterval(onResize, 300);
                    window.addEventListener('resize', onResize);
                    onResize();
                }
            }

            var params = getParams(location.search.substr(1));
            if(params.hasOwnProperty("skip-loading"))
            {
                loadTour();
                disposePreloader();
                return;
            }

            if (isOVRWeb()){
                showPreloader();
                loadTour();
                return;
            }

            showPreloader();
            loadTour();
        }

        function playVideo(video) {
            function isSafariDesktopV11orGreater() {
                return /^((?!chrome|android|crios|ipad|iphone).)*safari/i.test(navigator.userAgent) && parseFloat(/Version\/([0-9]+\.[0-9]+)/i.exec(navigator.userAgent)[1]) >= 11;
            }

            function hasAudio (video) {
                return video.mozHasAudio ||
                    Boolean(video.webkitAudioDecodedByteCount) ||
                    Boolean(video.audioTracks && video.audioTracks.length);
            }

            function detectUserAction() {
                var onVideoClick = function(e) {
                    if(video.paused) {
                        video.play();
                    }
                    video.muted = false;
                    if(hasAudio(video))
                    {
                        e.stopPropagation();
                        e.stopImmediatePropagation();
                        e.preventDefault();
                    }

                    video.removeEventListener('click', onVideoClick);
                    video.removeEventListener('touchend', onVideoClick);
                };
                video.addEventListener("click", onVideoClick);
                video.addEventListener("touchend", onVideoClick);
            }

            if (isSafariDesktopV11orGreater()) {
                video.muted = true;
                video.play();
            } else {
                var canPlay = true;
                var promise = video.play();
                if (promise) {
                    promise.catch(function() {
                        video.muted = true;
                        video.play();
                        detectUserAction();
                    });
                } else {
                    canPlay = false;
                }

                if (!canPlay || video.muted) {
                    detectUserAction();
                }
            }
        }

        function isOVRWeb(){
            return window.location.hash.substring(1).split('&').indexOf('ovrweb') > -1;
        }

        function getParams(params) {
            var queryDict = {}; params.split("&").forEach(function(item) {var k = item.split("=")[0], v = decodeURIComponent(item.split("=")[1]);queryDict[k.toLowerCase()] = v});
            return queryDict;
        }

        document.addEventListener('DOMContentLoaded', onLoad);
    </script>
    <style type="text/css">
        html, body { width: 100%; height: 100%; margin: 0; padding: 0; padding: env(safe-area-inset-top) env(safe-area-inset-right) env(safe-area-inset-bottom) env(safe-area-inset-left); }

        #viewer { z-index:1; position:absolute; width: 100%; height: 100%; top: 0; }
        #preloadContainer { z-index:2; position:relative; width:100%; height:100%; opacity:0; background-color:rgba(0,0,0,1); transition: opacity 0.5s; -webkit-transition: opacity 0.5s; -moz-transition: opacity 0.5s; -o-transition: opacity 0.5s;}
    </style>

</head>
<body>
<div id="preloadContainer"><div style="z-index: 4; position: absolute; left: 0%; top: 50%; width: 100.00%; height: 10.00%"><div style="text-align:left; color:#000; "><DIV STYLE="text-align:center;font-size:1.6666666666666663vmin;"><SPAN STYLE="display:inline-block; letter-spacing:0vmin; white-space:pre-wrap;color:#777777;font-size:1.67vmin;font-family:Arial, Helvetica, sans-serif;">Loading virtual tour. Please wait...</SPAN></DIV></div></div></div>
<div id="viewer"></div>
</body>
</html>