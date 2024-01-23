Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B309650A69
	for <iwd@lists.linux.dev>; Tue, 23 Jan 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026514; cv=none; b=arwTRae2SN8cUxr2m/tN+35MssnP0CQgRCxcw7amyVPPvWr6HP2CBydLgzifGmdOfeBTUSGkxswAFVRJlGaOhWGBR517eucJfz5PTTMLXO+Em+UckIq27PJW7mxPVc4D0DBzmE37Pd5q07hJSIlPk/AtiMkpg2F1g++Rl8AcSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026514; c=relaxed/simple;
	bh=JXFBgrzkekOX1uyMXAg0/Raa+g8J9oT7A3K3NOsc8UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BW2+0lhZ0LVU+93YP9qWqU2nAhW5RDC3XooZ7Nf4I0Nl7bGp/M5AX4pD4PPIXnSYzTQAaJmciJkC77LSnHwkp0NdbxcsmF3anYkPZJAzc7eCwjUsRcRFut1zv+EycMnG6GHhkGHPvLwMqWhJDdRdJG98kaBczY0lJo5ocK6YBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAhAzuNc; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAhAzuNc"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd6581bc66so3398682b6e.1
        for <iwd@lists.linux.dev>; Tue, 23 Jan 2024 08:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706026512; x=1706631312; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVaLxF4NX4esaJzJ0KaPvo76+0EOc0EhYFvs7R/Ko84=;
        b=YAhAzuNcYQ7/wpk28XgmaHO9xDrVHBPRoRFkiMIv8biFmzIAFSGFz+3EBGOxB7tTmE
         ffMkyT+XaWL9O9UjwyoR+vLcgQydTka+GAND74Gs8bJsCRzJXo1UlWU0BKxBqhCwKbu2
         r0F4ZUvPkBBjAtNGTP8/kBGWL4y5ZozngXDt+AsVo6wUDHYcCxCfZLBynJ8RmQ5IH5tq
         my3ogz1cI7XYbBZR/BWFb5EQ73V5y2n5YJYHrAns/Pyct24K+z0xwE/8PYGoMaR5FQrE
         C9Vf0tJbvPWI7csv9t7SlflAhhLQIiUMo3sorwAM47L+bi2LlASbwLFw5A0AyorsvDk1
         cw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706026512; x=1706631312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVaLxF4NX4esaJzJ0KaPvo76+0EOc0EhYFvs7R/Ko84=;
        b=Iq9E/pWGfvqdorktA/Yw/SS2KWw2fCdaKbvPDn5jsxHJr19b7Q1+dur4jwLc+vvoGt
         wigkvJJtP7ewMIia+EuV2PTPk6MoXLF7ZwNCXmwKTrbGV6cpnjXkIpDOFNwBwyySMSYO
         GZlZcwXudlpPlaIqbZ5fN/hWkakeXYtoO5b1e4Zi3uSCen+hryhxbvqdOi+J3ZPvAGLK
         nSGpSUu7s2up66pH/+4LTuXSL7wPo1aWyFYB6mg5onKbIdlo1FWeYxoMNoeK1jFS1/FQ
         KfOrsrPESRwmV0LHyRN9jp6AVQ4UoslnyvgKoL/h+bhCJcVo5m0fZX/5NBr5flJpcwv7
         Jh9Q==
X-Gm-Message-State: AOJu0Yzkc7ySW+Tn2GBDndMmCXGJlT77fiYGfWAVuxpjh+HQmY2c10Tg
	nGSYzzrqb3/9adJhULYrarY9SLYr43FPM7wNJy0D2d7wStwbzlxD
X-Google-Smtp-Source: AGHT+IGjCPPji93nvoVXRDdMzeLkGmqe4hR46VcmG/+ie9LK7pWj4tPOjMqG048MPEt26JMYj+/Bww==
X-Received: by 2002:a54:480c:0:b0:3bd:726d:33b5 with SMTP id j12-20020a54480c000000b003bd726d33b5mr97132oij.63.1706026511651;
        Tue, 23 Jan 2024 08:15:11 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n26-20020a05680803ba00b003bd8a7953a5sm2218685oie.19.2024.01.23.08.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 08:15:11 -0800 (PST)
Message-ID: <69a80bff-f587-48da-a14e-8897586c93e9@gmail.com>
Date: Tue, 23 Jan 2024 10:15:10 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to Autoconnect Two WiFi Cards?
Content-Language: en-US
To: Fabian Herb <fabian.herb@xtonomy.ai>, James Prestwood <prestwoj@gmail.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <DFBE16E1-468A-4292-9056-D7ED6AA0CB4E@xtonomy.ai>
 <e3e82ef7-941c-4dbb-9f1b-2d1579a12f74@gmail.com>
 <D88835CF-16B7-4658-8852-65C4C3767E9C@xtonomy.ai>
 <ef97ec13-8f6c-4198-bf19-ff50a3e596f1@gmail.com>
 <E8931256-9BC5-4563-8A26-6A346560F34A@xtonomy.ai>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <E8931256-9BC5-4563-8A26-6A346560F34A@xtonomy.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Fabian,

> 
> I’m starting to think that it might be easier to add a feature to iwd that does what I want :). But I’m still a bit lost in the source code.

Can you elaborate on what you're trying to accomplish?

Do you want iwd to connect to two SSIDs?  Two different BSSes within the same 
SSID?  Something else?

I do like the idea of having iwd support multiple wifi cards out of the box. 
Right now we do so, but it isn't terribly useful, e.g. both phys will happily 
connect to the same SSID on the same frequency.

Having the ability for iwd to natively support connecting to multiple APs with 
multiple cards would be nice.  Then we can use something like mptcp to run 
multiple flows for redundancy / throughput.  Shouldn't be all that hard to have 
something working, mostly a matter of updating autoconnect logic to take 
multi-phy scenario into account.

Obligatory: patches are always welcome :)

> 
> Yes, WiFi 7 is certainly interesting. You can already buy WiFi-7-capable hardware now. UniFi promises MLO support to be available in February with a firmware update for example.

MLO only works to the same AP though, just different band.  You mentioned using 
a different SSID earlier?

Regards,
-Denis
