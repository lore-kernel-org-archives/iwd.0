Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77A520EA5E
	for <iwd@lists.linux.dev>; Thu,  7 Nov 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984986; cv=none; b=c96XBY/All/d83VBtgV7nHDwTNBmkJsAT4oBHcqINimWElRVZ71CQzvizMWZyzcj72C0p2w5n7e+GcjAQf/yp9ndAuyl0bZs1ZirY8LcykdDIyiGehzMZAfLw+/9YaBaFVKtZ5VrfOAMVBm1tPd51ar1XFikHAhlrFd0WlcvujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984986; c=relaxed/simple;
	bh=dOJyUV+ftjxXUkGUbHaj1Mtl0VUbQJ1uwkojW/y6iPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFwm1/ACGER6cU+2QugS4+C5vkhrP6WBycJsKC5jy3YCCTg+Eo2EExHxPBGd8K6G1NXP/1vHb09O7bGCX+kupstVgGfZrmxHtNUr0sd2b5hmiXR8/ctRrU99U2JfNIeT65jE7mXhTCDxwlorGYog8u1T6kv7FN6nrJtwyj2ifE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=OtG7N/fM; arc=none smtp.client-ip=195.10.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="OtG7N/fM"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4Xkj8f4N4Qz9v76;
	Thu,  7 Nov 2024 14:09:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1730984978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0yuD4xy2jI8uYJJU0rTRyoEVhLRbM1ct/B/vVRWbQw=;
	b=OtG7N/fMrKtZuQoo535Vpml7VsysNVsrsGSXV6AXzEZ1cht91rzSG3L+8KW01KvuIVD4kB
	ZVPJoENFcPFD30R8aiDhUTf/LOc68/93odsMArgTUcAZndGW6QgpawViXYq7rXf1lBOG62
	oIb9PBmHZnqwAyb0CcU9urKVVh156pYjdQ+gFdlw3sGMlvhLuKBQD/neuQHzN06oJJBgSF
	Xxgasb5+Ocwm1cTRj2mT9jEdGKxVSUbWVI/ODbJee6DzqqjNCzUFNGc79WoBmku4SGcYeh
	83EdRKgtgY26Ovd4TshKs0FOqWP4cOKENZPyA4zFzph6ucKkaCyqy5mtCEpxtg==
Message-ID: <b6b31d01-d772-4049-abc7-7c30411004f8@tavla.de>
Date: Thu, 7 Nov 2024 14:09:37 +0100
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
 <2d245329-365a-42fa-91d3-5f4da7ab846f@tavla.de>
 <49b9d8b9-2769-4c65-8f10-4ffafc822885@gmail.com>
Content-Language: en-GB, de-DE
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <49b9d8b9-2769-4c65-8f10-4ffafc822885@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear James,

