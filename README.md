webrtc-auth-servlet
===================

This projects aims to provide an easy way for voxbone customer to integrate WebRTC ephemeral authentication on their website.
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
            <param-value>secret</param-value>
        </init-param>
```

Where username is your voxbone username and secret is the WebRTC secret password you defined for your voxbone account.

Once these 2 parameters are set, simply go to the root folder of the project and start the demo via maven using:
```
mvn clean tomcat7:run
```
