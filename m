Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AFA2F4334
	for <iwd@lists.linux.dev>; Thu, 12 Jun 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749749269; cv=none; b=OvOQ3z2kmeggVlMLhmug1HSHooKFbYlJPKOPkBQ/2G3h2bxPda+s/bT1B5Zh7WrzCwS0CMr6kXB07w+V/tsapIcXQapVw4BfSTJ3qjMG37kMPIvYXhuCKwA87NrwVI64XneW2qFk+Tpt14WYsEP8JI9v86Xlkqt3zaYpAykEBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749749269; c=relaxed/simple;
	bh=QtsfLdwLZVd3K1HOK5eCYnWEeG9ldtPIwYOPo741yyM=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eiPscaQxjyD7cXE77iFDlmhOMT8zAV1oxvesuY5srVfOGAIjI3yW/dhVXEgVL0/cB1U0UGx9GcDBo/PoeonNR6ytd/fp1Q+t+SoWxQRMl4MpBqf2quB+ccNzkgndYcff+QYwPYg58yqi3nxjgWv/ZUEh3l0uMcA6SZ70x8saAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UuycBp1o; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UuycBp1o"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2350b1b9129so9766585ad.0
        for <iwd@lists.linux.dev>; Thu, 12 Jun 2025 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749749267; x=1750354067; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aO2Eti1FJInEcG7dFytqSbOYI3gGiaLkCVbzsILYkk=;
        b=UuycBp1oSUf1i7bTvgYZqlmYcrZGr8cebPN/5G/D7wUI6qMPeyhAT1ifhKa3H5LwIk
         xy2IyeSucvEb81/fcH8OZo/v3jNMPSXnq2s78dX+c5m94iWOGYEEF+6JD337TSZzmYme
         S2ZG+qxCeX7Pw+oJeIGVssCnIhByeBJ2jpEvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749749267; x=1750354067;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aO2Eti1FJInEcG7dFytqSbOYI3gGiaLkCVbzsILYkk=;
        b=S//pqvcpAOmPXtgY1eYVg3qlhtR2mcS/bl36JfG2mGU4mcA6X7cO4iCyB82xYaZlHZ
         ekGMV5qtg01qa87O6PgjO57s49lzhJcHMgLSr4gNwJ5QY8RguZv+4J+rtbCGAbQ301cr
         Cm6GgJLsA4W0vQb1lwyKGV/2OSC65hpAD351IanuMe/ghL28p3zq55IYIYp8YoAjA8KY
         SLBRpiGUJb1NjLW9WCbnHXrBTFMKCSWeo0bHiJuj2vA4Cye82L7BN/RuPB269iXwgUJa
         v5MIyzAOVKkFg9gzbNAmcTqlSkmWp+wH+h5Uc0rA7yWKntI9jQ+4ylLRQufJEMriUh0M
         GL4w==
X-Forwarded-Encrypted: i=1; AJvYcCXPa3vfG2DoLYBeUBPllhOZYdr06aLtOJnGwdkiSd3uLwyL4GzjOgUoDVUhHXX+6/H3P4I=@lists.linux.dev
X-Gm-Message-State: AOJu0YxTY/U0kM3JbmlJL7/Nyrk+MsuT8+25ZWLpEv+TNP60/MVI0Bsl
	C3IR+mjW5FQQd4XHQo+pMjTaeFIi5wwmWtzYyTI8dteAfvWbpYg6OFswnemR5M28huzy7t+JiPF
	iOzZu6Q==
X-Gm-Gg: ASbGnctcenTT7/OuLQZwKl0V+00lG+2eOOu2ZOqranODcT3i2+Qqpvt01N/M+3QgRKu
	Sa+fWwx02Yv1TAD1Q0qMeizNyS6s3fapicQqUxhwDSAZTX8evocJdViqoliugERejnUtEX2FANl
	ewYryjd0YD0H7B0APrtlnWt5SGUFcPbDFD7Z29xeoxKYg7EHPH+HHt39Nlmf4rBS/GrU02UFpo0
	k7PBMqix0pR8CmfvBbStYzB+0fstMI3U/UuBQjZkTeRpcAaa5WWztKOI1byH2Q++RDwPwdQGlKj
	BaZM04Xibr24v5OGvWdvDZq3AkNBffBwRPJQAnKUV/YmC89As6cKqyM2Zmtbv5TO0uREdvYv1E8
	OXprxMfofgNWLGISWT6PmsQgR
