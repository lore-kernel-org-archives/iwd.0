Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70620C309
	for <iwd@lists.linux.dev>; Wed,  6 Nov 2024 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925159; cv=none; b=SWHoqm0jaZiLN3VfrIdNuIrf1sHY2E3boCY0DIp70HMINFZPjjNiwy4gRPQy0tCaphc6hngfhkBAFVA4qGRijcj0faRwCZZK2LzQyk4oxPzX1rCIkKJD601sOGONn/4vWa2+2zuZxOy3RFolkKEt2cnVgPuCk5akiZShaR4JWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925159; c=relaxed/simple;
	bh=t58havWMZXaG8Aoi6f89Avrt0N0KcXJEFyE4FKODHh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StuoeYZi0g+j5FErCJC8ZlgegUVES25lhzI4AVwYJmM5gA6QLeu5tldj/sHcr4x8auBnIjTIjHnu1KJ3R1pajsCV9sM/JczijjMkijM0KmPtRQWdgNDLJJoz2B7p/x+Wl2KRor3++Bh1knDsaGkrn3d1jBOu3LCvRB4uXgmb50w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=uuFODCr/; arc=none smtp.client-ip=195.10.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="uuFODCr/"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4XkH205K1cz9vVm;
	Wed,  6 Nov 2024 21:32:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730925144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YG1gMUTkPieh8CX4QVDj5piGtCaAEREaIQrCjcowJGg=;
	b=uuFODCr/VjdV5PWgZAZpjeU0qmx+Y/K+Xwr1hiC8xMNG7nykxQ9PczW5H+A1TuOvkQxelr
	tFXY/kWvTa6yxp0d6S/lvz8FOJfjFXFXMO8l//s+NfwAxVfeSzN8I2Sx3bRX3ZPMfvdQFz
	5ng/8EDKGMNaIbGrDiKaMVPIVf49cFFCuHUdxyvHeiA93ajCF0GpX2sto2dKE+uBHqAE+T
	2aOkaoUtpnmHVoH4MxNBuYB91e8xriPi8+1chJvWh6hj7jZCIo926UyrLrVAxQMWGqVba4
	w3wFqgaqutWDr3DV2PtregidbR0PWzsN2/YQgQldOmdBnUbDAJAcTE/SFvREQQ==
Message-ID: <b718a3d3-aa26-4b95-9b16-f4c9acd27663@tavla.de>
Date: Wed, 6 Nov 2024 21:32:23 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev, Arend Van Spriel <arend.vanspriel@broadcom.com>
References: <1147b5a6-883a-43be-a577-f16e9e6351ef@tavla.de>
 <7dbbd152-f251-414a-8d00-29c08bbb272e@tavla.de>
 <02bb45e1-cfef-433d-9a83-2b312c1ae064@gmail.com>
 <6d384377-ee6c-4a5d-8b67-75f367403acd@tavla.de>
 <d33154fa-9309-4285-a592-9e377e199f43@gmail.com>
 <57826e6a-8466-4e45-8906-6cb15968bcc8@tavla.de>
 <e19e7527-9cc1-4c84-95ac-dcb39f836d58@gmail.com>
 <78437e50-e6b1-4965-bd03-776fcf3c9801@tavla.de>
 <a64c4733-9011-448c-ab75-8916ff339ac4@gmail.com>
 <f9ca5733-7cda-4494-8b6d-7a4de4157da2@tavla.de>
 <f489d856-c788-47c5-8739-325a11d7ff42@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <f489d856-c788-47c5-8739-325a11d7ff42@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear James,

