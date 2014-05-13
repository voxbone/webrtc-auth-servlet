<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script src="auth" type="text/javascript"></script>
    <script src="https://webrtc.voxbone.com/js/voxbone-0.0.1.js" type="text/javascript"></script>
    <script src="https://webrtc.voxbone.com/js/jssip-0.3.0.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

    <script>
        /** This part is required as it handle Voxbone WebRTC initialization **/
        function init(){
            // Check if customer web browser support webrtc, if not send an alert
            // This is optional
            voxbone.WebRTC.authServerURL = "https://webrtc.voxbone.com/rest/authentication/createToken";
            voxbone.WebRTC.preferedPop = 'CN';

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

</form>
</body>
</html>
