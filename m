Received: from relaygw1-5.mclink.it (relaygw1-5.mclink.it [213.21.178.148])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1B036A
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mclink.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mclink.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mclink.it header.i=@mclink.it header.b="m3Pi9o8F"
Received: from [172.24.30.45] (HELO cgp-esgout02-rm.mail.irds.it)
  by relaygw1-5.mclink.it (CommuniGate Pro SMTP 6.0.2)
  with ESMTPS id 244789756 for iwd@lists.linux.dev; Tue, 02 Jan 2024 01:34:08 +0100
X-Envelope-From: <mc5686@mclink.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mclink.it; s=mail;
	t=1704155642; bh=d0Z62QxVk+4YXql8Gc0PQ5qcnfsrw7E5UgJvNZ7JRpE=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=m3Pi9o8FZbig4TXKFZHs6SSF91hCSwHFxlFWBAaWi2GcXLnwFrojzV5MRT5s6C88E
	 z9QkUPtBENy3UHjzjIuDdd2KE99sO7sJyPRMlUDnQzD+8z9pT4tqtFMiVJh9dBIJoT
	 cOwfkUYDOtT6fysq7wx29uex40C12I9AxoMyHhm8=
Received: from [192.168.7.12] (host-79-56-220-30.retail.telecomitalia.it [79.56.220.30])
	(Authenticated sender: mc5686)
	by cgp-esgout02-rm.mail.irds.it (Postfix) with ESMTPA id 5C8C641AB9;
	Tue,  2 Jan 2024 01:34:02 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------vcFmzsimriz1WdyFSFJ3UXQ0"
Message-ID: <f477c1f4-4585-4b76-95a6-d0d31532e401@mclink.it>
Date: Tue, 2 Jan 2024 01:34:01 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Setup help request
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <5b97b06f-5047-4a1e-958d-27a6185ba504@mclink.it>
 <a345fe93-149b-46d6-bc00-ac35bb302858@gmail.com>
From: Mauro Condarelli <mc5686@mclink.it>
In-Reply-To: <a345fe93-149b-46d6-bc00-ac35bb302858@gmail.com>
X-Irideos-Libra-ESVA-Information: Please contact Irideos for more information
X-Irideos-Libra-ESVA-ID: 5C8C641AB9.A5C37
X-Irideos-Libra-ESVA: No virus found
X-Irideos-Libra-ESVA-From: mc5686@mclink.it
X-Irideos-Libra-ESVA-Watermark: 1704760442.72257@45ZdO/oelLjUvPRySBzShA

This is a multi-part message in MIME format.
--------------vcFmzsimriz1WdyFSFJ3UXQ0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,
Thanks for the fast reply.

Comments inline below.