X-Google-Smtp-Source: AGHT+IHcnJAPxoP4z5MNIta4Ojplde8TlTwjF/MW8RlVToI/YhWK61H0NRZUhsnGtizBnIVY18UyCQ==
X-Received: by 2002:a17:902:e5cd:b0:234:eb6:a35b with SMTP id d9443c01a7336-2364ca65bcfmr71647535ad.44.1749749266891;
        Thu, 12 Jun 2025 10:27:46 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e63129csm17037475ad.70.2025.06.12.10.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 10:27:46 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>
CC: Denis Kenzior <denkenz@gmail.com>, <iwd@lists.linux.dev>, James Prestwood <prestwoj@gmail.com>
Date: Thu, 12 Jun 2025 19:27:43 +0200
Message-ID: <197652ee6b0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAG17S_PcYOFqbfKPnaNUsQ0AsJzWGRgGDRYrq9SgewUskqck_w@mail.gmail.com>
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
 <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com>
 <CAG17S_MKZXf3vC0zgaK_MUrA1nqRzhGcPGUho873KU3jYVShXw@mail.gmail.com>
 <45bc2f1b-b037-4784-a2a9-7732a82b7391@gmail.com>
 <CAG17S_MqLBQV6ktjbWsoAv0e+2A0dnNN5+X7Pf+b-qDP3mrL1Q@mail.gmail.com>
 <19691dcb210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_MX3S9=EmiHBae8WsRnmsUGBJ5h4d8kCmgdxYZ2Zaeh8Q@mail.gmail.com>
 <1fb12821-1707-4478-941b-9fbc007c4e9a@broadcom.com>
 <CAG17S_M9_-TG4YnHAwx2+O2bJ6sbEE75X=V0y4Pbxy222O3ZJg@mail.gmail.com>
 <CAG17S_Njkt7rFTk4Tn-KnLVS8kzA61KJGyWgNQ9kqx5M=s7DnA@mail.gmail.com>
 <38be0ddf-50ff-4ef9-bd98-748ffcfed2e1@broadcom.com>
 <CAG17S_NCAmDPa+jK=OPdF18H8Yuuio3czytaa2q5hMSJiKO9bw@mail.gmail.com>
 <CAG17S_MbUsp6Nu=idnk0p9sQLRJWg=G8oaE1X2kdjwZ_uH4KAA@mail.gmail.com>
 <CAG17S_PxYNxLpAMzXOuS6riv46G22zpOM0rT0D7Xp-usbWyo+A@mail.gmail.com>
 <196b5fd2b70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_PzWmDmFekBgtBj7VHPt-g2qU0+LSa9WzYi75aNR5Mb_g@mail.gmail.com>
 <CAG17S_NMk44gBa2B=xNyjhXVJuaeYVn-+T9u_8fid+r7k--56A@mail.gmail.com>
 <197649346d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_PcYOFqbfKPnaNUsQ0AsJzWGRgGDRYrq9SgewUskqck_w@mail.gmail.com>
User-Agent: AquaMail/1.55.1 (build: 105501552)
Subject: Re: brcmfmac disconnects when iwd scans
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On June 12, 2025 6:51:29 PM KeithG <ys3al35l@gmail.com> wrote:

