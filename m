Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BC18026
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861299; cv=none; b=kPTpc5brGNoCzlMJCXrFrRwxBammPMvWrEKXDA2QOO41C9lYnNVxOOJ5te2teaM22tn7+dNYTMSBOAp7Fbj9/a9FvtLn1HplQSqo65BENrsVHDVJIPvvJtaCRh5fE2bm8ynXY6bXDdjYmSF6h7Q85IyUSGIJfARgUwN45akuhkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861299; c=relaxed/simple;
	bh=gQfQxx36UCliAHfrmIH9clF1VmH8PeIbJoax+myJRrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UBnlEuPRv5LQ/Z3IkXwu0Q2+RqFqgIQLbROokFN9r9V5cCPyikVMrIjcu+IIDCQiogkn8adw7BSyJRqBUj5zqyFhzEK2pEXPPsLlKJM4eIGFbN4N9ni4vnkQRbC5zFmYluaqOWz865Fkr6liwNBhLNkZbwpwAMjF3y+7kvpKWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4+nMjgq; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4+nMjgq"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d3959ad5so497983685a.0
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722861297; x=1723466097; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+1Y8BX2Wh3Of+CEEzHaFWMTWY1h038N4LZMQDfQ82g=;
        b=i4+nMjgq3WgVSq5gqoNF2qo0OX9/T81VIfpdyqGSD1CoRagtv487Std23rKt+SmK5L
         pYV9ZP8ukKdh0WwO9A6HDogM4dGRWnaiZ+WOvX61LSaBUCOwYl6hpMWNuOXpSyvg1JAm
         NqvhD1xLQXQL4cem2nNlfS4Lxglha4YFRv7GbydLB3QYzyP7wMNpsRGyrhT6HNCVPn9j
         JcCOGeSa/bXXU1S3bE2f8PMw0k8N+omPqHmmW/HAklNiGAiha5l/g7BWqOoAZzIbjQ3h
         f5kAnmKWTt2SjbTNXvp4ZelWHGmoag9+0K1u0LTbE/G6X8TfrVJz1kNKXbYP4NTgX3L7
         Issw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722861297; x=1723466097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+1Y8BX2Wh3Of+CEEzHaFWMTWY1h038N4LZMQDfQ82g=;
        b=L7iHbsTV2IoHuzqPAvvTD6v0mkIZujUgTxTAhGYOjenm0KqfhvQfTcHabu8B/FEDqM
         jBpfDeLZKNb0ZTNXlGv/S8eaL/NLudcgffvFLvufAog8RwO1mIaYMrLX8YiUDXaE/Fd1
         B2iLgtgBKP/jB4Kh2wYXvvV1ARYtdNkjvHou21GV5wHhWdhIcKPxTSszY5Jw+ALFRFpm
         XUliRsf0srJ0rjobo3ZOXx+vHHZpskQXdrdip3eKFD9WRS3DywcFtxRimEO5iiSiKBUn
         lvdbWkktUlP9Ls8lozjy4UsOo+wVpZSe9ZyLVVtVzsOH66Txn7ngY/jQ/yTXbuqK/h8r
         zAdw==
X-Forwarded-Encrypted: i=1; AJvYcCXBEybG0TX7K95fzx6d47431zZkDLsycL6wWrRPQ1snl1s7TyvKy7uQ9HcF6KFVdoGIfRBZNO8dPeFk6W1jncDZbmwv
X-Gm-Message-State: AOJu0YxLa9H7fBUaY7dAgVXKZKec4t5oITrJoxWYbhZf4XAm7ktzfl4z
	GAZwdEvrMP7+kdvF7J0Stkxpf5wUHDncrSQRtxW7PpYFa/nH2sQO
X-Google-Smtp-Source: AGHT+IHku7NLRw3AcAFMbYDuBJd5tZCjZnkH4eEid9g9wjN7XE9aIvfihn7WQ+/byglI3xlNON1D+Q==
X-Received: by 2002:a05:620a:4306:b0:79f:735:4d08 with SMTP id af79cd13be357-7a34c0a639amr2455183885a.25.1722861297049;
        Mon, 05 Aug 2024 05:34:57 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6ff716sm345359985a.64.2024.08.05.05.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 05:34:56 -0700 (PDT)
Message-ID: <ef38aa12-634e-4870-888c-219c961f301c@gmail.com>
Date: Mon, 5 Aug 2024 05:34:54 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Request] iwd to support brcmfmac 'SAE with AUTHENTICATE'
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 8/4/24 10:08 AM, KeithG wrote:
> I know brcmfmac is a pain to deal with on many fronts. The current
> firmware installed by RPiOS in bookworm as of:
>
> Linux 6.6.31+rpt-rpi-v8 RPiOS-bookworm aarch64 (64bit)
>
> is:
> [   65.894288] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> wl0: Apr 15 2021 03:03:20 version 7.45.234 (4ca95bb CY) FWID
> 01-996384e2
> iwlist shows:
>          Supported extended features:
>                  * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>                  * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK
> in station mode
>                  * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with
> 802.1X in station mode
>                  * [ DFS_OFFLOAD ]: DFS offload
>                  * [ SAE_OFFLOAD ]: SAE offload support
>                  * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>                  * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>
> This driver does not seem to work with iwd nor wpa_supplicant to
> connect to an SAE3-Personal network. To get it to work with
> wpa_supplicant, I had to follow the instructions in this link:
> https://github.com/raspberrypi/linux/pull/5945
> It shows that it has been merged into the kernel. The new firmware
> forces SAE authentication to the AUTHENTICATE command, apparently.
>
> [   65.764656] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
> wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID
> 01-b677b91b
> iwlist shows:
> ...
>   Device supports SAE with AUTHENTICATE command

So this is interesting... IWD does not expect a fullmac card to support 
AUTHENTICATE but if this is the direction brcmfmac is going I guess we 
can support it. This is such a mess though and brcmfmac just needs to 
decide what they are doing. This just makes things even more complicated 
as we now have 3 (?) ways to do SAE just on brcmfmac.

I think IWD is getting very confused with this newly added support. 
Could you get a wiphy dump with iwmon with this new kernel/firmware so I 
can see what exactly its saying it supports and what it doesn't. You can 
do this by running iwmon:

iwmon --nortnl --noscan -w iwmon.pcap

Then starting IWD.

> ...
>          Supported extended features:
>                  * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>                  * [ DFS_OFFLOAD ]: DFS offload
>
> With this driver and the latest wpa_supplicant (built from git), I can
> connect to an SAE3/Personal AP.
>
> I am not a dev but can build and test stuff on my setup. As I
> understand it, since the new brcmfmac firmware requires the SAE
> authentication to be done outside of the kernel and that iwd does not
> yet support this functionality.
> Is there anything I can do to support the addition of this
> functionality to iwd? We develop on the RPi and we are stuck with the
> brcmfmac cards and use connman/iwd for our connectivity.
>
> Keith
>