Am 04.11.24 um 13:36 schrieb James Prestwood:
>
> On 11/3/24 3:13 PM, Martin Petzold wrote:
>> Dear James,
>>
>> Am 25.10.24 um 17:17 schrieb James Prestwood:
>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I open a new thread for this one: During the last weeks I 
>>>>>>>>>>> have seen connection losses for 30+ minutes, sometimes even 
>>>>>>>>>>> hours or just now even forever (IWD HEAD with v2 OWE / BSS 
>>>>>>>>>>> selection patches). Driver is brcmfmac (NXP 6.1.36 kernel) 
>>>>>>>>>>> and chip is BCM4339 (Laird LWB5).
>>>>>>>>>>>
>>>>>>>>>>> It happens in a) single router environment (WPA2-PSK; 
>>>>>>>>>>> Touchstone TG3442DE), and b) router + repeater environment 
>>>>>>>>>>> (WPA2 CCMP; Fritz!Box + Fritz!Repeater), and maybe also in 
>>>>>>>>>>> the WPA3 OWE Transition network (yesterday lost a connection 
>>>>>>>>>>> again).
>>>>>>>>>>
>>>>>>>>>> I lost now again 2 of 10 devices in the WPA3 OWE network 
>>>>>>>>>> (with roaming). However, now they don't disappear all after a 
>>>>>>>>>> shorter while. It seems to be later.
>>>>>>>>>>
>>>>>>>>>> I also lost one device in a Router+Repeater WPA2 (CCMP) 
>>>>>>>>>> network. It is confirmed here on router side, that the device 
>>>>>>>>>> is disconnected. Since more than a day.
>>>>>>>>>
>>>>>>>>> We can't do anything without logs. If you suspect its the 
>>>>>>>>> blacklist you can lower the blacklist time down in main.conf:
>>>>>>>>>
>>>>>>>>> [
>>
>> I am still losing devices. Sometimes they come back again, but mostly 
>> do not re-connect. I have observed the following:
>>
>> - Connection exists for several hours until about one day, or two. 
>> Then gone for several hours or mostly forever.
>> - For FritzBox+FritzRepeater I have seen the connection coming back 
>> after like a day (here connection loss was also confirmed on router 
>> side!)
>> - For the Aruba enterprise environment the connection never came back 
>> (until now no AP logs - waiting for an answer)
>> - After reboot the connection comes back
>> - It occurs only in an environment with multiple APs with same SSID 
>> (i.e. roaming environment), however my single AP environments have 
>> all strong signal
>> - Some devices with identical configuration in this environment DO 
>> NOT get lost, those seem to have quite strong signal (maybe they 
>> don't roam)
>> - Other devices in the same environment work without any problems 
>> (Intel+NetworkManager) and the APs are Aruba enterprise grade
>> - I see almost the same in the Aruba enterprise environment, but ALSO 
>> in a FritzBox + FritzRepeater environment
>> - We had a bug in our web socket connection, causing to many IWD 
>> requests. However, this was fixed. And why are all the other devices 
>> okay? Maybe co-incidence with roaming and anything related to 
>> dropping and re-connecting web socket connection.
>>
>> Please find attached my currently available debug logs (they are a 
>> few days old, but I am quite sure this is the connection loss 
>> situation). These logs are from the FritzBox+FritzRepeater 
>> environment. There are no brcmfmac messages (but also no special 
>> debug level configured here)!
>>
>> I have now also disabled WiFi power saving and will deploy to the 
>> environment...hoping the best.
>>
>> Maybe you could check the logs and have an idea?
>
> Looks like the same thing as the last logs you sent. IWD tries to 
> connect (sends CMD_CONNECT to the kernel) but gets no associated 
> CMD_CONNECT event after that which causes IWD to wait indefinitely for 
> that event. This, again, appears like a driver problem because its 
> expected that the kernel tells userspace the result of the CMD_CONNECT 
> request.
>
> Only similarity I can see between the two sets of logs is there is a 
> failed connection just prior to the hang. IWD then attempts to connect 
> again but the 4-way handshake is never started and this results in a 
> failure with status 16 (group key handshake timeout). In your latest 
> set of logs IWD actually again tries to connect to a different BSS and 
> gets status 16 before trying yet again and hanging.
>
> This actually seems similar to an issue I encountered with ath10k 
> where the network interface would time out being brought up. Retrying 
> would succeed but the driver would be in a similar state where IWD 
> could authenticate/associate but no data frames (i.e. 4-way handshake) 
> would be passed to userspace. Only solution (until upstream fixed the 
> bug) was to unload/reload the driver when we detected this condition.
>
> If you are able to physically attach to a device currently in this 
> state you may be able to get more info. For example if IWD is stuck 
> like this try disconnecting/reconnecting with iwctl or restarting IWD 
> to see what happens. If you end up in the same state right away I'm 
> 99.9% sure the driver is the entire reason your running into this.

-----

Okt 24 02:30:33 tavla iwd[386]: src/netdev.c:netdev_mlme_notify() MLME 
notification Disconnect(48)
Okt 24 02:30:33 tavla iwd[386]: src/netdev.c:netdev_disconnect_event()
Okt 24 02:30:33 tavla iwd[386]: Received Deauthentication event, reason: 
8, from_ap: true

-----

 From where does this MLME notification Disconnect come before the AP 
Deauth event?

And does reason 8 mean "Disassociated because sending station is leaving 
(or has left)" (which sounds like originally station decision) OR "AP 
moved the client to another access point using non-aggressive load 
balancing" (which then seems to be an AP decision)?

Because we are talking about signals around -70. What would the event 
be, if the AP finds the station unacceptable because of bad signal 
strength (so this is signal in direction to AP). Or doesn't this exist?

Thanks,

Martin

