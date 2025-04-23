Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79220D4F8
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419342; cv=none; b=snXSN0rga2OUwVm4vRKBmjaYpj1oEIame0pwQvVpFB8AK/d3CLc7H78ZxLyiiftDOib6dyNOlgvRP0conbIpvPv3xmoasLNLAoYDZw7m0QzkdGuLh4dC2vzjLk9K6hX6Vsfl8d9HY99NpU9gPcJzEwiy3iJDcNsnvNavVcZy0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419342; c=relaxed/simple;
	bh=WgmtX7j4fLdqJb2wUVk61puqwF1p/DJMBKm/VaxoCZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2ZHZy+7nZtBb2Hn58REcWsYhOnxMR/KYmQoIPH0HjFEGfLf+zly9uUGL/6Ae7iZ+SV3RSh6AsqoE8u0PiE448ASoTMkW+5vLomqb2vaJJEwHfRGeydq6TrXIvB5XmCuVgsJj/9Yy0h3jUuyTi+IBuQ6+OxTs3hm4atPNVSLH9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+l7ynsu; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+l7ynsu"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-401c43671ecso532604b6e.0
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745419340; x=1746024140; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4QwDM8KiBR5omEHHoPTZqwnNJBWBxSA5lyvw1hs4gI=;
        b=W+l7ynsulX09jjurcVYGjl4Hpm6UMrWAfqAwQEy5ffkUzlKgs75H56GVtLh+c79usT
         BkIKfkSNCDmatFMD8Ou9ISFyRtr62l9bNSBphSizIEkYbYVUBwNgpxlLvjpNZIHtA4cG
         5pe6NuUwB2u8zZyjr3rrVAiQc9OzxT4z9DenvV/e8FCcHuJiqg+uBRmaEWOKVmcRtDOT
         WymTZvX126lVt7n+OUXOcX5ZC8R7Y7jU+relhAM9r6oxrvy/OYOn2X6pOfEeYIp6Hcsa
         r5gyxrd5gHV3yDtlx9AZmMQg9vYXQFzacr/73+hi8aG+neujcAFTSj/xx/2HHtf/49Df
         tGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419340; x=1746024140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4QwDM8KiBR5omEHHoPTZqwnNJBWBxSA5lyvw1hs4gI=;
        b=v4dBLmFS16QxhcFrMSp1v9owW3xcHvNq2nD0oL7c5uxB1e/2sr9jJ1DKiCsOeipQWg
         6O/yGQ62y9f1O74198ivbK6PqDFqFt65Nkch0qtdwrklvDr/EePDeH+eSNlokNzJKdrx
         LjhSAzmuZpyMKPWEZJssv631FGvPthznggNGt/E4tY16yvs2se+9qB3cy4jTaZSSFoQ0
         xF2sSDPKuuEhKukrrzdyKu18FpNR/uEBimv/Eo0+9Lf6tWlGk98e4b8uRDMvryT/V30c
         UyWaaN+kVHqiRCVju0hs9jP63bPB7uXi3Czu0JbYQjEnuQd4BqBm0AOL+N0uzTQVwOsf
         YIiw==
X-Forwarded-Encrypted: i=1; AJvYcCWAdmAKGYHQTpJ47IG/oBmY07U8pmYtYmCuG7X6ffHkfDguGC/mzyAhC9jFPT4307GbkB0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzjk5dU3Y7zzeUxM8iSVrRN5OQvTGjwOIW4XIWY/fXNkBR1yS/B
	3+AWBnsWoez7wjSFT0iw6XsFZPwJ5hgthOuLNQqCWzfJFyhAB7m1
X-Gm-Gg: ASbGncs2BRMFIFwe2QaDh/wf2HCDra60XG4fkxBA8DHHtEU6pcbLFmfc0a3bciFONSX
	5gIIWn48PsLAL5/8hf3cyvkpOdf56jqES3fBqjcIHXEimhdglI9TLP8uZR3DnJjVhydfe3XEFse
	Ku3TlDpGKg6my29RGr0YqOTxVbWIRHduzQ1brOrcJO6nzMrrGQIaa9zKzqmg1W7GHZJqIWE7AqJ
	rPw8j4wvTy5bw2nBKehFNaA1t5JRWjVrwpijw3fTtM3dArDESNgEBCa8kGa65qsqqDT4wU9O4Rr
	O+VmjpesEOixrKgFG6LVwcRbsiqn56+j9PGgtBClQSdEdvpxa55b8FN27AmlIzzneoGUSrw1MNo
	MZDrcY/A1pOgDsSxi
X-Google-Smtp-Source: AGHT+IEoc6vUTeNS7Ka+RMs8XMUlT18jqnxiZSFq6nL3FF29iOS8FrXwhKm9WID+x8mcB6lkb0oHLw==
X-Received: by 2002:a05:6808:1896:b0:3f9:aeb6:6e92 with SMTP id 5614622812f47-401e40ad633mr1682361b6e.9.1745419340359;
        Wed, 23 Apr 2025 07:42:20 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-605ff6aacf5sm2580757eaf.39.2025.04.23.07.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:42:19 -0700 (PDT)
Message-ID: <a0dcf03d-3bd3-43e5-9532-5a565d20930f@gmail.com>
Date: Wed, 23 Apr 2025 09:42:18 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac disconnects when iwd scans
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
References: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAG17S_M4_+CR1uSsajyvHBjig6cfCuxegipnHREhk1sXjSyOsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 4/22/25 8:00 PM, KeithG wrote:
> I ran into this a while back and James came up with a few patches that
> I have been using to keep it from restarting the AP0 interface.
> [PATCH 1/3] station: remove scan subsets for dbus scans
> [PATCH 2/3] eap: fix compile issue on ARM/GCC 12
> [PATCH 3/3] scan: use ifindex and only active scans

Likely this is the fix.  Passive scans take too long to remain off-channel.

> 
> These no longer seem to work with current builds of iwd from git. I am
> running iwd 3.6.r10.g4ded663e. My kernel is 6.12.20. The firmware is:
> [    3.496006] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [    3.839254] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> wl0: Oct 28 2024 23:27:00 version 7.45.286 (be70ab3 CY) FWID
> 01-95efe7fa
> 
> I get the same response with the firmware that ships with RPiOS,
> 7.45.265 as well. I am building a fresh kernel to be able to get iwmon
> data and should be able to do so tomorrow.
> 
> This flakiness of ap0 happens regardless if I use iwd or hostap to
> bring up ap0. When I use hostapd, I use this to bring up the
> interface:
> 
> iw dev wlan0 interface add ap0 type __ap
> ip link set dev ap0 address d8:3a:dd:60:a3:cg
> systemctl start hostapd
> systemctl start dnsmasq
> ip addr add 192.168.5.1/24 broadcast 192.168.5.255 dev ap0
> 
> With this, I can have the ap0 up and can scan on wlan0 with the single
> brcmfmac card. If I use wpa_supplicant, ap0 does not go down when
> wpa_supplicant scans for ssids.
> iw wlan0 scan

This uses an active scan.  See what happens with
'iw wlan0 scan passive'

> It is only with iwd that the network goes down when iwd scans for ssids.
> iwctl station wlan0 scan

iwd uses active scans when connected or if the hardware is capable of 
anonymizing the active scan.   Otherwise it uses a passive scan.

Regards,
-Denis
