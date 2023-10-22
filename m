Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F38101F3
	for <iwd@lists.linux.dev>; Sun, 22 Oct 2023 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mud+z+4S"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b2e4107f47so2023187b6e.2
        for <iwd@lists.linux.dev>; Sun, 22 Oct 2023 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698005669; x=1698610469; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O22o3Uay4htVQe/baghWRwSyWXXL0xkw+PtrBM+YtwI=;
        b=mud+z+4SPI+T4V7K2mv3kqmJosUB+IENUP4OlDbLc8RhblMXHw3/JYWDVvtcnB9JFf
         aSX4t5iN9Bdk81LftrtRuJmBxpSxfR0NuKUUEFaer4lXoKWcWPHTrowmLcefjopRxR7s
         KDFuedDmqLxQEnjzK0HHSx85EibR6tsu0T2WDgHTlmsWmpZC7TfMR4CMGG42XBsUGETP
         Wkh8smrjLRdM9cxLM8kWbc+U6E9BfW17W1rcrerFv1K+2PYZOXfRSzMzqWfobZ0CdiDw
         Z2dIicuAopl2Os6A6wnAE3L/M8Fi+Ql31S1rRmO8QqxDIdBEe7iTXEAqmqnoodKUHwe7
         8BOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698005669; x=1698610469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O22o3Uay4htVQe/baghWRwSyWXXL0xkw+PtrBM+YtwI=;
        b=cvR6z/fw44hV7aazahxhNsASaos1i0MOsUIrdD+jq068jzKVOtpQv7TCwHDzrZ1CfU
         kpJBYh/GEv2FQR7CQYg+79tKt23H47Ag59gk+YA5VGgr7lswymDT+PQQ7nCt7SnQAMr6
         YvzkI7Piv0NNW37DNc7NdUrwmbdQRFzVxlCYPBg6GANu5eNb6HQ6BwDhXiqVHgRWNpZd
         k+uRF2OOgHfs4YWLidBiMqolP5arYwY7eD01OM9pt9/1iDBIM6rPHZcUtEil5fsFLUqZ
         bIN1u9FUScLRQSpSF4102pOtlvEj6FWtNMKlOgJzlqlN7Eta4u7ElhvB5xm0BGT/+Iyg
         YnbA==
X-Gm-Message-State: AOJu0Yx8hNNHzS4dbIEI43oeHwB+P/+LNpu5pItoynPtw8FfZ0UGSuxB
	CNG6tI09vY30p1salopDtNE=
X-Google-Smtp-Source: AGHT+IEGQA7d3WpMSi6ai+73OxL5Nq7NDU3greY1IIePZqmgEzRK0U75L3ZpKBfjkT0HuQwEhWe5xA==
X-Received: by 2002:a05:6808:f87:b0:3a7:2690:94e0 with SMTP id o7-20020a0568080f8700b003a7269094e0mr11107282oiw.4.1698005669230;
        Sun, 22 Oct 2023 13:14:29 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bp18-20020a056808239200b003b2e2d134a5sm1181671oib.35.2023.10.22.13.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 13:14:28 -0700 (PDT)
Message-ID: <29094eca-dcf8-4234-8afc-13d37db8450c@gmail.com>
Date: Sun, 22 Oct 2023 15:14:27 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Content-Language: en-US
To: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>,
 James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
 <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
 <f7ced477-6fa4-4efd-bf54-817b100041ef@gmail.com>
 <ccb68e07-e4a0-4e50-b7e2-2a2044d38487@gmail.com>
 <30b6dad4-64b2-41ca-8712-053cb1396eaf@gmail.com>
 <ncmtsi42vkdimzxsuktgfblp66agskivhuntdjlooyp7gglhgo@kwuxknllo527>
 <sebayhpora5e5ispmp5nnjesihoewc74ohygd3orxp7k22ky4c@tt225sdpjrxm>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <sebayhpora5e5ispmp5nnjesihoewc74ohygd3orxp7k22ky4c@tt225sdpjrxm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Simonas,

