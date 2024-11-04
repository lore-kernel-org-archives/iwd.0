Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC95680
	for <iwd@lists.linux.dev>; Mon,  4 Nov 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723797; cv=none; b=TpGBEqjjn9HmukmrWkmFoL50URdJ/ZzEMT1x5GZeMdUIAhk+kTmpObPofX8Hw2yDuKRiyjtCzcTqwcm+pvREhdGPDJakYSvuDt2p9O229BNYlVxwfeqYcE9/XI6R1dghbw9wjR6SXJdSrdagPxcJ3a4fZM2b9KZ6H56f9/sf20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723797; c=relaxed/simple;
	bh=YFujrNU6zBN3qjJuZKzK6tAqSG9Z+A+vZCUZgGGrT24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpNXbVz5QHbnq2KclKNJCmDQLVaPPk9OH000srnsrcY+/LXxOGdHhlQ4TZb5mh7BT0cRB2WRY9l9lr9z99ujQdPxErz3pC9DSCE1m7lWAxmcnqDa0PyJ8u2SYpjS0VuaOhCpZY71SYeOeT8NWUGHVdCmojYq0AuK6IEnAOq4toY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imdtKYQi; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imdtKYQi"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e5fee32e76so1690709b6e.1
        for <iwd@lists.linux.dev>; Mon, 04 Nov 2024 04:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730723793; x=1731328593; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=St6PvNi7ZTWRCuxz2vH2Geis36NN5bAS5eaeyqLbv48=;
        b=imdtKYQiPHWrcDDLdsnJ94AptLasZMLg3J9WDScbaag4iugNG8cOpy5+KkuRj2+G05
         bRRZLvtBfkUUdOtYg0rZzwUg+Echc8gwHmSIQtO8cFtUWwg3HFe7lTiz6oYO9hJPNgoQ
         89E8CaO6sey+M34P0pIhCre8G4Dmdd4omHNLTlQdo1iXGymhyU0+b1N9lyXWNq4VMF+s
         6gGzhImEeTfr7gMw4yBloUelNwBudVAbIE54u0ZJucDSc2zRx0WXBcUqujOLhPeoZjWa
         8eQuTRNALtmJMNKo7voZj/g6D6oSJ7tZ1v86xzxZapxpaIYi/W0e/qi5brLWzuIuhjgq
         j0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730723793; x=1731328593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=St6PvNi7ZTWRCuxz2vH2Geis36NN5bAS5eaeyqLbv48=;
        b=fe+i1/oppP2TSgaO+c7n46AiAbFYCT3vc3vAidssh+AEaMuDly9dI+fHlzh6w5hNCe
         MfazXBGgYpBJt95UMo+FoSQjtQBuvPZCkLuPaPDwbwF9Z6Holqkb9oN1sjGTocA/5zEt
         1O01ooRNMzBxLT+vp+U4ybBBeAdAcqaLHnIXraPtpkyfOoRxgIEF/ogSb0w53HeWMFjj
         isEJu2uVDEspWmPJ4qIb/N0XaiVR+QRvfICXjP/a0cTrpZq70aV5pyV5UF41tEKLCW2g
         BrXflS/MbCHYdwUJk3HF6MkkXI1HR7pq5w+CrMMqn8nIkcC/atzmjb1GV6vgymjnzY6l
         R7Hg==
X-Gm-Message-State: AOJu0Yzpbkd7Lvh4ix5sTIm5aG7nhu11JyrF7uBlPUT2bUOfiz12GtgJ
	NDKZ5DrrlyOS4Qp7IwD36uO9WSZn2TxPaYER7QBMyXru12gHjCv2
X-Google-Smtp-Source: AGHT+IHwFzn+t1WO4henEQcsgMA0uni3VKUasZ+kGOd8+PKg2CTkXPUWoFs1WV5DtI+vZG8Ed+dH0Q==
X-Received: by 2002:a05:6808:13cc:b0:3e5:e4c8:cd34 with SMTP id 5614622812f47-3e758c46feamr10479004b6e.25.1730723793411;
        Mon, 04 Nov 2024 04:36:33 -0800 (PST)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452aa703sm6905728a12.27.2024.11.04.04.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 04:36:32 -0800 (PST)