Am 05.11.24 um 00:20 schrieb James Prestwood:
> Hi Martin,
>
> On 11/4/24 2:42 PM, Martin Petzold wrote:
>> Dear James,
>>
>> Am 04.11.24 um 13:36 schrieb James Prestwood:
>>>
>>> On 11/3/24 3:13 PM, Martin Petzold wrote:
>>>> Dear James,
>>>>
>>>> Am 25.10.24 um 17:17 schrieb James Prestwood:
>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> I open a new thread for this one: During the last weeks I 
>>>>>>>>>>>>> have seen connection losses for 30+ minutes, sometimes 
>>>>>>>>>>>>> even hours or just now even forever (IWD HEAD with v2 OWE 
>>>>>>>>>>>>> / BSS selection patches). Driver is brcmfmac (NXP 6.1.36 
>>>>>>>>>>>>> kernel) and chip is BCM4339 (Laird LWB5).
>>>>>>>>>>>>>
>>>>>>>>>>>>> It happens in a) single router environment (WPA2-PSK; 
>>>>>>>>>>>>> Touchstone TG3442DE), and b) router + repeater environment 
>>>>>>>>>>>>> (WPA2 CCMP; Fritz!Box + Fritz!Repeater), and maybe also in 
>>>>>>>>>>>>> the WPA3 OWE Transition network (yesterday lost a 
>>>>>>>>>>>>> connection again).
>>>>>>>>>>>>
>>>>>>>>>>>> I lost now again 2 of 10 devices in the WPA3 OWE network 
>>>>>>>>>>>> (with roaming). However, now they don't disappear all after 
>>>>>>>>>>>> a shorter while. It seems to be later.
>>>>>>>>>>>>
>>>>>>>>>>>> I also lost one device in a Router+Repeater WPA2 (CCMP) 
>>>>>>>>>>>> network. It is confirmed here on router side, that the 
>>>>>>>>>>>> device is disconnected. Since more than a day.
>>>>>>>>>>>
>>>>>>>>>>> We can't do anything without logs. If you suspect its the 
>>>>>>>>>>> blacklist you can lower the blacklist time down in main.conf:
>>>>>>>>>>>
>>>>>>>>>>> [
>>>>
>>>> I am still losing devices. Sometimes they come back again, but 
>>>> mostly do not re-connect. I have observed the following:
>>>>
>>>> - Connection exists for several hours until about one day, or two. 
>>>> Then gone for several hours or mostly forever.
>>>> - For FritzBox+FritzRepeater I have seen the connection coming back 
>>>> after like a day (here connection loss was also confirmed on router 
>>>> side!)
>>>> - For the Aruba enterprise environment the connection never came 
>>>> back (until now no AP logs - waiting for an answer)
>>>> - After reboot the connection comes back
>>>> - It occurs only in an environment with multiple APs with same SSID 
>>>> (i.e. roaming environment), however my single AP environments have 
>>>> all strong signal
>>>> - Some devices with identical configuration in this environment DO 
>>>> NOT get lost, those seem to have quite strong signal (maybe they 
>>>> don't roam)
>>>> - Other devices in the same environment work without any problems 
>>>> (Intel+NetworkManager) and the APs are Aruba enterprise grade
>>>> - I see almost the same in the Aruba enterprise environment, but 
>>>> ALSO in a FritzBox + FritzRepeater environment
>>>> - We had a bug in our web socket connection, causing to many IWD 
>>>> requests. However, this was fixed. And why are all the other 
>>>> devices okay? Maybe co-incidence with roaming and anything related 
>>>> to dropping and re-connecting web socket connection.
>>>>
>>>> Please find attached my currently available debug logs (they are a 
>>>> few days old, but I am quite sure this is the connection loss 
>>>> situation). These logs are from the FritzBox+FritzRepeater 
>>>> environment. There are no brcmfmac messages (but also no special 
>>>> debug level configured here)!
>>>>
>>>> I have now also disabled WiFi power saving and will deploy to the 
>>>> environment...hoping the best.
>>>>
>>>> Maybe you could check the logs and have an idea?
>>>
>>> Looks like the same thing as the last logs you sent. IWD tries to 
>>> connect (sends CMD_CONNECT to the kernel) but gets no associated 
>>> CMD_CONNECT event after that which causes IWD to wait indefinitely 
>>> for that event. This, again, appears like a driver problem because 
>>> its expected that the kernel tells userspace the result of the 
>>> CMD_CONNECT request.
>>>
>>> Only similarity I can see between the two sets of logs is there is a 
>>> failed connection just prior to the hang. IWD then attempts to 
>>> connect again but the 4-way handshake is never started and this 
>>> results in a failure with status 16 (group key handshake timeout). 
>>> In your latest set of logs IWD actually again tries to connect to a 
>>> different BSS and gets status 16 before trying yet again and hanging.
>>>
>>> This actually seems similar to an issue I encountered with ath10k 
>>> where the network interface would time out being brought up. 
>>> Retrying would succeed but the driver would be in a similar state 
>>> where IWD could authenticate/associate but no data frames (i.e. 
>>> 4-way handshake) would be passed to userspace. Only solution (until 
>>> upstream fixed the bug) was to unload/reload the driver when we 
>>> detected this condition.
>>>
>>> If you are able to physically attach to a device currently in this 
>>> state you may be able to get more info. For example if IWD is stuck 
>>> like this try disconnecting/reconnecting with iwctl or restarting 
>>> IWD to see what happens. If you end up in the same state right away 
>>> I'm 99.9% sure the driver is the entire reason your running into this.
>>
>> Are you sure? Maybe you could double-check?
> I'm sure.
>>
>> Because my SOM vendor (Variscite) selling a few hundred thousand of 
>> these do not report any issue with this kernel, firmware, and 
>> NetworkManager (wpa_supplicant)...
>
> Because wpa_supplicant sets internal timers for these commands in case 
> the driver is broken. I would expect you would see this exact behavior 
> with wpa_supplicant, it would just disconnect/reconnect after 5 
> seconds of no response from the kernel. And something like this either 
> a) goes entirely unnoticed and/or b) works well enough for a hardware 
> vendor to ship it to customers and not care.
>
> This is the commit adding these timers to wpa_supplicant:
>
> commit e29853bbff1eef781099a9108e3b51f26b477ac3
> Author: Ben Greear <greearb@candelatech.com>
> Date:   Thu Feb 24 16:59:46 2011 +0200
>
>     SME: Add timers for authentication and asscoiation
>
>     mac80211 authentication or association operation may get stuck for 
> some
>     reasons, so wpa_supplicant better use an internal timer to recover 
> from
>     this.
>
>     Signed-off-by: Ben Greear <greearb@candelatech.com>
>
> I wish it surprised me that 13 years later this behavior still 
> happens... We don't like adding special driver workarounds like this 
> in IWD because a) it becomes difficult to maintain and b) it just 
> hides the root cause and nobody ever fixes it. But my opinions aside, 
> for a driver like brcmfmac which is very mainstream, I guess we have 
> no choice but to adapt IWD to work around it like wpa_supplicant does.

