Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A33168E1
	for <iwd@lists.linux.dev>; Mon, 23 Feb 2026 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865833; cv=none; b=q8mKSIl4YU5EjLd6B8c2RwCp9NzH6C+8yxQW8GFqrvD2ZUJVCCwoiQeKpV4vlWzU+nWLegWI9B3Zy0NqtMlvvMfDZYDVB/t1O2BvKE5kLf9R29y4G3gFll656LPEKurIOt44K99zuCDMn//QclLxS9e5FHobn10c6KTHU0bNFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865833; c=relaxed/simple;
	bh=Pp8ejFuQ1SPaV3HacCscBp3v2WCKUU5ROlXuwV6t2hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p36DtsEBhytRKN+dYSeHlIn2sBdhzeN9S4G1ZbNNcHIqwCOn4rrUpAviejEqgBfBOTpqWY6davJ1omgxCFDdY6Wnsd6fWcQxnBn1/+zPafP0fpofMxWxThkhP1bNQEhrvNmpU0TAlgBBGW/jdjbGBK2zM67+woeF6OgSaKYqH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG96uiqF; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG96uiqF"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70bb8ffb24so602322a12.1
        for <iwd@lists.linux.dev>; Mon, 23 Feb 2026 08:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771865831; x=1772470631; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9vKDH6blQJPOaQrPRoCrr+jZd7FSVS1p9AElVdGfAg=;
        b=hG96uiqF7XFb+UtM4IJv/KxlYfoLIZWE1Lbe7osFqIOraM+2rFURNlvj9J4flR0Edp
         GhXYdkNE52QNcK9b2vhB1ZZrFX3769AEmPZ/O6KJC6bw4K8rtya7HPIuRLZv7hYbpIqg
         3s2WyoQr5CMJon+YH4gkugKqhYfHs9yqBD81zeqxRgTiTSKGnjgImURJn+5E1Kr5tZP+
         UqikBqMn/L+QVrSmpnOz+rx6Dqt2RqZabZ1QSdKhSHCSBwqNAHBd/MyTsp3iWZhXdtqw
         3QJibB9mYp82E6KIyCMAqudJmgrPjkM/K4yRbBIxAgjVsqHceT1vlMGECc5HbI2D59N8
         B5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771865831; x=1772470631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9vKDH6blQJPOaQrPRoCrr+jZd7FSVS1p9AElVdGfAg=;
        b=lzzXZVznsTdp6RX7yPAFdMzznwczWr1hbKscore+e1W7vMSakAPKi6jT2+pyGIcts5
         QBIKbw7+EYqWxe7CeBbZokNg9xH1iMnPXIErhz+j6ttacFNrmHeRCXyMFMaZkdLSECCN
         04IikHHYue+H4L+G6pFOdHLdFuVtvbSRcG4kGNZ/iEmZ1Y1snWbRlR8WYtDTPYrWWDp/
         kxoww0WTS4RSy7VFSaKdF3Qr516D4IxOPWQ60GCdxZ+N6jJFG3byI7D9Lqlf9gM586S4
         7hKjbqutrI9YLP2mM6z5qJ7kZXxAghQLXLWM2hCVYnlpaDrPo1gqQ06GsBpBwLoR5vh6
         bA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHGzTE4kLxHP/YWOEc3aMDxyyo4bSbJYO7twEFGJjgW6FXGt0w+7Z9n91ccCqDIYzliBs=@lists.linux.dev
X-Gm-Message-State: AOJu0YypSXU9dcu2OSQXHpK60mp/rtLDIZs52fRyqaJIFL9RhUcjEIuA
	w1r821pnFUySQ3z6cURXUQlTbhWeel/JjuIs8HATNapEuyWJT0zThMQ0
