# Define constants
:local TOKEN CF_Token
:local ZONEIDv6 CF_Zone_ID
:local RECORDIDv6 CF_Record_ID
:local RECORDNAMEv6 Your_Domain
:local WANIF ROS_WAN #eg:pppoe-out1
:local currentIP ""
:local resolvedIP ""
:local sckey serverChan_key #leave blank if you don't have the key

# Log info
:log info "DDNS updates checking..."

# Fetch the Resolved IPv6 address via DNS
:set resolvedIP [:resolve domain-name=$RECORDNAMEv6 type=ipv6 server=114.114.114.114]; #set server your local DNS provider

# Check if WAN interface is running 
:local wanRunning [/interface/pppoe-client get [find name=$WANIF] running];

:if ($wanRunning) do={ 

    # Get the IPv6 address from the WAN interface
    :local varIP [/ipv6/address get [find global interface=$WANIF && from-pool=Public_Pool_IPv6] address];
    # Extract the IPv6 address (remove the / prefix)
    :set currentIP [:pick $varIP 0 [:find $varIP "/"]]

 } else {

    :log warning "WAN interface $WANIF does not have a public IPv6 address or is not running."
    :local "currentIP" ""
 };

# Compare the current IPv6 address with the resolved one
:if ($currentIP != "" && $currentIP != $resolvedIP) do={ 

    # Update the DNS record and send a notification

    # Construct the Cloudflare API URL
    :local url "https://api.cloudflare.com/client/v4/zones/$ZONEIDv6/dns_records/$RECORDIDv6/" #check CF API
    
    # Call the Cloudflare API to update the DNS record
    :local cfapi [/tool fetch http-method=put mode=https url=$url check-certificate=no output=user as-value \
        http-header-field="Authorization: Bearer $TOKEN" \
        http-data="{\"type\":\"AAAA\",\"name\":\"$RECORDNAMEv6\",\"content\":\"$currentIP\",\"ttl\":120,\"proxied\":false}"]
    
    # Log the information about updating the DNS record
    :log info "CF-DDNS: $RECORDNAMEv6 is now updated with $currentIP."
    
    # Set the title for the ServerChan notification
    :local sctitle "DDNS: $currentIP."
    # Set the ServerChan notification URL
    :local scurl "https://sctapi.ftqq.com/$sckey.send"
    # Set the body for the ServerChan notification
    :local scbody "title=$sctitle&desp=The DDNS record has been updated with the new IPv6 address: $currentIP."
    
    # Send the notification to ServerChan
    :log info "Sending message to ServerChan..."
    :local scresponse [/tool fetch url=$scurl http-method=post http-header-field="Content-Type: application/x-www-form-urlencoded" http-data=$scbody]
    # Log the response from ServerChan
    :log info "Response: $scresponse"

 } else {

    # If the addresses are the same, log the information
    :log info "CF-DDNS: No change in IP address ($currentIP)."

};