On 10/21/23 18:23, Simonas Kazlauskas wrote:
> Hey,
> 
> I finally got around to figuring out the test specifications (I think.) At least 
> the test results I’m seeing are the same as the output from `iwd -d`.
> 
> See the attached patch (feel free to merge it, or not to merge it – entirely up 
> to you.)

Ok, I'll take a look during the week.

> 
> 72Mbps appears to be coming from the table for 80MHz rates (NSS=2 so 36MHz in 
> the table itself), but this *should* be a 40MHz ordeal. My APs are set up for 
> 40MHz 5GHz channels and 160MHz 6GHz channels, but it seems like it might still 
> be sending capabilities that include 80MHz support…? Weird.

Probably does, but iwd should also be paying attention to the vht operations 
field and taking into account that width=40.  This is why we pass in both VHT 
Capabilities and VHT Operation elements:
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/wiphy.c#n1049

> 
> [1]: https://semfionetworks.com/blog/mcs-table-updated-with-80211ax-data-rates/
> 
> Anyhow, besides the 80MHz weirdness, this all seems to ultimately come down to 
> the `ht_vht_he_base_rssi` table (as you both have pointed out in the very 
> beginning!) After the `width_adjust` in `band_he_rate` is applied, -76dBm is the 
> bare minimum for it to pick out even the lowest 36MHz rate from the 80MHz table.
> Meanwhile in practice I’m getting MCS anywhere from 4 to 10 (seems to be fairly 
> random regardless of the signal strength, which varies between -72dBm and -79dBm 
> this particular evening.) The only caveat is that for very high MCS values (8, 
> 9, 10), NSS appears to drop down to 1 (thus making them roughly equivalent to 
> MCS 4-to-5).

The values in this table are directly from 802.11.  Section 21.3.18.1 in 
802.11-2020.  These are 'minimum input level sensitivity'.  Most hardware can do 
better.  For example, here's what AX201 can do according to some HP spec sheet:

https://h20195.www2.hp.com/v2/getpdf.aspx/c06986242.pdf

•802.11b, 1Mbps : -93.5dBm 30áximum
•802.11b, 11Mbps : -84dBm 30áximum
• 802.11a/g, 6Mbps : -86dBm maximum
• 802.11a/g, 54Mbps : -72dBm maximum
• 802.11n, MCS07 : -67dBm maximum
• 802.11n, MCS15 : -64dBm maximum
• 802.11ac, MCS0 : -84dBm maximum
• 802.11ac, MCS9 : -59dBm maximum
•802.11ax, MCS11(HT40): -59dBm maximum
•802.11ax, MCS11(VHT160): -58.5dBm maximum

Minimum for MCS9 (256 QAM 5/6) is -57, but the hardware can receive it at -59. 
MCS7 (64 QAM 5/6) is -64, but the hardware can do it at -67.

Also, there seems to be little penalty between HT40/VHT160 sensitivity at a 
given MCS, at least for HE.  There's a 3 db penalty per width step in 802.11. 
For example, 802.11 AX lists minimum sensitivity for HE MCS11 @ 40 Mhz(1024-QAM 
5/6) as -49, but the hw can do it at -59, quite a difference.  For HE @ 160 Mhz 
the difference is even bigger, -43 according to the spec, but -58.5 according to 
the hardware.  As you can see, HE sensitivity estimate is largely out of whack 
with stated specs.

A more realistic estimate for AX201 on HE might be to increase the sensitivity 
by ~7 db and drop the 3 db 'width' penalty in band_ofdm_rate().  See if we get 
closer?

Another interesting this is that HT rates suffer a ~3db penalty for NSS=2 
(MCS07/MCS15).  This is something we also don't take into account.

Now the question is, how do we make sure iwd is estimating the HE rate if 
available?  Also, how do we tweak the estimation logic with sensitivity numbers 
(obtained from a spec sheet, or through experimentation) for specific hardware 
being used.

Regards,
-Denis
