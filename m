Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359FB17FF3
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 14:38:52 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4Qr6ls28GSz9vMX;
	Tue, 27 Jun 2023 16:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1687876729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/GtcEGheucT9bz/RVkKfD0KUgektDkOx8dEVeBVyq4=;
	b=iM9b5591fXAHLz56LEwVICYsum2eSvsk1IyZc9S2evY/DiEDOp0pJCrcXwqcEA74slDkYY
	MKxcqIpE19z8DaQwbXnR/Tb4rahwhBj8xCns3qdWodTzx4B0nya55iJgnEmX7EyvGa17PL
	nbXElX/1IXzOklSeVJ8AUHHcClH+KY0wkaNhw6fWa47UygpEAD+BxONuK8vw7C/7nitvhY
	1kJHYgimYkjA4tiX29+CU5MtHfzG3cKKBrnd3rRBWy+taNNaTQqjrRWyQHfz0jDJ8NWQ7K
	16vNChX6KaECkGhl0iFZGd1FM8oPovLbqv44ud6P1dsruvAOsW17KncDr/hUOw==
Message-ID: <ca4ec1b7-b503-633c-bea8-dc2f3a8a50c3@tavla.de>
Date: Tue, 27 Jun 2023 16:38:48 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: iwd forgets network
Content-Language: en-GB
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
 <c341680a-01b6-cd2a-1826-ba868a02d4f3@gmail.com>
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <c341680a-01b6-cd2a-1826-ba868a02d4f3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Qr6ls28GSz9vMX

Hi James,

Am 27.06.23 um 16:29 schrieb James Prestwood:
> Hi Martin,
>
> On 6/27/23 12:58 AM, Martin Petzold wrote:
>> Hi,
>>
>> I have a critical issue with iwd and kindly ask for feedback.
>>
>> We have an embedded device (no desktop) running Debian bullseye with 
>> custom 5.10.52 kernel (NXP patches; own configuration).
>>
>> We are using iwd 1.27-1~bpo11+1 from bullseye backports together with 
>> systemd from bullseye main.
>>
>> We use a bind mount to move the iwd state to a separate partition, 
>> because we do rootfs upgrades and want to keep the state.
>>
>> Yesterday and also once before our platform forgot a network (the 
>> *.psk file was gone). We did not call any command for this. As far as 
>> we can re-call we did not reboot the platform. Some time before this 
>> issue, we pulled the power of our router and the network was of 
>> course gone - back a few minutes later. I have no idea if this could 
>> be related or just co-incidence.
>
> The only way IWD removes a network profile is via "Forget()". You 
> could add a debug print inside src/storage.c:storage_network_remove() 
> if you were suspicious but I highly doubt that has anything to do with 
> it.
>
> I would guess it more has something to do with the bind mount. Are you 
> sure nothing touched /system/var/lib/iwd ?

We first tried symlinks, but iwd does not accept symlinks for the state 
directory. I think it does not work because of the directory monitoring?

Could it be possible that directory monitoring and bind mounts are in 
conflict?

Does systemd somehow manipulate the state directory (as it sets the 
environment variable $CONFIGURATION_DIRECTORY)?

>
>>
>> Here are our configuration files:
>>
>> ########## /etc/systemd/network/20-wlan0.network
>>
>> [Match]
>> Name=wlan0
>>
>> [Network]
>> DHCP=yes
>>
>> IgnoreCarrierLoss=3s
>>
>> [DHCPv4]
>> RouteMetric=20
>>
>> ########## /etc/iwd/main.conf
>>
>> [General]
>> UseDefaultInterface=true
>>
>> [Network]
>> NameResolvingService=systemd
>>
>> ########## /usr/lib/systemd/system/var-lib-iwd.mount
>>
>> [Unit]
>> Description=Mount IWD state
>>
>> [Mount]
>> What=/system/var/lib/iwd
>> Where=/var/lib/iwd
>> Type=none
>> Options=bind
>>
>> [Install]
>> WantedBy=local-fs.target
>>
>> ##########
>>
>> Thanks,
>>
>> Martin
>>
>>