It seems to be better now, but I'm still investigating some instability.

Here some logs from AP (in this case we are in enterprise ARUBA WPA3 
Transition Mode (Open Network):

----- BEFORE patch and power save disabled (several of these negative 
events) - station mostly does not have carrier

2024-11-06 14:09:48 
CET,"006-WLANAP-070","XXX","XX:YY:ZZ:c9:40:06","XX:YY:ZZ:14:00:61","negative","Client 
Onboarding Failure - Deauthentication/Disassociation","Onboarding failed 
for client XX:YY:ZZ:8a:d6:42 in Deauthentication/Disassociation phase to 
BSSID XX:YY:ZZ:14:00:61 on channel 11 of AP hostname 006-WLANAP-070. 
Reason: SSID Age-out","SSID Age-out","XYZ-Gast","2.4 GHz 
(G)","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""

[...]

2024-11-06 11:37:54 
CET,"006-WLANAP-070","XXX","XX:YY:ZZ:c9:40:06","XX:YY:ZZ:14:00:61","neutral","802.11 
De-authentication to Client","De-authentication sent to 
client XX:YY:ZZ:8a:d6:42 from BSSID XX:YY:ZZ:14:00:61 on channel 11 of 
AP hostname 006-WLANAP-070. Reason: Station has roamed to another 
AP","Station has roamed to another AP","XYZ-Gast","2.4 GHz 
(G)","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""

----- AFTER patch and power save disabled ("only" such negative events 
left) - station mostly has carrier, but still see some instability

"2024-11-06 13:47:02 
CET,""006-WLANAP-064"",""XXX"",""XX:YY:ZZ:c9:42:c4"",""XX:YY:ZZ:14:2c:43"",""negative"",""Client 
Onboarding Failure - Deauthentication/Disassociation"",""Onboarding 
failed for client XX:YY:ZZ:8e:22:8a in Deauthentication/Disassociation 
phase to BSSID XX:YY:ZZ:14:2c:43 on channel 6 of AP hostname 
006-WLANAP-064. Reason: Client left the access point"",""Client left the 
access point"",""XYZ-Gast"",""2.4 GHz 
(G)"","""",""37"",""220"","""","""","""","""","""","""","""","""","""",""61"","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""",""HT"",""Short"",""20 
MHz"",""1ss"","""","""","""","""","""""

[...]

"2024-11-06 13:47:01 
CET,""006-WLANAP-064"",""XXX"",""XX:YY:ZZ:c9:42:c4"",""XX:YY:ZZ:14:2c:43"",""negative"",""Client 
DHCP Timeout"",""DHCP request from client XX:YY:ZZ:8e:22:8a timed 
out"","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""",""10.119.40.10"",""8.8.8.8"",""172.22.0.1"","""","""",""81089"","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""","""""
-----

Maybe you have some comment on the changes. And if these DHCP failures 
could still cause instability? (maybe some issues on AP / DHCP server side?)

Best regards,

Martin