X-Gm-Gg: ATEYQzy4fq5LebST+kjlzUNeqgKQuvcS2roKDwxQnyVdm3O57Dlb/c6swE9FvtBrJdU
	t3yqCSEXnN87iteGhAw118lqU1bmXknew1GijQ8W+Xj4BCTcf35uLTArnMKh90oQzK/D3kKJRPP
	5ppothR5CHnr2uKcnRxzjWmO3lrnAF8ndtDxsUZ47S8k9RU4kwmtQvRCiNWVE/7clBwk1BlgZov
	LcGtgp/BbYhWUTKtDE8kyW6SeOTR68Gb6ZUaAj54iVmSUkIgY7nujOQbYFIQ35w20nO31ySuneI
	n7V/wdtSlySS7bG9olhUEWV5xxqoO7nYSV9e+HRfzQep3zpI9VFj/mCqcxmNrxrBjgRaADU53Nr
	wc8TS7bFOYRUXG2bPaYXvmtLje8zmAJOe2cd+eJ7AjZfvuAZmDxNl8A9P+9KJ+64UTL8uMcAC8H
	GLDfwxK+SA9Np/t2bLC5I7b6ckjEzmIeCBcK4hjyUEgBEqeVmdBGVag919
X-Received: by 2002:a17:902:e787:b0:2a8:ff32:5f96 with SMTP id d9443c01a7336-2ad74480fccmr69301755ad.13.1771865830658;
        Mon, 23 Feb 2026 08:57:10 -0800 (PST)
Received: from [10.100.120.15] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5df5asm81261005ad.25.2026.02.23.08.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:57:09 -0800 (PST)
Message-ID: <baacf3fb-aee1-4b9a-9d42-0e5909719091@gmail.com>
Date: Mon, 23 Feb 2026 08:57:07 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: systemd-networkd MAC address randomization stops working when iwd
 restarts
To: =?UTF-8?Q?Roman_=C5=BDilka?= <roman.zilka@gmail.com>, iwd@lists.linux.dev
References: <CANZiGuEaFwDLHD8jGk4-POxfnJAWeER1ss7COtur8b0ohEi3Fw@mail.gmail.com>
 <72a14187-ae0c-4de1-898c-c416de541e7f@gmail.com>
 <CANZiGuHAzX4GDQvEKHDRoWF-CMdaR26pVarEzr1PSG6HLyrj3A@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CANZiGuHAzX4GDQvEKHDRoWF-CMdaR26pVarEzr1PSG6HLyrj3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2/23/26 8:43 AM, Roman Žilka wrote:
> James,
>
> On Mon, Feb 23, 2026 at 2:36 PM James Prestwood <prestwoj@gmail.com> wrote:
>> Looks like the issue is in the configuration. IWD removes/creates a new
>> fresh interface on startup, which conflicts with how you want to use
>> randomization with systemd. If you want systemd to manage the interface
>> you need to tell IWD to use the interface systemd/udev creates by using
>> this option in main.conf:
>>
>> [DriverQuirks]
>> DefaultInterface=<driver>
> thank you, that fixed it. It has no bad side effects, does it?
>
> I have to say, the situation still looks like a bug. Having systemd
> manage the interface and using iwd for 802.11 is a supported
> configuration, I assume, so iwd shouldn't collide with systemd
> components then. Also, I would never think of looking at
> DefaultInterface: there is no driver quirk, the name sounds unrelated
> to the issue and I actually don't understand the terse description
> (what is a default interface?).

Having IWD manage the interface was a design decision made since IWD's 
inception. But there has always been a way to use the interface the 
system creates via "default interface" options. So yes this is a 
supported configuration.

I'll admit, the use of [DriverQuirks].DefaultInterface in this context 
isn't typical. The reason for this option in the first place was because 
some drivers didn't support removing the default interface, or at the 
very least would cause issues. brcmfmac is one example. In you're case 
the driver itself supports interface removal/addition but you're trying 
to also have systemd manage the interface when IWD expects to manage it. 
There's no other way to tell IWD this situation except this DriveQuirks 
option.

In case I wasn't clear a "default interface" is the network interface 
that the kernel/driver creates during initialization.

Thanks,

James

>
> Cheers,
> Roman
>
