<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script src="auth" type="text/javascript"></script>
    <script src="https://webrtc.voxbone.com/js/voxbone-0.0.2.js" type="text/javascript"></script>
    <script src="https://webrtc.voxbone.com/js/jssip-0.3.0.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

    <script>



        // Register callbacks to desired call events
        var eventHandlers = {
            'progress':   function(e){ document.getElementById("status_message").innerHTML="Calling " + document.getElementById('number').value;},
            'failed':     function(e){ document.getElementById("status_message").innerHTML="Failed to Connect"; },
            'started':    function(e){ document.getElementById("status_message").innerHTML="<b><font color='green'>In Call</font></b>"; },
            'ended':      function(e){ document.getElementById("status_message").innerHTML="<b><font color='red'>Call Ended</font></b>"; }
        };





        /** This part is required as it handle Voxbone WebRTC initialization **/
        function init(){
            // Set the webrtc auth server url (url below it the default one)
            voxbone.WebRTC.authServerURL = "https://webrtc.voxbone.com/rest/authentication/createToken";

            // Force the preferedPop to TEST.
            //This can be usefull if you need  to get your webrtc calls troubleshooted
            //If this is not set, a ping to each pop will be issued to determine which is the most optimal for the user
            //Default is to use the ping mechanism to determine the preferedPop.
            //voxbone.WebRTC.preferedPop = 'BE';

            // set custom event handlers
            voxbone.WebRTC.customEventHandler = eventHandlers;

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
    </script>
</head>

<!-- invoke init() method when page is initializing -->
<body onload="init();">
<form>
    <!-- input text which holds the number to dial -->
    <input type='text' id='number'/>
    <!-- place a call using voxbone webrtc js lib -->
    <input type='button' value='dial' onClick="voxbone.WebRTC.call(document.getElementById('number').value);"/>
    <!-- hangup the current call in progress -->
    <input type='button' value='hangup' onClick='voxbone.WebRTC.hangup();'/>
    <!-- toggle mute ON/OFF -->
    <input id="mute" type="button" value="mute" onclick="toggleMute()"/>
    <br>
    <div id="status_message"><p>Initializing configuration</p></div>

</form>
</body>
</html>