> ...
>
> On Thu, Jun 12, 2025 at 9:37 AM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On June 12, 2025 3:51:34 PM KeithG <ys3al35l@gmail.com> wrote:
>>
>>> Arend,
>>>
>>> I am still seeing this:
>>> wpa_supplicant[431]: wlan0: Failed to initiate sched scan
>>>
>>> I tried the brcmfmac options listed above and got no change? Still
>>> getting this every 6 seconds in the log.
>>> Did I get the command in the modprobe conf wrong?
>>
>> Maybe. You could try to merge the two value so one line with 0x200002.
>> Could be that wpa_supplicant determines support for scheduled scan in an
>> unexpected way. Have not looked at the wpa_supplicant code for that.
>>
>> Regards,
>> Arend
>>
>>>
>>> On Fri, May 9, 2025 at 1:01 PM KeithG <ys3al35l@gmail.com> wrote:
>>>>
>>>>>>
>>>>>> With this setup, things work really well and the only strange thing I
>>>>>> am getting is a 'failed scheduled scan' message in the log every ~6
>>>>>> sec.
>>>>>>
>>>>>> May 09 08:53:50 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>>>> sched scan
>>>>>> May 09 08:53:57 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>>>> sched scan
>>>>>> May 09 08:54:03 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>>>> sched scan
>>>>>> May 09 08:54:09 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>>>> sched scan
>>>>>> May 09 08:54:16 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>>>> sched scan
>>>>>> May 09 08:54:22 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>>>> sched scan
>>>>>
>>>>> I thought wpa_supplicant had a config option to disable scheduled scan, but
>>>>> can not find it. You can disable it in brcmfmac using feature_disable=2
>>>>> modparam.
>>>>>
>>>>> Regards,
>>>>> Arend
>>>> Arend,
>>>>
>>>> Thanks. I must be doing something wrong as I still get the 'Failed to
>>>> initiate scan' spammed in the log with this config:
>>>>
>>>> # cat /etc/modprobe.d/brcmfmac.conf
>>>> options brcmfmac feature_disable=0x200000
>>>> options brcmfmac feature_disable=2
>>>>
>>>> Do I have it formatted wrong?
>>>>
>>>> Keith
>>>>
>>>> I think you suggested the the first line due to a different log
>>>> spamming message.
> Arend,
>
> Thanks for the help, but that does not seem to change anything. My
> modprobe.conf:
>
> # cat /etc/modprobe.d/brcmfmac.conf
> options brcmfmac feature_disable=0x200002
>
> Still lost of the same "wpa_supplicant[423]: wlan0: Failed to initiate
> sched scan" every 6 seconds.
>
> When I reboot, I get these mesages wrt wpa_supplicant (journalctl | grep wpa):
> Jun 12 11:05:48 pi4 systemd[1]: Created slice
> system-wpa_supplicant.slice - Slice /system/wpa_supplicant.
> Jun 12 11:05:51 pi4 systemd[1]: Started wpa_supplicant@wlan0.service -
> WPA supplicant daemon (interface-specific version).
> Jun 12 11:05:53 pi4 wpa_supplicant[423]: Successfully initialized 
> wpa_supplicant
> Jun 12 11:05:54 pi4 wpa_supplicant[423]: nl80211: kernel reports:
> Registration to specific type not supported
> Jun 12 11:06:07 pi4 wpa_supplicant[423]: wlan0: Failed to initiate sched scan
> lots more...
> Jun 12 11:07:51 pi4 wpa_supplicant[423]: wlan0:
> CTRL-EVENT-REGDOM-CHANGE init=USER type=COUNTRY alpha2=US
> Jun 12 11:06:07 pi4 wpa_supplicant[423]: wlan0: Failed to initiate sched scan
> lots more...
>
> yet when I look, it seems it has scanned and are there SSIDs:

Right. Scheduled scan is a different API compared to the normal scan. It 
allows userspace to say "scan periodically and let me know when you see any 
of the ssids I am interested in" to the driver/firmware and go take a nap.

If I remember correctly wpa_supplicant does a couple of normal scans and 
when it doesn't see the ssids in its config file, it switches to using the 
scheduled scan api.

Regards,
Arend

> # wpa_cli scan_results
> Selected interface 'wlan0'
> bssid / frequency / signal level / flags / ssid
> c0:94:35:54:bb:10       5220    -59     [WPA2-PSK-CCMP][WPS][ESS]
> AlignedHedronNetwork
> d2:94:35:54:bb:10       5220    -69     [WPA2-EAP-CCMP][ESS][HS20]
> Xfinity Mobile
> c6:4f:d5:4b:36:c0       5785    -68     [WPA2-PSK-CCMP][ESS]
> c6:4f:d5:4b:36:c2       5785    -68     [WPA2-PSK+SAE-CCMP][ESS]
> ameliafanclub



