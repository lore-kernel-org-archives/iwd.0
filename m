Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F81139E
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 03:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729654993; cv=none; b=sTxrbl7gEz0dlZtaSvoNHX0dkOYnDMlIORf48r89LrqBjfW/2NUBcZPOhHI02jJgc4HIzya2NQZA0hcpOq8VmGzwuItf0ZWuppjHVbuCWPoaace/BxS4C4I5mc0MH/ebfcxv/jdvIEk0ya1m7VWgYvYEY/IXkfu0v6aaJV9LfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729654993; c=relaxed/simple;
	bh=3kH5M6a1AMSkdy+wMiDY7cCaggMIWDf96cp40mkg3mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asCmU8l1FK+FHHQ/ueiNiZyVWDJFTvPCIQ7vZvK/0I1rtGGPfHwuDSzm3f/GJSnEg42eHOizxP5KydJqHMwR3FpNiMGMB50vLp6+V4NgcewbTNv2/bkpRRFM4JEQwqZNMoRrnu5KjdYbQmXu95YevupARYQt2X3yz1wG97NHz7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeec7.dynamic.kabel-deutschland.de [95.90.238.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E223A61E5FE05;
	Wed, 23 Oct 2024 05:43:05 +0200 (CEST)
Message-ID: <df73374e-5403-4daf-bfb4-131ffb2fd421@molgen.mpg.de>
Date: Wed, 23 Oct 2024 05:43:04 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: After switching to iwd WLAN device *wlan0* not renamed to
 *wlp58s0* anymore
To: Rhys Perry <rhysperry111@gmail.com>
Cc: iwd@lists.linux.dev
References: <a10efe9d-2b00-41dc-96bc-af02e7581f0c@molgen.mpg.de>
 <CAGTBY+uAGOoq5wWc6LVcLd3tB=a95R6Ox86Kfs_-t1nfEur-Aw@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAGTBY+uAGOoq5wWc6LVcLd3tB=a95R6Ox86Kfs_-t1nfEur-Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Rhys,


Thank you for your reply.

Am 22.10.24 um 22:44 schrieb Rhys Perry:

> I believe the behaviour you're seeing can be described here[1]. tl;dr:
> is iwd disables predicable udev device naming by default and you can
> fix it by masking the unit file that does that:
> 
>     ln -s /dev/null /etc/systemd/network/80-iwd.link

Indeed, removing the file gets me the message back. What boggles me is, 
that I do not have systemd-networkd enabled/running:

     $ systemctl status systemd-networkd
     ○ systemd-networkd.service - Network Configuration
          Loaded: loaded 
(/usr/lib/systemd/system/systemd-networkd.service; disabled; preset: 
enabled)
          Active: inactive (dead)
     TriggeredBy: ○ systemd-networkd.socket
            Docs: man:systemd-networkd.service(8)
                  man:org.freedesktop.network1(5)
        FD Store: 0 (limit: 512)

But after enabling predictable udev device naming again, `wlp58s0` is 
only shown as the altname:

     $ ip l show dev wlp58s0
     3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue 
state UP mode DORMANT group default qlen 1000
         link/ether 9c:b6:d0:d1:6a:b1 brd ff:ff:ff:ff:ff:ff
         altname wlp58s0

Does somebody have more ideas?


Kind regards,

Paul


> [1] https://wiki.archlinux.org/title/Iwd#Wireless_device_is_not_renamed_by_udev
> 
> On Tue, 22 Oct 2024 at 21:31, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>>
>> Dear Linux folks,
>>
>>
>> I am using Debian sid/unstable with *iwd* 2.22-1.
>>
>> Before switch from wpa_supplicant to iwd, my WLAN device was renamed
>> from `wlan0` to `wlp58s0`.
>>
>>       kernel: ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
>>
>> Since switch to iwd, the device name stays `wlan0` and the message is
>> not there anymore. Strangely the behavior remains the same, when
>> disabling iwd again, and switching back to wpa_supplicant. Does somebody
>> know what I need to do to revert to the old behavior of the device
>> renaming to `wlp58s0`?
>>
>>
>> Kind regards,
>>
>> Paul
