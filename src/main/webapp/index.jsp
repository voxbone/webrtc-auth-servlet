<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>

    <!-- This generates the secure token and populates it in the variable voxrtc_config -->
    <script src="auth" type="text/javascript"></script>

    <link href='//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css' rel='stylesheet'></link>
    <script src="https://webrtc.voxbone.com/js/jssip-0.7.9-vox.js" type="text/javascript"></script>
    <script src="https://webrtc.voxbone.com/js/voxbone-0.0.3.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

    <script>
        // Register callbacks to desired call events
        var eventHandlers = {
            'progress':   function(e){ document.getElementById("status_message").innerHTML="Dialing 883510080143";},
            'getUserMediaFailed':     function(e){ alert("Unable to access mic, be sure you give permission!"); },
            'failed':     function(e){ document.getElementById("status_message").innerHTML="<b><font color='red'>Failed to Connect: " + e.cause +"</font></b>"; },
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
            //Add a display name
          //voxbone.WebRTC.configuration.display_name = "";
          //Add an object or string in the X-Voxbone-Context SIP header
          //voxbone.WebRTC.context = "Here's a context string";

          /**
            * dialer_string
            * Digits to dial after call is established
            * dialer string is comma separated, to define a specific pause between digits,
            * we add another entry like 1,2,3,1200ms,4,.. this will add a 1200ms of pause between
            * digits 3 & 4.
            * Example = '1,2,3,1200ms,4,5,900ms,6,#'
          **/
          //voxbone.WebRTC.configuration.dialer_string = "1,2,3,1200ms,4,5,900ms,6,#";

          /**
            * digit duration (in milliseconds)
            * It defines the duration of digits sent by the web application.
            * By default, default digit duration is 100 ms.
          **/
          //voxbone.WebRTC.configuration.digit_duration = 1000;

          /**
            * gap can be set between all digits in milliseconds
          **/
          //voxbone.WebRTC.configuration.digit_gap = 1400;

          /**
            * This configuration option if enabled allows voxbone webrtc sdk to push
            * all the call logs to a voxbone defined backend, where they can be used
            * for troubleshooting. By default, this option is disabled.
            * Set this option to true to allow voxbone to collect call logs
          **/
          //voxbone.WebRTC.configuration.post_logs = true;

            //Bootstrap Voxbone WebRTC javascript object
            voxbone.WebRTC.init(voxrtc_config);

            //Basic Authentication can also be used instead of using the token in voxbone.WebRTC.init()
            //voxbone.WebRTC.basicAuthInit(your_username, your_secret_key)

        }

        /** Optional part, only use to play with mute **/
        function toggleMute(){
            var button = document.getElementById("mute");
            if( voxbone.WebRTC.isMuted ){
                voxbone.WebRTC.unmute();
                $("#mute").text("Mute");
                $("#mute_icon").removeClass("glyphicon-volume-off").addClass("glyphicon-volume-up");
            }else{
                voxbone.WebRTC.mute();
                $("#mute").text("Unmute");
                $("#mute_icon").removeClass("glyphicon-volume-up").addClass("glyphicon-volume-off");            }
        }

        function sendDTMF(digit){
            voxbone.WebRTC.sendDTMF(digit);
            console.log("dtmf value: ",digit);
        }
    </script>
</head>

<!-- invoke init() method when page is initializing -->
<!-- voxbone unloadHandler will hangup any ongoing call -->
<body onload="init()" onbeforeunload="voxbone.WebRTC.unloadHandler();" style='text-align: center;'>

<h1>Click2Call Demo</h1>
<div class="container" style='width:200px; margin-top:1%;'>
    <div id="status_message"><p>Initializing configuration</p></div>
    <div id="divMeter">
        Local Volume:
        <meter id="volume" high="0.20" optimum='0.10' max=".5" value="0"></meter>
    </div>
    <form>
        <!-- input text which holds the number to dial -->
        <input type='tel' id='number' placeholder='Enter your VoxDID' class="btn-block form-control"/>
        <!-- place a call using voxbone webrtc js lib -->
        <button  type="button" class='btn btn-success btn-lg btn-block' onClick="voxbone.WebRTC.call(document.getElementById('number').value);">
            Dial
            <span class="glyphicon glyphicon-earphone pull-left"/>
        </button>
        <!-- hangup the current call in progress -->
        <button  type="button" class='btn btn-danger btn-lg btn-block' onClick='voxbone.WebRTC.hangup();'>
            Hangup
            <span class='glyphicon glyphicon-remove pull-left'/>
        </button>
        <!-- toggle mute ON/OFF -->
        <button  type="button" id="mute" class='btn btn-info btn-lg btn-block' onclick="toggleMute()">
            <span id="mute">Mute</span>
            <span class='glyphicon glyphicon-volume-up pull-left' id="mute_icon" />
        </button>
        <br/>


        <br>
        <br>
        <div>
            <button type='button' onclick="sendDTMF('1');" class='btn btn-default'>1</button>
            <button type='button' onclick="sendDTMF('2');" class='btn btn-default'>2</button>
            <button type='button' onclick="sendDTMF('3');" class='btn btn-default'>3</button>
        </div>
        <div>
            <button type='button' onclick="sendDTMF('4');" class='btn btn-default'>4</button>
            <button type='button' onclick="sendDTMF('5');" class='btn btn-default'>5</button>
            <button type='button' onclick="sendDTMF('6');" class='btn btn-default'>6</button>
         </div>
        <div>
            <button type='button' onclick="sendDTMF('7');" class='btn btn-default'>7</button>
            <button type='button' onclick="sendDTMF('8');" class='btn btn-default'>8</button>
            <button type='button' onclick="sendDTMF('9');" class='btn btn-default'>9</button>
         </div>
        <div>
            <button type='button' onclick="sendDTMF('*');" class='btn btn-default'>*</button>
            <button type='button' onclick="sendDTMF('0');" class='btn btn-default'>0</button>
            <button type='button' onclick="sendDTMF('#');" class='btn btn-default'>#</button>
         </div>
    </form>
</div>

</body>
</html>
