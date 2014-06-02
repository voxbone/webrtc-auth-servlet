webrtc-auth-servlet
===================

This projects aims to provide an easy way for Voxbone customer to integrate WebRTC ephemeral authentication on their website.
The servlet can be fully configured using web.xml and output javascript variable which holds ephemeral authentication data.

This project is also shipped with a demo.
In order to get the demo working, simply edit the web.xml file and set the following parameters:

```
        <init-param>
            <description>Username used to authenticate</description>
            <param-name>com.voxbone.webrtc.auth.username</param-name>
            <param-value>username</param-value>
        </init-param>
```

```
        <init-param>
            <description>Secret key used to authenticate</description>
            <param-name>com.voxbone.webrtc.auth.secret</param-name>
            <param-value><![CDATA[secret]]></param-value>
        </init-param>
```

Where username is your Voxbone username and secret is the WebRTC secret password you defined for your voxbone account.

Please note that you shouldn't delete the <![CDATA[ ... ]]  tag as it allows you to input special character for your password.
just replace "secret" by your actual webrtc password.
CDATA is required to allow special character to be set within an xml file (such  like web.xml)

Once these 2 parameters are set, simply go to the root folder of the project and start the demo via maven using:
```
mvn clean tomcat7:run
```
You should then be able to access the demo at the following url: http://localhost:8080/demo
