webrtc-auth-servlet
===================

This projects aims to provide an easy way for Voxbone customer to integrate WebRTC ephemeral authentication on their website.
The servlet can be fully configured using web.xml and output javascript variable which holds ephemeral authentication data.

This project is also shipped with a demo.
In order to configure the demo, you have 2 different approach:

1) using the voxbone.properties file ( this is default )
simply navigate to src/main/webapp/WEB-INF/ and edit voxbone.properties.
In this file, you can simply set the following 2 properties:

```
#voxbone webrtc username
com.voxbone.webrtc.auth.username=username
#voxbone webrtc secret
com.voxbone.webrtc.auth.secret=secret
```

2) Using the web.xml file.
In order to do that, first unset the config file by deleting the following:

```
        <init-param>
            <param-name>com.voxbone.webrtc.config_file</param-name>
            <param-value>/WEB-INF/voxbone.properties</param-value>
        </init-param>
```

Then uncomment and set the init param below

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

Please note that you shouldn't delete the <![CDATA[ ... ]]>  tag as it allows you to input special character for your password.
just replace "secret" by your actual webrtc password.
CDATA is required to allow special character to be set within an xml file (such  like web.xml)


Once the above is done, you can simply run the following command line from project root folder:
```
mvn clean tomcat7:run
```
You should then be able to access the demo at the following url: http://localhost:8080/demo