Message-ID: <f489d856-c788-47c5-8739-325a11d7ff42@gmail.com>
Date: Mon, 4 Nov 2024 04:36:31 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
To: Martin Petzold <martin.petzold@tavla.de>
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
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f9ca5733-7cda-4494-8b6d-7a4de4157da2@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/3/24 3:13 PM, Martin Petzold wrote:
> Dear James,
>
> Am 25.10.24 um 17:17 schrieb James Prestwood:
>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I open a new thread for this one: During the last weeks I 
>>>>>>>>>> have seen connection losses for 30+ minutes, sometimes even 
>>>>>>>>>> hours or just now even forever (IWD HEAD with v2 OWE / BSS 
>>>>>>>>>> selection patches). Driver is brcmfmac (NXP 6.1.36 kernel) 
>>>>>>>>>> and chip is BCM4339 (Laird LWB5).
>>>>>>>>>>
>>>>>>>>>> It happens in a) single router environment (WPA2-PSK; 
>>>>>>>>>> Touchstone TG3442DE), and b) router + repeater environment 
>>>>>>>>>> (WPA2 CCMP; Fritz!Box + Fritz!Repeater), and maybe also in 
>>>>>>>>>> the WPA3 OWE Transition network (yesterday lost a connection 
>>>>>>>>>> again).
>>>>>>>>>
>>>>>>>>> I lost now again 2 of 10 devices in the WPA3 OWE network (with 
>>>>>>>>> roaming). However, now they don't disappear all after a 
>>>>>>>>> shorter while. It seems to be later.
>>>>>>>>>
>>>>>>>>> I also lost one device in a Router+Repeater WPA2 (CCMP) 
>>>>>>>>> network. It is confirmed here on router side, that the device 
>>>>>>>>> is disconnected. Since more than a day.
>>>>>>>>
>>>>>>>> We can't do anything without logs. If you suspect its the 
>>>>>>>> blacklist you can lower the blacklist time down in main.conf:
>>>>>>>>
>>>>>>>> [
>
> I am still losing devices. Sometimes they come back again, but mostly 
> do not re-connect. I have observed the following:
>
> - Connection exists for several hours until about one day, or two. 
> Then gone for several hours or mostly forever.
> - For FritzBox+FritzRepeater I have seen the connection coming back 
> after like a day (here connection loss was also confirmed on router 
> side!)
> - For the Aruba enterprise environment the connection never came back 
> (until now no AP logs - waiting for an answer)
> - After reboot the connection comes back
> - It occurs only in an environment with multiple APs with same SSID 
> (i.e. roaming environment), however my single AP environments have all 
> strong signal
> - Some devices with identical configuration in this environment DO NOT 
> get lost, those seem to have quite strong signal (maybe they don't roam)
> - Other devices in the same environment work without any problems 
> (Intel+NetworkManager) and the APs are Aruba enterprise grade
> - I see almost the same in the Aruba enterprise environment, but ALSO 
> in a FritzBox + FritzRepeater environment
> - We had a bug in our web socket connection, causing to many IWD 
> requests. However, this was fixed. And why are all the other devices 
> okay? Maybe co-incidence with roaming and anything related to dropping 
> and re-connecting web socket connection.
>
> Please find attached my currently available debug logs (they are a few 
> days old, but I am quite sure this is the connection loss situation). 
> These logs are from the FritzBox+FritzRepeater environment. There are 
> no brcmfmac messages (but also no special debug level configured here)!
>
> I have now also disabled WiFi power saving and will deploy to the 
> environment...hoping the best.
>
> Maybe you could check the logs and have an idea?

Looks like the same thing as the last logs you sent. IWD tries to 
connect (sends CMD_CONNECT to the kernel) but gets no associated 
CMD_CONNECT event after that which causes IWD to wait indefinitely for 
that event. This, again, appears like a driver problem because its 
expected that the kernel tells userspace the result of the CMD_CONNECT 
request.

Only similarity I can see between the two sets of logs is there is a 
failed connection just prior to the hang. IWD then attempts to connect 
again but the 4-way handshake is never started and this results in a 
failure with status 16 (group key handshake timeout). In your latest set 
of logs IWD actually again tries to connect to a different BSS and gets 
status 16 before trying yet again and hanging.

This actually seems similar to an issue I encountered with ath10k where 
the network interface would time out being brought up. Retrying would 
succeed but the driver would be in a similar state where IWD could 
authenticate/associate but no data frames (i.e. 4-way handshake) would 
be passed to userspace. Only solution (until upstream fixed the bug) was 
to unload/reload the driver when we detected this condition.

If you are able to physically attach to a device currently in this state 
you may be able to get more info. For example if IWD is stuck like this 
try disconnecting/reconnecting with iwctl or restarting IWD to see what 
happens. If you end up in the same state right away I'm 99.9% sure the 
driver is the entire reason your running into this.

Thanks,

James

