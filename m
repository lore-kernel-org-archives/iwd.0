Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B546248897
	for <iwd@lists.linux.dev>; Thu, 12 Jun 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739077; cv=none; b=SZ3cBI5RvSYM98+/5Iv6U+/xGofaMsGtts0M93caZS60FziAcEe8RNkzYrP/UY9yp3+wwlwjdTA7ZXH7DdBuXczgcoPxy3T3KiBkGQX2ISu1L89sWVCA3eii6MAEg2LjYSD2q1RqJtFgJKWSmEB4s/1mPaViSTERm2AsGohdBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739077; c=relaxed/simple;
	bh=0PP7YzABl/ML0axwobfqMy2WUHOqkrZ7u/Z9PglhIkA=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NbaenfjonqlQk6eZtqcESbgH0Km531IKouPmdpJOZzoXvlnloRh/268Qy7R0m8LydVMG0qUQ2TiU7vOWLolfB8sDRfLOqSHRR6vOs5dNADI/6lvIC/UJHnJ7dNpZeIwNxd71RwMYBYjAF1YaDgxA8dsQ15BbTHpj1/BlesWxukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PsUZkcpq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PsUZkcpq"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so1842200a12.2
        for <iwd@lists.linux.dev>; Thu, 12 Jun 2025 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749739074; x=1750343874; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kn8Wc65KJNbwROVJioS2XGWotle4u2pzjIus8gRmfpA=;
        b=PsUZkcpqvEE9PxUivRMuUKV4nf95e/BxWrKkq4bnonHRLErUxMwOw02W54VIbvW2B8
         CJvJk4euh5w+3+bnJuCydJe+ZexhO4GbcScUO4tTOsrWeI9H9uF8jFWYC44+S25pG9Xk
         pYwxfJzvRgrXz/TbHb6vJSZQWB0Ru7P6iJvIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749739074; x=1750343874;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kn8Wc65KJNbwROVJioS2XGWotle4u2pzjIus8gRmfpA=;
        b=YM3vjV6Il67zWf+5TXhquwzF0A8yNEDv+EWFG0lcVRmbzo0uOt1UokVTw1Q+EBIW/i
         p7USnzAdU9ANPIH/ZhhPvTKgVRWjMAoFIhlmufU6omZCa6rSDCr/RVSLKaPkuKPz1o0/
         2FImJBWCFBCXovUvL+Sr54EbtYT/l4v1WnfbhkesYHul5/Os25ls2ew42daAn8nqudcK
         I5s5gCvjK37lo7lepFwOExjmlowllF6B7x2Nk93mShqSEXSFh3mIyjQdb1qow9yIx70u
         OlOC/ONiUhe3Cr/ClQoYo6Xqip39Yvw006+jNyj+hrk8Fs8nRHltPRaKLzGG6EZzcFRZ
         yXgg==
X-Forwarded-Encrypted: i=1; AJvYcCU6woZzPohG5d7fT8eqALISScRIqwiG/HGlim159/FDwMos1NYS9bSQvD67mdkJQp4KkUY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxcSBBQgbo06vFO8eQBIM8WSo0lZwy7G5+vAlj0+Z98KraE7+B7
	UmuBNVvlhnxt1jOMtr/MgsseugYBFFDXD7GE6gKstOpKdo4EKNOnUMNQesz5g1bntudjTX65/t/
	ukHyFVQ==
X-Gm-Gg: ASbGncsgGKJzFT3pnd7yG8eA+6TgfGpa/6qcLFFUBe10KzsltWPi8JXjez1OOTBBAOZ
	Ob3ag6aKvjDNVgpef4GzwVCXbWRf1UncIMQOF2+7JTcGZ0JJ1xOIpizOs4oZCDK/tTfeFrE7R5b
	1yxnZRoFHDNlKTbaRaPMYBB1z1re0URu3tgo+Mary8+zvBh7RVZ7L8mlT7AlLI3+BdUQgMzrEit
	JhBGEJxMxO1wy6gshFV6730jmmFQFaCseJ1RGSHZA8+mLK1wuyiIbGOQnyYxD4GjjcApJMdpn5k
	bvHQZa7fwSXOsFzqRxnNMH0i8uwd3jXHtrhwAR+DAqUZWmHHPYotI5NqZzYqv6UEev4fuAj4+fs
	ZsJZ2LkKIZ22FnXpt/uUNfawt
X-Google-Smtp-Source: AGHT+IGR/lNrMhM95Z6ze2AU51Ztr5nnmOVicUTBzfv51eok+JllUY1GgfbWYJjz4E4WHywQrraxdg==
X-Received: by 2002:a05:600c:8b0b:b0:450:cd25:e68f with SMTP id 5b1f17b1804b1-4532b966c95mr39173385e9.27.1749739063884;
        Thu, 12 Jun 2025 07:37:43 -0700 (PDT)
Received: from [10.229.43.173] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e184724sm22537425e9.39.2025.06.12.07.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 07:37:43 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>
CC: Denis Kenzior <denkenz@gmail.com>, <iwd@lists.linux.dev>, James Prestwood <prestwoj@gmail.com>
Date: Thu, 12 Jun 2025 16:37:43 +0200
Message-ID: <197649346d8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAG17S_NMk44gBa2B=xNyjhXVJuaeYVn-+T9u_8fid+r7k--56A@mail.gmail.com>
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

On June 12, 2025 3:51:34 PM KeithG <ys3al35l@gmail.com> wrote:

> Arend,
>
> I am still seeing this:
> wpa_supplicant[431]: wlan0: Failed to initiate sched scan
>
> I tried the brcmfmac options listed above and got no change? Still
> getting this every 6 seconds in the log.
> Did I get the command in the modprobe conf wrong?

Maybe. You could try to merge the two value so one line with 0x200002. 
Could be that wpa_supplicant determines support for scheduled scan in an 
unexpected way. Have not looked at the wpa_supplicant code for that.

Regards,
Arend

>
> On Fri, May 9, 2025 at 1:01 PM KeithG <ys3al35l@gmail.com> wrote:
>>
>>>>
>>>> With this setup, things work really well and the only strange thing I
>>>> am getting is a 'failed scheduled scan' message in the log every ~6
>>>> sec.
>>>>
>>>> May 09 08:53:50 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>> sched scan
>>>> May 09 08:53:57 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>> sched scan
>>>> May 09 08:54:03 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>> sched scan
>>>> May 09 08:54:09 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>> sched scan
>>>> May 09 08:54:16 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>> sched scan
>>>> May 09 08:54:22 pi4 wpa_supplicant[2254218]: wlan0: Failed to initiate
>>>> sched scan
>>>
>>> I thought wpa_supplicant had a config option to disable scheduled scan, but
>>> can not find it. You can disable it in brcmfmac using feature_disable=2
>>> modparam.
>>>
>>> Regards,
>>> Arend
>> Arend,
>>
>> Thanks. I must be doing something wrong as I still get the 'Failed to
>> initiate scan' spammed in the log with this config:
>>
>> # cat /etc/modprobe.d/brcmfmac.conf
>> options brcmfmac feature_disable=0x200000
>> options brcmfmac feature_disable=2
>>
>> Do I have it formatted wrong?
>>
>> Keith
>>
>> I think you suggested the the first line due to a different log
>> spamming message.



