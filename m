Received: from relaygw4-8.mclink.it (relaygw4-8.mclink.it [213.21.178.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E3010955
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mclink.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mclink.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mclink.it header.i=@mclink.it header.b="Gnztqzcr"
Received: from [172.24.30.44] (HELO cgp-esgout01-rm.mail.irds.it)
  by relaygw4-8.mclink.it (CommuniGate Pro SMTP 6.0.6)
  with ESMTPS id 242116102 for iwd@lists.linux.dev; Tue, 02 Jan 2024 15:07:49 +0100
X-Envelope-From: <mc5686@mclink.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mclink.it; s=mail;
	t=1704204464; bh=MDSLaQMTHKn3rP1xqfS3sqrh9AtFql080lIfPpEvMGs=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=GnztqzcrolNDrZtnj/xWs4ENeMyO4QtaZo1JXtqr5hlKc7rlwsu5IwIwwxava8FdC
	 HlbyjObbw3gcUpQ1xBFWnIUY059oF7WH6q6glFLJzGvOn3h7XrYZvV1xr22ZUmjDG0
	 YCx2h8xhkDlYVpI1oirqXIrB37FR5XzPGL26GoP8=
Received: from [192.168.7.12] (host-79-56-220-30.retail.telecomitalia.it [79.56.220.30])
	(Authenticated sender: mc5686)
	by cgp-esgout01-rm.mail.irds.it (Postfix) with ESMTPA id 8CA6D41ACC;
	Tue,  2 Jan 2024 15:07:44 +0100 (CET)
Message-ID: <2aaed79f-9fae-4750-8e85-994a48a45da1@mclink.it>
Date: Tue, 2 Jan 2024 15:07:44 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Setup help request
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <5b97b06f-5047-4a1e-958d-27a6185ba504@mclink.it>
 <a345fe93-149b-46d6-bc00-ac35bb302858@gmail.com>
 <f477c1f4-4585-4b76-95a6-d0d31532e401@mclink.it>
 <b3c259af-ee4f-488c-ad81-a734302fc6d6@gmail.com>
Content-Language: en-US
From: Mauro Condarelli <mc5686@mclink.it>
In-Reply-To: <b3c259af-ee4f-488c-ad81-a734302fc6d6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Irideos-Libra-ESVA-Information: Please contact Irideos for more information
X-Irideos-Libra-ESVA-ID: 8CA6D41ACC.A4AF2
X-Irideos-Libra-ESVA: No virus found
X-Irideos-Libra-ESVA-From: mc5686@mclink.it
X-Irideos-Libra-ESVA-Watermark: 1704809264.87943@lgjdRPt27jUzx7gd9hXYXw

Thanks James,
comments inline below.

On 1/2/24 14:01, James Prestwood wrote:
> Hi Mauro,
>
> On 1/1/24 4:34 PM, Mauro Condarelli wrote:
>> Hi James,
>> Thanks for the fast reply.
>>
>> Comments inline below.
>>
>> On 1/2/24 00:03, James Prestwood wrote:
>>> Hi Mauro,
>>>
>>> On 1/1/24 11:26 AM, Mauro Condarelli wrote:
>>>> Hi,
>>>> I just installed `IWD version 2.3` on a small MiniPC (Beelink, if it matters) sporting a
>>>> `Intel Corporation Wireless 3165 (rev 81)` PCI Wireless adapter.
>>>> O.S. is a fairly up-to-date "Debian GNU/Linux 12 (bookworm)"
>>>> Installation was done via standard Debian package (`apt install iwd`)
>>>> ======8<----------- SNIP
>> I used the following script to reproducibly start IWD and friends:
>> ---------------------------------
>> root@lxd:~# cat ./start_iwd.sh
>> #!/bin/bash
>>
>> /usr/libexec/iwd -d >/tmp/iwd.log 2>&1 &
>> IWD_PID=$!
>>
>> sleep 5
>> iwctl device list
>> iwctl device wlan0 set-property Mode ap
>> iwctl ap wlan0 start-profile beelink
>> iwctl ap wlan0 show
>>
>> iwmon --write /tmp/iwmon.pcap >/tmp/iwmon.log 2>&1 &
>> IWMON_PID=$!
>>
>> mc
>>
>> kill $IWMON_PID
>> kill $IWD_PID
>> ---------------------------------
>>
>> While shell was active I:
>> - opened Fritz! `WLAN` app
>>   - it took ~30s to see a `beelink` network apparently spanning several channels
>> - tried to connect from my desktop
>>   - it did see a `beelink` AP a long time (>2m) after `WLAN` app saw it.
>>   - it tried several times to connect.
>>   - it never succeeded.
>>   - it didn't even ask for a passphrase.
>> - tried to connect using my Android Phone (the ssame running `WLAN`.
>>   - it never saw a `beelink` AP to attempt connection.
>>
>> I attach all logs I took.
>> I changed password to "temp-password" so it can be shared as needed.
>
> I think there is more going on but for starters it appears whatever app your using to scan is sending an invalid probe request frame. This causes IWD to ignore it which seems like the reason you cant even see the AP in the scans. I've attached a patch you can test, but I'm not sure this is something we can really upstream since its out of spec. The concerning IE is Extended capabilities, this is something IWD actually uses and parses, so the fact there is a duplicate and each one is different makes it impossible to know which one we should use. The probe request is including multiple entries for "Extended Capabilities" and "FILS Request Parameters (tag 258)". With the patch applied, and some other modifications to iwmon you can see two entries for these IEs:
>
>                     Extended Capabilities: len 10
>                         Capability: bit  2: Extended channel switching
>                         Capability: bit 17: WNM-Sleep mode
>                         Capability: bit 19: BSS transition
>                         Capability: bit 25: SSID list
>                         Capability: bit 46: WNM- Notification
>                         Capability: bit 62: Opmode Notification
>                         04 00 0a 02 00 40 00 40 80 01                    .....@.@..
>                     Tag 258: len 2
>                         00 12                                            ..
>                     Extended Capabilities: len 10
>                         Capability: bit 17: WNM-Sleep mode
>                         Capability: bit 19: BSS transition
>                         Capability: bit 25: SSID list
>                         Capability: bit 46: WNM- Notification
>                         00 00 0a 02 00 40 00 00 00 01                    .....@....
>                     Tag 258: len 2
>                         00 ff
>
> If this patch doesn't resolve the issue could you re-run the test and start iwmon at the very beginning, prior to starting IWD?
I'll do it ASAP, but it will take a bit of time since I'll have to compile from sources (I installed from standard Debian package).

Notice I'm not using anything "strange" for scans:
- normal Debian Sid Network Manager applet from desktop (which sees "beelink")
- normal Android phone `WiFi` Settings from phone (MIUI 12.0.3 on POCOPHONE F1, if relevant) (does *not* see "beelink")
Both are working as expected with several other Access Points.
It seems (to my limited insight) unlikely they're sending invalid probe requests.

>>>>
>>>> ======8<----------- SNIP
>>>>
Thanks
Mauro

