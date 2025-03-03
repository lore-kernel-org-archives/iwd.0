Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4CEC4
	for <iwd@lists.linux.dev>; Mon,  3 Mar 2025 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041997; cv=none; b=E9DjfPB++wZUWQw/cOX5KlWXvQ+VGoYElalmlZ/pbEv1r+VFJgihd/lJFArN/9Mz/IG8xND4N8AYlF+Z8JQWDo1xXXY45brd4E1t9LP/+ZV9VuLfuiwpzZCoxQLjTd0zz4bcKjXTOb8JpQamIAkQFceXBEk3ao9p565vHZJC1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041997; c=relaxed/simple;
	bh=bRciuN/Ga8WF7RTb69eo6E+qTjSWctRpTHbYXL4kHlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NzmprOtKXhYRCn2PszXS1qeQTP4/vAphATi2IN2vTEllsJkgvjr2foB4kQPNtgdHfpx7WU23g+kxlcYZL50IAwxpYRo/e9VvbVnRO6w2JZTqDMavGXojHP89w7HBhL8yMz33UtG8hwUHOoLMiNl2kO2+xo6OyAMfya1ETRJNggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwNJ0lVv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwNJ0lVv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22356471820so79467635ad.0
        for <iwd@lists.linux.dev>; Mon, 03 Mar 2025 14:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741041995; x=1741646795; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lzBsGEPP7+N6ldvK3cgNkFpWs4fi4klHFNCxN2kkPg8=;
        b=BwNJ0lVvNlDVbndcjJFSNDqQb9tF4kkK/7ZRF3QbCilI4HsTEgW0dAnFLS7Hpy9R1T
         W2F39i25KK4mCMbym+41JfAIU+PkexAQ4LtKoRswNjLZjTADzAm6aBU40wju+RoFErxa
         YuEeVDmsGVMvivnuqCPu9NXUoiDHpAZW1f9gT744OTxY4MpQM7ccfsDkkEUF75NvmEOk
         EqAa/THn212K/XeHgEffRiTeReAoff+go3AcWyx4tQqs207MmC6kevsMKQrEhp5HY1v4
         yYO8q3nDJjF7UiKEyJmKlxRZ84i0hUFASiddfdCAktOi5VoMCwHmscYl6a5aISoEfUee
         CrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741041995; x=1741646795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzBsGEPP7+N6ldvK3cgNkFpWs4fi4klHFNCxN2kkPg8=;
        b=Dm4Lzh3jbBNEOB2h22L2rjiFbq2pHd6qc6d/18iE08atBdWWyt96Hel42YUA2aGVCf
         +q29rVolYDzGWiNdstRVRXUVAMrw64JNdZiMmjEyqR1bs5zXuashEbY2SCURCbV1cYYS
         8fHw6tr1IHDDGP9dtkxfxX1WHeuNx+c7oLwHqimpZf7DV+Mw3ovSdn4K36UpEKwNSz+v
         VmPSHqPhWKkXDuQnDzWCjzvQEgxmmjcF7YS9F2DRUdVvmXR8HfLMea52X014TYeeG2zj
         O+Sv4tqJM0AJi7qdeaMV6symnHi8iCZcLqu6pYD1nwrxBkzAZpFOR+8Grcoybx1ZuScV
         85vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrNGYGCa8NJtgN8ebXhylPKdDuIuUczw4nN5MDeZjNXy4TRM6l+r8Av0Yj2TZ4s53b8kc=@lists.linux.dev
X-Gm-Message-State: AOJu0YxXbvgUpNAgZwShBdPJ0/Vd3iH0NgOnFyePcOj5y8TvC2jQskTe
	+Uyo44WaHv3MkNObh3loBMKJGrq4G2+mpJkiEPDYCUCJTPZHI2VRn1XAgQ==
