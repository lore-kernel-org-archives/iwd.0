Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A811D27BA
	for <iwd@lists.linux.dev>; Sat, 26 Oct 2024 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729936872; cv=none; b=BlbuaSu7qi5M/95TKhrGeG7DQGXCCoW8ANVZvZhwcrh3sHl30bcpPz75JcF9I23PYi7vS0L1PM1sgWejm5EOlHdmWSJ4ipZIaxlhJkAIiwwad6zPdzc+CKa1rxd6xNsgO4y8EAKQvd731ZstqXvMqtrKu7Kj569jcA9Tku6Vbwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729936872; c=relaxed/simple;
	bh=Dar/nei0iaIf1ZAtGAY/jUb1vGmOhABhVyHCKucJUrQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bkEufUkY2WXUQwC9QSoSyChVfAi889Gg3cxxPdGw+0ypBhVQgIFG6hj5XKIn2tVzIxnNp4F6UCBQGYqR/1rF17+k4NW08HNqmdo4QIFW4UsthzfMb+Txx9IS6PzCelF0c6nf99buMiVzm9NF3Dvw07xcns/33oNCC7dcGXtbUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=LR45SzxS; arc=none smtp.client-ip=195.10.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="LR45SzxS"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4XbFXb3yQ6z9tLN;
	Sat, 26 Oct 2024 12:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1729936863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvQIVJHQ/6ofOt+gelwgpTfl4oXHBOoVCKFf2TLdbwM=;
	b=LR45SzxSy7dgELveagLLXoq9wWJIRtKxIf/VYqlQ5hvA68LW8AjufuDwzschFg2bZcoA/7
	V7UaPxgqY5H2v+g9W+FuIuyApbNTGzYTVUKiABjA/9bZuT6R5LMYFH7Lm++EZkOF7hCq8y
	x8JkdQuZcr44yqj5RRPEUaAu2mQB70UF9dRvdnu14b7N4Le70yStKpis3iFMQJAfgXhYeK
	kGwBSbrOv3o0F41U4+12F84kteFL9K2LeZHtkYiEchB5tlaqtyt6yojKIwBm0r30VP0zqp
	VBKRu/u7Bu+RF02JOIfO8oM6x/Iu6D823CnXyA9hIKBNrtee8NFkj7IcYrFwFA==
Message-ID: <d2ffeca4-8188-4417-9f89-ac4aa94ffa5d@tavla.de>
Date: Sat, 26 Oct 2024 12:01:01 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Connection loss (IWD HEAD with latest OWE / BSS selection
 patches) - brcmfmac driver
From: Martin Petzold <martin.petzold@tavla.de>
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
 <0f83e2f7-eb3c-41a6-aa43-e0c0b89cedef@tavla.de>
Content-Language: en-GB, de-DE
Organization: TAVLA Technology GmbH
In-Reply-To: <0f83e2f7-eb3c-41a6-aa43-e0c0b89cedef@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

Am 26.10.24 um 00:22 schrieb Martin Petzold:
> Hi all,
>
> Am 25.10.24 um 17:17 schrieb James Prestwood:
>>> [...]
>>> I'm quite sure this is related to your BSS / AKM patch. It happened 
>>> on a client here after an image upgrade to this version. I have 
>>> never seen this before.
>> For WPA2 those patches _should_ have zero effect. Based on your logs 
>> the behavior here is entirely different than with OWE. Before the 
>> connection to the OWE network was actually failing (failed within 
>> brcmfmac). Here IWD tried to connect and got no event back from the 
>> driver. To know this without a doubt we would need to to run iwmon 
>> and see the communication between IWD and the kernel.
>>>
>>> Also, I have debugging for BRCM enabled (CONFIG_BRCMDBG=y and 
>>> CONFIG_DEBUG_FS=y). It sounds strange if there is no output, even 
>>> not before.
>>
>> Maybe Arend has some idea of why userspace could send a CMD_CONNECT 
>> and get no associated CMD_CONNECT event?
>>
>> The fact that even manually connecting didn't work after this 
>> happened tells me the driver is "stuck". Did you try cycling the 
>> driver with modprobe?
>
> There may have been a problem on my side, sorry. I will come back, if 
> I see this again.

I found a bug on our side, which results in too many IWD agent requests 
if the networks constantly goes down and up again. It seems then at some 
point in time this leads to a deadlock of the network (what we have 
seen). However, I fixed this and still I have some devices constantly 
going away and coming back (currently only in the OWE Transition network).

I would like to ask you some questions in order to maybe narrow down the 
problem:

1. I have systemd-networkd configured for the Ethernet interface 
(however, our devices don't have a network cable connected!) + IWD with 
EnableNetworkConfiguration=true. Could this be in conflict?

-----

[Match]
Name=eth0

[Network]
DHCP=ipv4

[Link]
RequiredForOnline=no

-----

[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
EnableIPv6=false

[DriverQuirks]
OweDisable=brcmfmac

-----

2. I have systemd-resolved enabled (Debian bookworm package should 
create the link / stub) and set in IWD configuration 
(NameResolvingService=systemd). Anything else to do?

3. Could it be a problem that I poll the state from iwctl every 10 
seconds? (yes, I will switch to dbus, once I find some time for that!)

4. I disabled IPv6 in IWD (EnableIPv6=false) because I first was trying 
IWD 1.x before and there it was disabled by default (and I wanted to 
rule out problems from IPv6). networkd Ethernet interface is configure 
with DHCP=ipv4.

5. As I wrote in 4., networkd is configured with DHCP=ipv4. Could there 
be some DHCP conflict between IWD and networkd?

Also, I will write another message to the list calling for the IWD team 
and Broadcom to better support the BCM chips. My SOM vendor Variscite is 
world leading and they use NetworkManager with BCM4339 without any 
problem in their BSP / SDK (as they say, and of course I am just before 
switching back to that).

This means for me there is some problem with IWD and of course 
integration of IWD and brcmfmac. However, this will never work, if IWD 
does not have BCM devices in their tests and Broadcom / Cypress does not 
have IWD in their tests. IWD is openly declared as the successor of 
wpa_supplicant, and also promotet in Debian documentation starting from 
11. I know that Intel is a good sponsor of IWD, I hope that Broadcom / 
Cypress don't fall into a a trap, when IWD always works like a charm 
with Intel chips and produces only headaches (and in my case potentially 
million loss) when using BCM chips. As I find on the list and elsewhere, 
there are a lot of problems. On the other side, it is the "job" of the 
IWD team of course - maybe Broadcom / Cypress should step in in order to 
remain world leader?!

Thanks,

Martin

