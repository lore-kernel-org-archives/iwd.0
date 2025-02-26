Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF975224AF1
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595193; cv=none; b=JcivpB82ux/q2r6lCyxxSQ1x8SyZFXMiCOB/kuChtUxU7bDJvt59OMGKHqM+uRkXkROh7EtEhOwvsJH/+xRuZDo6EmO8eK6M9vbQuLQdsGavta3l4joGSf/It0WNpylIxltf04y+WgiZJKA4ha+chSV3d/c8K49jqfoYV9TpF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595193; c=relaxed/simple;
	bh=gOIZ2mkTgIpwmFpuv4fOidvlnxE0Zomg/6PFvlkK6qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjjQ8YMzMPsWl+R4xywuclIG20Q+WR2OQbFbTk6p1rU6Iql0sMcj8Lpv3abdY7FLtjdZgIQROGRUlEPCZpCSxIqwyXwHqgMlo+4HtqUNbCcIS+g2GOEwBThrLFBHMMw9fzUf+5nQxiH0D6nYA6i6sG2eXvI2g/o/3bovkUUbZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkZ/k/YU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkZ/k/YU"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2211acda7f6so1383035ad.3
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 10:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740595191; x=1741199991; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnlRqarDlcPuW3Env00ygWrPH1m/0y+3LlCYxh8lD/E=;
        b=PkZ/k/YU1aa9ldM/MuRUI9P1k/YCFc9j8ELAAbduZrCs8ovYpIaxMuLs8RCdmSENAu
         SIjw0+5E7YdaEZ03+IkyIjTBvyTxCplmUy7kDPxb/uLZBaNOb+PaFi1l/Dgt7yOL5WRo
         5zyIIfv9TwcyerlIl+MvmELshWVpK1FnlUIWzoHM70QgOjdNocMYPAAlKqYRd4z/QwEF
         TM4LhOXJ6EDj0Z0LZsSS+uiqCTiECxqdFQxkcIrDlouZOALiJyjtwG7JcFDMm/vYyqur
         uLF7Jzt1RM3NGHBDNK0j3EaFYzFrwaDMJdNXxbcHhR6gn6rYsn9z1d2rkLfwRFwnlAv2
         xGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740595191; x=1741199991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnlRqarDlcPuW3Env00ygWrPH1m/0y+3LlCYxh8lD/E=;
        b=UcFxS6gykYKwIsm45J/qBg06BBUxHytsP6bIr4408NkiQm93FU7QkoskcfcAx8nN7D
         uTazJx+/QsrJLfb2g4ai5q5p7k2azhyisTv2s+FT/uamJjxgzg4zHtV1O2Szug4Cy9mF
         zipoc+JILVdSNUkZwiT2ye9VFFdPnueK+7pLUVG0Tekesk7OSR9ARjvKU88XW8KmGUCq
         3CtjT1D2LUrcg4ksw078HP+Gn5+M+0d5nLxNeHd8q4Ih/PAbiO842XRg9mJBbDHi+MCJ
         uSw01BfJ9HOGbRqBZ9uwwD/kgBbX1/3mduF+88cwgplwWlegCvx5moYRIG7qiAQZMqCg
         wHrA==
X-Gm-Message-State: AOJu0Yxxu7W760EhHjZ4g6gYGqqM6DTXMLwzwSlitzgHc7900piLjFCX
	x8tpkfu36ZdAUYprA3CrsfmjCzdu3Le3TyWsnXuQYA8syolUqVYj
X-Gm-Gg: ASbGncsiRv4WyUdhKpaPvgCHC2eNYlk1x/k9I8WcUMYBd5gInBGHbUKhXyvwqNJkAn/
	PjLlO4dwGCzd2/c+7jYFZvxYkIAP3Oq/Ztw3nH1tAth6xrBwPdS9AZDxkAm1r6mGuGDb5p7BUd5
	aMOWRI+VHwQ510uC/KeE3/T8f2iaruUgCaFw6JUOP+qUt85Hzdtm9+KU/fwGytlDqZwvV1I1Ow1
	xgGGrTRefPL8fypYf/ZDJkV9+a3V9z+FlC/N71OmD3zwZ/K7wprfpgwToUA5AuqGLwd2s5Je/z8
	xhiXHKS5qWrVCxpb8Fvy2UYCb5wEkQ==
