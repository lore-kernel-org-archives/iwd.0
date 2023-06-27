Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691F19501
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 15:15:07 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4Qr7Yg5M8zz9tcZ;
	Tue, 27 Jun 2023 17:15:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1687878903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2Rta249V47uYdFQ200XAmZwE0RW2hoLI/Y8MdP4ZCY=;
	b=ETfL7lkC7sBNeSZDDE064aZ3v3RBchqrPkTMoLKlHhU69qbC3FXjQ/lH4XD0Aay3OQ4R7x
	O1ZkFkefFhs4d4MNRDXZOGKp+RvrAeeFW2bpVNlFoYRzipxFQbs1G5+dIRb+e6/X/7Wgve
	92mhuVm/GwYOvE1OnZzhRRgySdvvVWXa76jmxs7HkyYsPphXV3KID3BCAg7wzCuSZ5NzQN
	ZteLubnzlOoLzXH4k/n0h9wmM+IzEMkvko2IlFa5QkGmUog1rcml6InDK1phA0n6qd4IMr
	/yc0EccHYSoFrCvgQAPOo3qfvYTNxGQ2wXylNR88LnBrwfJlw2uFGDIZzudakA==
Message-ID: <f959d408-4476-6092-8ab1-880ccdc78e8e@tavla.de>
Date: Tue, 27 Jun 2023 17:15:02 +0200
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
 <ca4ec1b7-b503-633c-bea8-dc2f3a8a50c3@tavla.de>
 <9182d9a0-4d77-fc23-ee46-cf995e0499e3@gmail.com>
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <9182d9a0-4d77-fc23-ee46-cf995e0499e3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

Am 27.06.23 um 17:04 schrieb James Prestwood:
> Hi Martin,
>
> On 6/27/23 7:38 AM, Martin Petzold wrote:
>> Hi James,
>>
>> Am 27.06.23 um 16:29 schrieb James Prestwood:
>>> Hi Martin,
>>>
>>> On 6/27/23 12:58 AM, Martin Petzold wrote:
>>>> Hi,
>>>>
>>>> I have a critical issue with iwd and kindly ask for feedback.
>>>>
>>>> We have an embedded device (no desktop) running Debian bullseye 
>>>> with custom 5.10.52 kernel (NXP patches; own configuration).
>>>>
>>>> We are using iwd 1.27-1~bpo11+1 from bullseye backports together 
>>>> with systemd from bullseye main.
>>>>
>>>> We use a bind mount to move the iwd state to a separate partition, 
>>>> because we do rootfs upgrades and want to keep the state.
>>>>
>>>> Yesterday and also once before our platform forgot a network (the 
>>>> *.psk file was gone). We did not call any command for this. As far 
>>>> as we can re-call we did not reboot the platform. Some time before 
>>>> this issue, we pulled the power of our router and the network was 
>>>> of course gone - back a few minutes later. I have no idea if this 
>>>> could be related or just co-incidence.
>>>
>>> The only way IWD removes a network profile is via "Forget()". You 
>>> could add a debug print inside 
>>> src/storage.c:storage_network_remove() if you were suspicious but I 
>>> highly doubt that has anything to do with it.
>>>
>>> I would guess it more has something to do with the bind mount. Are 
>>> you sure nothing touched /system/var/lib/iwd ?
>>
>> We first tried symlinks, but iwd does not accept symlinks for the 
>> state directory. I think it does not work because of the directory 
>> monitoring?
>>
>> Could it be possible that directory monitoring and bind mounts are in 
>> conflict?
>
> I just tested this and IWD properly sees changes in a bind mounted 
> directory, and then connect to the network who's profile I dropped 
> into my bind mount.
>
> But, if I run with network manager which disables autoconnect I just 
> see IWD scanning and never try to connect. Presumably because network 
> manager is never informed of the new network via its own profile. Are 
> you using NM by chance?

No, we have switched to systemd-networkd only (see configuration below). 
NetworkManager is not installed. We have our own custom debootstrap build.

The reason for using systemd-networkd is because of compatibility with 
systemd-timesyncd. We had a critical issue with RTC wakeup using ntp 
together with network manager. For that reason we also don't want to 
switch back to NetworkManager.

In general IWD ist working as expected. However, we just started 
intensive tests with network loss and re-connection. Then somehow the 
configuration was gone.

>
>>
>> Does systemd somehow manipulate the state directory (as it sets the 
>> environment variable $CONFIGURATION_DIRECTORY)?
>>
>>>
>>>>
>>>> Here are our configuration files:
>>>>
>>>> ########## /etc/systemd/network/20-wlan0.network
>>>>
>>>> [Match]
>>>> Name=wlan0
>>>>
>>>> [Network]
>>>> DHCP=yes
>>>>
>>>> IgnoreCarrierLoss=3s
>>>>
>>>> [DHCPv4]
>>>> RouteMetric=20
>>>>
>>>> ########## /etc/iwd/main.conf
>>>>
>>>> [General]
>>>> UseDefaultInterface=true
>>>>
>>>> [Network]
>>>> NameResolvingService=systemd
>>>>
>>>> ########## /usr/lib/systemd/system/var-lib-iwd.mount
>>>>
>>>> [Unit]
>>>> Description=Mount IWD state
>>>>
>>>> [Mount]
>>>> What=/system/var/lib/iwd
>>>> Where=/var/lib/iwd
>>>> Type=none
>>>> Options=bind
>>>>
>>>> [Install]
>>>> WantedBy=local-fs.target
>>>>
>>>> ##########
>>>>
>>>> Thanks,
>>>>
>>>> Martin
>>>>
>>>>
-- 
Martin Petzold (Inhaber & Geschäftsführer)

TAVLA Technology GmbH
Im Dau 14
50678 Köln
Deutschland

Telefon: +49 (0)221 / 3466 0885
Mobil: +49 (0)179 / 9220154
E-Mail: martin.petzold@tavla.de

