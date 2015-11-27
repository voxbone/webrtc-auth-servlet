<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>

    <!-- This generates the secure token and populates it in the variable voxrtc_config -->
    <script src="auth" type="text/javascript"></script>

    <script src="https://webrtc.voxbone.com/js/jssip-0.7.9-vox.js" type="text/javascript"></script>
    <script src="https://webrtc.voxbone.com/js/voxbone-0.0.3.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

    <script>
        // Register callbacks to desired call events
        var eventHandlers = {
            'progress':   function(e){ document.getElementById("status_message").innerHTML="Dialing 883510080143";},
            'getUserMediaFailed':     function(e){ document.getElementById("status_message").innerHTML="Failed to access mic/camera"; },
            'failed':     function(e){ document.getElementById("status_message").innerHTML="Failed to Connect"; },
            'accepted':    function(e){ document.getElementById("status_message").innerHTML="<b><font color='green'>In Call</font></b>"; },
            'ended':      function(e){ document.getElementById("status_message").innerHTML="<b><font color='red'>Call Ended</font></b>"; },
            'localMediaVolume':     function(e){ 
			document.getElementById('volume').value = e.localVolume;
	     },
        };





        /** This part is required as it handle Voxbone WebRTC initialization **/
        function init(){


            // Force the preferedPop to BE.
            //This can be usefull if you need  to get your webrtc calls troubleshooted
            //If this is not set, a ping to each pop will be issued to determine which is the most optimal for the user
            //Default is to use the ping mechanism to determine the preferedPop.
            //voxbone.WebRTC.preferedPop = 'BE';

            // set custom event handlers
            voxbone.WebRTC.customEventHandler.progress = eventHandlers.progress;
            voxbone.WebRTC.customEventHandler.failed = eventHandlers.failed;
            voxbone.WebRTC.customEventHandler.accepted = eventHandlers.accepted;
            voxbone.WebRTC.customEventHandler.ended = eventHandlers.ended;
            voxbone.WebRTC.customEventHandler.getUserMediaFailed = eventHandlers.getUserMediaFailed;
            voxbone.WebRTC.customEventHandler.localMediaVolume = eventHandlers.localMediaVolume;

            //Set the caller-id, domain name gets automatically stripped off
            //Note that It must be a valid sip uri.
            //Default value is: voxrtc@voxbone.com
            //voxbone.WebRTC.configuration.uri = "caller-id@voxbone.com";

            //Bootstrap Voxbone WebRTC javascript object
            voxbone.WebRTC.init(voxrtc_config);
        }

        /** Optional part, only use to play with mute **/
        function toggleMute(){
            var button = document.getElementById("mute");
            if( voxbone.WebRTC.isMuted ){
                voxbone.WebRTC.unmute();
                button.value = "mute";
            }else{
                voxbone.WebRTC.mute();
                button.value = "unmute";
            }
        }

        function sendDTMF(){
            var value = document.getElementById('dtmf').value;
            voxbone.WebRTC.sendDTMF(value);
            console.log("dtmf value: ",value);
        }
    </script>
</head>

<!-- invoke init() method when page is initializing -->
<body onload="init();">
<!-- voxbone unloadHandler will hangup any ongoing call -->
<body onbeforeunload="voxbone.WebRTC.unloadHandler();">
<form>
    <!-- input text which holds the number to dial -->
    <input type='text' id='number'/>
    <!-- place a call using voxbone webrtc js lib -->
    <input type='button' value='dial' onClick="voxbone.WebRTC.call(document.getElementById('number').value);"/>
    <!-- hangup the current call in progress -->
    <input type='button' value='hangup' onClick='voxbone.WebRTC.hangup();'/>
    <!-- toggle mute ON/OFF -->
    <input id="mute" type="button" value="mute" onclick="toggleMute()"/>
    <br/>
    <label for="dtmf">DTMF</label>
    <input type="text" id="dtmf" size="1"/>
    <input type="button" onclick="sendDTMF();" value="send">
    <div id="divMeter">
	<div class="label">Local Volume: </div>
	<meter id="volume" high="0.15" max="1" value="0"></meter>
	<div class="value"></div>
    </div>

    <br>
    <div id="status_message"><p>Initializing configuration</p></div>
</form>
</body>
</html>