On 1/2/24 00:03, James Prestwood wrote:
> Hi Mauro,
>
> On 1/1/24 11:26 AM, Mauro Condarelli wrote:
>> Hi,
>> I just installed `IWD version 2.3` on a small MiniPC (Beelink, if it matters) sporting a
>> `Intel Corporation Wireless 3165 (rev 81)` PCI Wireless adapter.
>> O.S. is a fairly up-to-date "Debian GNU/Linux 12 (bookworm)"
>> Installation was done via standard Debian package (`apt install iwd`)
>> I am trying to use it as Access Point (infrastructure).
>> I have in my config:
>> ---------------------------------
>> root@lxd:~# cat /etc/iwd/main.conf
>> [General]
>> EnableNetworkConfiguration=true
>> #AddressRandomization=network
>> #RoamThreshold=-70
>> #RoamThreshold5G=-76
>> [Network]
>> #NameResolvingService=resolvconf
>> #
>> #EnableIPv6=true
>> ---------------------------------
>> root@lxd:~# cat /var/lib/iwd/ap/beelink.ap
>> [Security]
>> Passphrase=****************
>>
>> [IPv4]
>> Address=192.168.250.1
>> Gateway=192.168.250.1
>> Netmask=255.255.255.0
>> DNSList=8.8.8.8
>> LeaseTime=3600
>> IPRange=192.168.250.200,192.168.250.209
>> root@lxd:~#
>> ---------------------------------
>>
>> I am testing manually so I did:
>>
>> ---------------------------------
>> root@lxd:/etc/systemd/network# /usr/libexec/iwd -d >/tmp/iwd.log 2>&1 &
>> [1] 112842
>> root@lxd:/etc/systemd/network# iwctl
>> NetworkConfigurationEnabled: enabled
>> StateDirectory: /var/lib/iwd
>> Version: 2.3
>> [iwd]# device list
>> Devices                                   *
>> --------------------------------------------------------------------------------
>>   Name                  Address               Powered Adapter Mode
>> --------------------------------------------------------------------------------
>>   wlan0                 84:c5:a6:4c:ff:31     on phy0        ap
>>
>> [iwd]# device wlan0 set-property Mode ap
>> [iwd]# ap wlan0 start-profile beelink
>> [iwd]# ap wlan0 show
>>                              Access Point Interface
>> --------------------------------------------------------------------------------
>>   Settable  Property              Value
>> --------------------------------------------------------------------------------
>>             Started               yes
>>             Name                  beelink
>>             Scanning              no
>>             Frequency             2437
>>             PairwiseCiphers
>>             GroupCipher           CCMP-128
>> [iwd]#
>>
>> [iwd]#
>>
>> root@lxd:/etc/systemd/network#
>> ---------------------------------
>>
>> Sometimes I can see a "beelink" SSID with Fritz sniffer app
>> or even from my desktop, but I was never able to connect.
>
> In the logs you see "Frame didn't validate as MMPDU". This means there was a malformed packet, or at least IWD thinks it was malformed. Could you get an iwmon capture while IWD is running and you attempt to connect with a client device? Also, have you tried connecting with several client devices (laptop, phone, etc)? That would tell us if its a specific client sending a bad frame, or a bug processing the frame. More info on how to do that here:
>
> https://iwd.wiki.kernel.org/debugging
>
> Note the capture will contain your devices MAC/SSID/PSK so if your worried about privacy you can send it just to me, or use a dummy passphrase just for the test, up to you.
I used the following script to reproducibly start IWD and friends:
---------------------------------
root@lxd:~# cat ./start_iwd.sh
#!/bin/bash

/usr/libexec/iwd -d >/tmp/iwd.log 2>&1 &
IWD_PID=$!

sleep 5
iwctl device list
iwctl device wlan0 set-property Mode ap
iwctl ap wlan0 start-profile beelink
iwctl ap wlan0 show

iwmon --write /tmp/iwmon.pcap >/tmp/iwmon.log 2>&1 &
IWMON_PID=$!

mc

kill $IWMON_PID
kill $IWD_PID
---------------------------------

While shell was active I:
- opened Fritz! `WLAN` app
   - it took ~30s to see a `beelink` network apparently spanning several channels
- tried to connect from my desktop
   - it did see a `beelink` AP a long time (>2m) after `WLAN` app saw it.
   - it tried several times to connect.
   - it never succeeded.
   - it didn't even ask for a passphrase.
- tried to connect using my Android Phone (the ssame running `WLAN`.
   - it never saw a `beelink` AP to attempt connection.

I attach all logs I took.
I changed password to "temp-password" so it can be shared as needed.

>
>>
>> I attach logs I am unable to interpret.
>>
>> Any hint about what to check/change would be very welcome as
>> I'm completely out of my depth here.
>>
>> Target would be to have (if at all possible, of course) a dual band (2.4G/5G)
>> bridged Access Point.
>
> Just a side note here, for a dual band access point you will actually need two separate adapters.
Is this an IWD limitation or is it general?
This adapter seems to have two independent radio channels.
In `WLAN` app I see the `beelink` AP only in the 2.4GHz band.

>
>>
>> Many Thanks in Advance.
>> Mauro

Thanks
Mauro
--------------vcFmzsimriz1WdyFSFJ3UXQ0
Content-Type: application/x-xz; name="iw.tar.xz"
Content-Disposition: attachment; filename="iw.tar.xz"
Content-Transfer-Encoding: base64

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
scRn+wIAAAAABFla

--------------vcFmzsimriz1WdyFSFJ3UXQ0--
