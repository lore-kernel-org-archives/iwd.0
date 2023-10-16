Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7F623775
	for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9a05AXk"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-66d0760cd20so37186566d6.0
        for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697456122; x=1698060922; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVMrnGkruBIpbcAvMIIfK8hd/wRxfuMKH0PQG/O2l7Y=;
        b=U9a05AXkfb8o3ZJQKS+B0Cc+N6ZSTtTSQ4ckSFce5ACKwgSZ/aHOysv6FFG5Si8l1X
         i6ZgGNlxD3k6+Q5tJP92RJdfZEP9HpMYNZXFDaaFRnWaSANLDJ8PW1oJ/2GXWLn2SsSi
         co8mLeEuLw0jtDM49XpOmYbYNVHGIZT68unnDlGKHh9NJtw7kzN7qFOZ+GsY2LQSdRAz
         P4YLKIdyr+mC754pSemOvp4Fd9AyKMPto8S6W2qX8gIKtqAB0US5ud9Em2u+/sYMEeG7
         OcwII0RQhbEiIaPCaHhoWola4SjWfckdSv6DAhDumv3HZv+wxO0rDsSFiV04+JnbqOEV
         Cleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697456122; x=1698060922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVMrnGkruBIpbcAvMIIfK8hd/wRxfuMKH0PQG/O2l7Y=;
        b=ryvJvdsrSnp2OCzZib0RwOJ88KKWnmO06fGK/3oChVogVZHF89dyIRaHfPxFKUnJea
         Lc8Z36dDMqW+Og1xWe+u4yREaG17iEkg+K8lA2i2vUOl86P3Se4eU1ZHk/ryMjZnjasq
         VvJUENk18qaIEqEZ0yvniE+6JxiIDRmQ1aZAzBRznR9cvJp4alYL2LgyOks+ZS1dscqx
         LNc1NGwnf5rM1GzK0WeiwY94SVX78qogN93Hv6j4P3jCzwkMJO2GzcHAexOpLSZ+eCEu
         TbxhGlM/deu+ebCezghsax/bk2YiZzxkPn0NsBD13Epfs2RLPKcN4p+EOmlcDbuKaQT1
         AcgQ==
X-Gm-Message-State: AOJu0Yyup8IwQGmncIrtg0X9KUinO0sSZG8d81JqdGjnTjKPT5UVuAV0
	A7jjHDSSRcyMjShBNCX4kMdu1RikSwA=
X-Google-Smtp-Source: AGHT+IGYOqO2S6Ir5b91q8fLum0wRpUeCYKRb85rz00Pnm3Sm/Zo7KqKzJeO+HNVZCjr4/dYjUpQNw==
X-Received: by 2002:a0c:f489:0:b0:668:e6f7:3d42 with SMTP id i9-20020a0cf489000000b00668e6f73d42mr8647377qvm.9.1697456122567;
        Mon, 16 Oct 2023 04:35:22 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a16b100b00767d8e12ce3sm2917711qkj.49.2023.10.16.04.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 04:35:22 -0700 (PDT)
Message-ID: <f7ced477-6fa4-4efd-bf54-817b100041ef@gmail.com>
Date: Mon, 16 Oct 2023 04:35:20 -0700
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
 Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
 <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Somonas,

On 10/15/23 12:40 PM, Simonas Kazlauskas wrote:
> Hey,
> 
> Denis Kenzior wrote:
>> It may be we screwed something up with HE since hardware was still 
>> pretty rare when the feature was developed.  But we do treat RSSI 
>> values below -82 as almost unusable.  Perhaps this needs to be tweaked 
>> for newer hardware.
>>
>> If you want to get your hands dirty, it should be fairly easy to 
>> modify unit/test-band.c to test what our estimate code does with your 
>> specific circumstances.
>>
>> The local HE capabilities can be found via 'iw phy', looking at what 
>> iwd prints at start, or using iwmon.  Similarly, remote capabilities 
>> can be sniffed using iwmon and running an iwd scan or 'iw scan trigger'.
>>
>> Me or James can walk you through all this if needed.
> 
> Thanks for offering. I have cracked open the file, and just started 
> playing around by adding a new `he_test_data` structure. Alas, I’m 
> really hazy on what I ought to be filing into the `capabilities` and 
> `he_capabilities` fields. My initial guess is something like this, based 
> on one of the other tests around:
> 
> +/* 5GHz, 40MHz, MCS 11, NSS 1 */
> +const struct he_test_data he_test_5_40mhz_mcs_5_nss_1 = {
> +    .freq = BAND_FREQ_5_GHZ,
> +    .rssi = -76,
> +    .expected_rate = 275200000ULL,
> +    .capabilities = {
> +        .he_mcs_set = { HE_MCS_SET(MCS11, 1), MCS_UNSUP },
> +        .he_phy_capa = { HE_PHY_CAPA(0x00) },
> +        .iftypes = 1 << NETDEV_IFTYPE_STATION,
> +    },
> +    .he_capabilities = {
> +        22, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
> +        HE_PHY_CAPA(0x00), MCS_UNSUP, HE_MCS_SET(MCS11, 1)
> +    },
> +};
> 
> This computes a rate of `25800000`, which I’m guessing corresponds to 
> 25.8Mbps, perhaps? That’s fair I guess, since the only thing I really 
> really changed in there compared to the other tests is the `MCS11` 
> (that’s supported by AX201) and the `rssi`. There clearly are plenty of 
> other fields that I should be filling in here, I feel, if I wanted to 
> accurately represent my hardware.
> 
> I think I managed to grab the capabilities of both the AP and the client 
> using your instructions, but I’m really unclear on how to go from the 
> output from `iwmon` to fields in this struct. My best guess right now is 
> to actually run `iwd` under a gdb and place some breakpoints in the 
> scanning code to extract the capabilities. Would that make sense, or is 
> there a better way to fill in these fields?
> 
> (As I’m writing this mail, I realize now that I probably want to somehow 
> specify NSS=2 for `2x2` MIMO…?)
> 
> Another thing that confuses me a great deal is the fact that the scan 
> results with my APs don’t actually show any of the HE capabilities, only 
> the HT and VHT ones (see attached sample from the `iwmon` output.) I 
> also tried scanning an Android hotspot on a reasonably recent phone, and 
> although the set of MCS supported were different, the output still 
> contains only HT and VHT capabilities. I would love to attach my pcap 
> here, but unfortunately I also have no clue how to sanitize it, so I’m 
> going to attach an excerpt from `iwmon`’s output for the time being. Is 
> this expected, or could this perhaps be at least part of the problem I’m 
> seeing? Is it possible that an AP could not advertise HE capabilities at 
> scan time, but for HE to still be used after authentication occurs?

Looks like iwmon doesn't actually print out the HE element, but that 
doesn't explain the same behavior on the android device. If your more 
comfortable you could send the pcap just to Me or Denis.

But as Denis pointed out maybe this needs another look as far as signal 
strength any usability. The difficult part is one card could perform 
much better at -85dbm than another. I'll take a closer look and see if 
something got missed in the spec and do some testing myself (I think I 
have an ax201, and definitely an ax210).

Thanks,
James

> 
> Thank you,
> S.
