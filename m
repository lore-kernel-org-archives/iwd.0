Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2C250EC
	for <iwd@lists.linux.dev>; Thu, 23 Nov 2023 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5gsSpA8"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1f5eac85e0eso517866fac.1
        for <iwd@lists.linux.dev>; Thu, 23 Nov 2023 07:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700752923; x=1701357723; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2t4/jN3Z6qcxFdS29qxU4M+atCbgPq2HBfbOJE03vg=;
        b=e5gsSpA8DTnas3D2PYzMN7C5E6AoDOWSckLNtru+XnIFhEPOEfMUCEXlkH1SDRMsOQ
         7/Tzmjy4ERBrTYeojRjI3J58gtdnD7dfx3mcK7sEAO74NRwlp+RfDI86ktYge3BP2Znx
         zGhvL6Y6sUtKwmPg1D77GGM/xsrOCmkl7TAvoI0jOGuqCEpuSU56m+mWx7W94IZqa2Bu
         bf43iZgjYC//j+3zn8/7toatMEqmZ74eopRC42edsqr2uTemYgdYV3rf3Z9FTa1Zj2ZX
         YgkuzTjK6EXg+rBHkoqEfjhpwVIp5zOheLITMnDiOHfOu01jvbWaNsh7F3rTmVtfxmNE
         zHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700752923; x=1701357723;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2t4/jN3Z6qcxFdS29qxU4M+atCbgPq2HBfbOJE03vg=;
        b=kpvNwSgkYZdCPk1TRw8pvCvDiluNsfmhpUKpPYcMGChAEpBNRl06RgvW7uhHSFiWpZ
         iFoFZTWgTnAfO+ZIGWkpLeIkFCsN2viehdMAN46arVFCIURg9DndMHQ92YBsnN2gBAYX
         k0C7gcS+MQzDmcOn8b+fnKJGubkGEIvb1aqibrm/SmMAI6FLZkRyacNulBIoRV+TBXad
         0xW0zqi/TRu0rvtzpWf6HQBgpQTVxyQBpn6n8MCKSNFINN0WZfL9Gb10yx7WvqXusmuU
         W/7Ub9+XXiJa+C5tbK1ODyNu1UvlvCw7cqrQhnH0mosRm6epUO5Btc2WeY8gAjOEI6fK
         hjPQ==
X-Gm-Message-State: AOJu0YzfPpBJpQV1nh39eDTA4RzdYkM9hG1izKRd0DQZhS6Cd5c/VmmJ
	UMOYc4xdoaM4dkA412fcGfENwllZCZY=
X-Google-Smtp-Source: AGHT+IG2hHsMDguKbJfiH2hSiAMkkSKxum+wErlZmLo2zbaOndq7trj51rdJ7n7RMxiirR9esDfKRg==
X-Received: by 2002:a05:6871:7248:b0:1f9:5476:2c79 with SMTP id ml8-20020a056871724800b001f954762c79mr7338329oac.33.1700752923033;
        Thu, 23 Nov 2023 07:22:03 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ti3-20020a056871890300b001f9e3731545sm65559oab.11.2023.11.23.07.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 07:22:02 -0800 (PST)
Message-ID: <9bbd446d-75b6-4aff-955d-483cbeb8c08a@gmail.com>
Date: Thu, 23 Nov 2023 09:22:01 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: move power save disabling until after interface
 is up
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231121183321.179230-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231121183321.179230-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/21/23 12:33, James Prestwood wrote:
> Very rarely on ath10k (potentially other ath cards), disabling
> power save while the interface is down causes a timeout when
> bringing the interface back up. This seems to be a race in the
> driver or firmware but it causes IWD to never start up properly
> since there is no retry logic on that path.
> 
> Retrying is an option, but a more straight forward approach is
> to just reorder the logic to set power save off after the
> interface is already up. If the power save setting fails we can
> just log it, ignore the failure, and continue. From a users point
> of view there is no real difference in doing it this way as
> PS still gets disabled prior to IWD connecting/sending data.
> 
> Changing behavior based on a buggy driver isn't something we
> should be doing, but in this instance the change shouldn't have
> any downside and actually isn't any different than how it has
> been done prior to the driver quirks change (i.e. use network
> manager, iw, or iwconfig to set power save after IWD starts).
> 
> For reference, this problem is quite rare and difficult to say
> exactly how often but certainly <1% of the time:
> 
> iwd[1286641]: src/netdev.c:netdev_disable_ps_cb() Disabled power save for ifindex 54
> kernel: ath10k_pci 0000:02:00.0: wmi service ready event not received
> iwd[1286641]: Error bringing interface 54 up: Connection timed out
> kernel: ath10k_pci 0000:02:00.0: Could not init core: -110
> 
> After this IWD just sits idle as it has no interface to start using.
> 
> This is even reproducable outside of IWD if you loop and run:
> 
> ip link set <wlan> down
> iw dev <wlan> set power_save off
> ip link set <wlan> up
> 
> Eventually the 'up' command will fail with a timeout.
> 
> I've brought this to the linux-wireless/ath10k mailing list but
> even if its fixed in future kernels we'd still need to support
> older kernels, so a workaround/change in IWD is still required.
> ---
>   src/netdev.c | 86 +++++++++++++++++++++++++++-------------------------
>   1 file changed, 44 insertions(+), 42 deletions(-)
> 

Applied, thanks.

Regards,
-Denis


