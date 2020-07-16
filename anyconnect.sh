#!/bin/sh
# Variables
myHost=$(hostname | /usr/bin/awk -F's-' '{print $1}')
cert=`security find-certificate -c $myHost -Z | grep SHA | awk '{print $3}'`
loggedInUser=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`
##Set Safari to use certificate
security set-identity-preference -Z $cert -s *.vmwareidentity.com
security set-identity-preference -Z $cert -s cas-aws.vmwareidentity.com
#Create .anyconnect config file
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<AnyConnectPreferences>
<DefaultUser>$loggedInUser</DefaultUser>
<DefaultSecondUser></DefaultSecondUser>
<ClientCertificateThumbprint>$cert</ClientCertificateThumbprint>
<ServerCertificateThumbprint></ServerCertificateThumbprint>
<DefaultHostName>vpn.mobilejon.com</DefaultHostName>
<DefaultHostAddress>vpn.mobilejon.com</DefaultHostAddress>
<DefaultGroup>MOBILEJONVPN</DefaultGroup>
<ProxyHost></ProxyHost>
<ProxyPort></ProxyPort>
<SDITokenType>none</SDITokenType>
<ControllablePreferences></ControllablePreferences>
</AnyConnectPreferences>" > /Users/$loggedInUser/.anyconnect

#  PopulateCert.sh
#  
#
#  Created by Jon Towles on 5/7/18.
#  