X-Gm-Gg: ASbGnctEAbIFoYfMSYSCEGLE6EfJqD7LlUOZOFIDQse4/f9Qi5f9n86q5y24gEO5No7
	vuy6ReLPfMUtwU7g5uKYMtF4pcWzPpgoJBdJlj87OjDFym7du7lMmzUm6mSlIyplRiDZWGuDODY
	j6nCc04CZWLHa9zeWTTUKC4hxyxRU8O1YoisPBIoHMw7uvnrnnO7Qy7zFt3U6ukUmCk5i2irWsQ
	TnnH/mfrdsGY5UXh9jnimMNQpB7Nt8KHPLffRcbTCPcMpKKbfvs9HayHI4h/sabSeu7tv2aqM6o
	WXC7755yGkV8UipfPhiEHQ4zfalyyBnPUh4BmrPi30EWbMaB
X-Google-Smtp-Source: AGHT+IHaKhBzjV1DOxK5iv7x2z4dCiq8tfQ8vlhGqC2oD8N0ET3700+yA9MyDdEA+VYmAzIDlN8efA==
X-Received: by 2002:a05:6a21:7a44:b0:1f3:3804:9740 with SMTP id adf61e73a8af0-1f33804aa1dmr2479987637.15.1741041995092;
        Mon, 03 Mar 2025 14:46:35 -0800 (PST)
Received: from [10.100.120.127] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf23b6sm8789024a12.15.2025.03.03.14.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 14:46:34 -0800 (PST)
Message-ID: <3dfe4f8e-50c2-4cc1-861a-257c06bd032b@gmail.com>
Date: Mon, 3 Mar 2025 14:46:31 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: systemd-networkd managed wireless networks
To: Donald <sirspudd@gmail.com>, iwd@lists.linux.dev
References: <CAOVeLGQuNx5Cr0WVcNQDJpPZk1bWKcmQ-+YeTxdruiAODBGxBw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAOVeLGQuNx5Cr0WVcNQDJpPZk1bWKcmQ-+YeTxdruiAODBGxBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Donald,

On 2/28/25 2:55 PM, Donald wrote:
> Top of the morning,
>
> Do the iwd dev team strongly recommend having iwd manage the wireless
> interface with:
>
> [General]
> EnableNetworkConfiguration=true
I think it depends on your use case really. For example the devices I 
work with are WiFi-only, so using IWD to manage DHCP makes a lot of 
sense as it takes netword/networkmanager/dhcpd etc out of the equation.
>
> I am asking as I am using iwd in conjunction with systemd-networkd,
> and was caught by surprise that disconnecting from my ap in iwd:
>
> iwctl station wlan0 disconnect
>
> does not result in the associated networkd instance from being degraded:
>
>                     Link File: n/a
>                  Network File: /etc/systemd/network/wireless.network
>                         State: routable (configured)
>                  Online state: online
>                          Type: wlan
>                          MTU: 1500 (min: 68, max: 1500)
>                         QDisc: pfifo_fast
> IPv6 Address Generation Mode: eui64
>            Wi-Fi access point: (null) (00:00:00:00:00:00)
>      Number of Queues (Tx/Rx): 1/1
>                       Address: 192.168.50.153 (DHCPv4 via 192.168.50.1)
>                                fe80::ea4f:25ff:fe44:f60b
>                       Gateway: 192.168.50.1
>                           DNS: 192.168.50.240
>                                1.1.1.1
>                                192.168.50.1
>                                2600:1700:7c10:d0ff::1
>                           NTP: 192.168.50.1
>
> It is interesting to me that networkd has enough insight to know the
> ap's name, but still does not change the state off of: routable
> (configured) or adjust the online state.

This does seem odd, but I'm not sure what the expected behavior is with 
systemd-networkd to be honest. You could check the IWD debug logs, but I 
know IWD releases its IP address when disconnected so I'm not sure why 
systemd-networkd is unable to see that. It should all come over via rtnl 
events which systemd-networkd listens to.

Thanks,

James

>
> Yours sincerely,
> Donald
>
