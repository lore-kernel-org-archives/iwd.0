Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7539218ABA
	for <iwd@lists.linux.dev>; Mon, 19 May 2025 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690760; cv=none; b=uG+hxYxRaEXsG/ZJgjDK9GzmiylsDnsR3w83UCzXjCmE6NM2i11LJiTgkpE07O1+Knp0XxmeDWCtCvlsPS8BdB0YVum0Vt9zlbdpv7KnfEa/EB2XIU94R0SRLTxveI9dM3k/l/SjXAe9YYfY+1SUQhQ7iRP5iHHCEgHn2Z86EXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690760; c=relaxed/simple;
	bh=l3LSh0dr4lThTBZ3YsOucXhfl2dMQqJBwNdYe8wzDOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fk5yjymfEn+QR1Ll17XE58fgPbsIaDhDILlt4IuRNv4z1q3jhUgiT46s1uJdJ3MQ29qZgYDp2CWEuEbHq9xCbhbk4VqUomb9kfscV2abcn5ctIvpVwcS2bVw1jnBp0910DxIktt0iDn60IugfuXcmWnruVtDjAh95KiJ1hN3dTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTwF9LiV; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTwF9LiV"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2da3c572a0bso2045932fac.3
        for <iwd@lists.linux.dev>; Mon, 19 May 2025 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747690756; x=1748295556; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2eJFwZEGKaeAV008Mmzc/FjsN007H1WveBZR6JR57uw=;
        b=VTwF9LiVNKFWQt9HtAK72QrUKTw3O8hfUvHaFDJ0Gzid/aM447nKjR+d2PdqTOMXbo
         WFUZLJnACQ1dz3eY5ADuiRprtlc68jtvtMmnAtDBXltcbBAjulRxh8/MtQfsVPfUsME8
         tXNYxrjQm7SybG7HlyxZhFCptaHzr6OzMxqk2MyP2ziS3rv0jxa2PFIrWezA6aFnxyWG
         65MAwxlZz/kuRaeuFmNM9EPOPBujwVsdDPA3/G3YXwKqo7OUdPT6bQW+6vJP8uMXsa1U
         J34GNtwCyKL2U0w5R0FeqKA6nzvUVmjqJzfrcy6S9FkKxpI2PmkyZSmYXZ2X8GBCyq6Q
         4ROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747690756; x=1748295556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eJFwZEGKaeAV008Mmzc/FjsN007H1WveBZR6JR57uw=;
        b=O/i4XLZDO5EcqAXfOW9aQDk/wmBKdDPCdVtiGB12Ey8xpjMkktqT74cbChVChfZ/r7
         e5pNV0+bHaMEPLE0HltCbWRuk5LMRCHExHH1g7mfmEQovmMy2zOAkWYw13PCj6oTh3L+
         sbhiHiEPOr4ueVWZxWwztgtZhNTsdJyfdo7Dvw0zNhEl+XsrhUdw2goGJE3QmEVkgvzD
         xNHJdc8SNGon7GI8zJClWr5TZj+fpHozBQI2fsVw8Fh2g6dGF4thFdwy8FzNqSC+Sa6+
         ZsPHpgM9Y05o8+hXBt+d/TZ0D8sIKbeFpcLN2/msExGdy0SS4kKxiOPG/o7Hxy9aM/Pt
         81SA==
X-Forwarded-Encrypted: i=1; AJvYcCUGe4lz3ISebRGCZFcZg12eht2ZGa4HYMRyyh7ghRS5bECnssplZeCajMUFT7kiHZ10yPM=@lists.linux.dev
X-Gm-Message-State: AOJu0YwWPbD6UpuSWMGoBRjl7KlDuLLHuuNE+Lst4DkmIcaIYFNsjzRp
	rhPwUl3Rw7NfBUmi1L9sFKyhDA/C3By2/LTXNV1N+Jl+LKnT7pAACy8W
X-Gm-Gg: ASbGncvwe5if1okQhkXAbwdQuOlx4uKMi2XIEmB6ekezeuhvN9i4DN9lJP1tBF0RnXi
	NiVrqJfedpAeTGNpu5kgOGeXxcQsFEyTvy4tF6pFH2LKKvL3MIBEC5Sv579pV4p0DBQmdSnXo64
	Rkn69yr2spFQrmC/AfKseSKRO/yJlFp7YMZijFQNYt5ur67Ory8UddMTZglC6XNKhBy+0LJdZD3
	EfHMGFsZrrkAA7UXOaUumPQjdhzAJZu7yq2LPnfPt0+giQtnY+C/kwOAd8uWN0Z1R0aAUVWSn39
	ypMZXc2G+m9sJUSFtSMrWw6u1ipU3HdCVFpNjqVmadhmU4RmKQvIF7xGJHGAr/o+OJcA2WYKbjS
	BhCmAogTrDFXFBUEA
X-Google-Smtp-Source: AGHT+IGcWsfMTFkjG/369SP1he8Nk0y4OxHqBCrngXmUhx4yqQdSa0ts24As84Vnco9K5PO5se4dGQ==
X-Received: by 2002:a05:6871:a6a9:b0:2d6:b7f:1e6d with SMTP id 586e51a60fabf-2e3c16151f9mr7655186fac.0.1747690756489;
        Mon, 19 May 2025 14:39:16 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2e3c060e1d8sm1930921fac.4.2025.05.19.14.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 14:39:16 -0700 (PDT)
Message-ID: <ecc4cbfd-49e3-42ba-b0bd-224dbbc6aad0@gmail.com>
Date: Mon, 19 May 2025 16:39:14 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] blacklist: rename ROAM_REQUESTED to AP_BUSY
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250519163624.198865-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250519163624.198865-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/19/25 11:36 AM, James Prestwood wrote:
> The initial pass of this feature only envisioned BSS transition
> management frames as the trigger to "roam blacklist" a BSS, hence
> the original name. But some APs actually utilize status codes that
> also indicate to the stations that they are busy, or not able to
> handle more connections. This directly aligns with the original
> motivation of the "roam blacklist" series and these events should
> also trigger this type of blacklist.
> 
> First, since we will be applying this blacklist to cases other
> than being told to roam, rename this reason code internally to
> BLACKLIST_REASON_AP_BUSY. The config option is also being renamed
> to [Blacklist].InitialAccessPointBusyTimeout while also supporting
> the old config option, but warning that it is deprecated.
> ---
>   src/blacklist.c | 20 ++++++++++++++------
>   src/blacklist.h | 12 +++++++-----
>   src/station.c   |  5 ++---
>   3 files changed, 23 insertions(+), 14 deletions(-)
> 

All applied, thanks.

Regards,
-Denis