X-Google-Smtp-Source: AGHT+IGVidy8Ynr8ehPbYsg95X5cu5PmZJW0CWDqoFkSB5ZVZ+jQAzsR3w/izK93EkwNUPfCAwYcbA==
X-Received: by 2002:a05:6a21:32a0:b0:1ee:7d95:c674 with SMTP id adf61e73a8af0-1f10aecf21bmr6915641637.39.1740595191094;
        Wed, 26 Feb 2025 10:39:51 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6abb0dsm3940285b3a.11.2025.02.26.10.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 10:39:50 -0800 (PST)
Message-ID: <d09520d4-997c-4f29-9116-6305aea7af5d@gmail.com>
Date: Wed, 26 Feb 2025 10:39:47 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Does a AP get blacklisted if it fails auth too many times?
To: Bryce Johnson <bryce@redpinelabs.com>
Cc: iwd@lists.linux.dev
References: <CADXxVSKD-YKOxt+=b919QWFHnU7QcSWnEwfb8xU-JGn=xVrbbg@mail.gmail.com>
 <4ec69c46-bbc1-4a05-9d7a-18c1d4d249d1@gmail.com>
 <CADXxVS+xAeGUiwGTe7L0Rr+OtxqRdvZ2AwwhfgpegB8h-dA9TQ@mail.gmail.com>
 <CADXxVS+iBcBeyj7geJ0jMCrT3wP+YBqXcGJ98oa5KEPUGa7ncg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVS+iBcBeyj7geJ0jMCrT3wP+YBqXcGJ98oa5KEPUGa7ncg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2/26/25 10:34 AM, Bryce Johnson wrote:
> On Wed, Feb 26, 2025 at 11:12 AM Bryce Johnson <bryce@redpinelabs.com> wrote:
>> On Wed, Feb 26, 2025 at 11:00 AM James Prestwood <prestwoj@gmail.com> wrote:
> <snip>
>>> [1]
>>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/station.c#n286
>> Thanks James!  I'll check that out.  For also headless device use
>> case, we are never moving and only provisioned to one AP.  So we'd
>> like to try as hard as possible to stay connected to the AP.
>>
>>
> Looking into the logs a little more I did see the same message:
> 2025-02-26 00:13:56.071769752
> src/station.c:station_autoconnect_next() autoconnect: No suitable
> BSSes found
>
> Although it did reconnect automatically after that.  So it seems like
> it got around that blacklist eventually once in the log.  The more
> serious issue was at 2025-02-26 02:47 where it seems like it
> disconnected and never tried again.
>
>
> I did see after this event:
>   2025-02-26 02:47:54.473847839  event: state, old: autoconnect_quick,
> new: disconnected

This is due to something issuing a DBus Disconnect() call:

2025-02-26 02:47:54.473604731  src/station.c:station_dbus_disconnect()

If IWD gets a disconnect from DBus that actually disables autoconnect 
until a DBus Connect() call. If this is being done from any automated 
tooling you have to be _very_ sure you manually connect again, otherwise 
IWD will just sit there forever.

>
> I never saw any autoconnect messages (either trying to connect or
> autoconnect: No suitable BSSes found) for the next 2 hours until we
> restarted
> Here that ssid on was a Processing BSS from a full scan 2 hr later
> 2025-02-26 04:47:04.262785719  src/station.c:station_print_scan_bss()
> Processing BSS '9a:47:32:d9:93:fa' with SSID: revelotest1, freq: 2457,
> rank: 591, strength: -3600, data_rate: 72.2, load: 29/255, clients: 12
>
> I can share the full log if that would be useful?
>
> Bryce
