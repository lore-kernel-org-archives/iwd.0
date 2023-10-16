Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940934189
	for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAaFBubV"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6c64a3c4912so3424735a34.3
        for <iwd@lists.linux.dev>; Mon, 16 Oct 2023 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697481400; x=1698086200; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0fzKVIzbnpVKyNBIknoi1U7tQRE+pM7uXaXODVDBas=;
        b=HAaFBubVLOIpRm4gsJzUdCa6Qdehe0meeAHS0V943vN753aPFGyiBpt9FtSMVcY4g9
         3d7KBcOsOBM8m17KLZ2GJArApjjnlUo5vLLySPm7onxH+Q6BaULRpC2gqPVvg7LWFSoe
         Q4PiVSEBMNpP755SbsqH4CrPsKk5+4Z2kOnr4yMVa0DZkKmmVASUskGq4pAcCrnsP8AN
         IgWgfofPXB2OQKVgJsmQN7Ks8iY1vSokN8/iNX670SQYtLGnPqjsSt6oI4jn+O5cCTLW
         PSZElILd4PdD+LqyKO/VBhtXWwbdXTT2/rRZab4vEmVw/o2V1zjO7DlI8erL5s51HiDA
         CEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697481400; x=1698086200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0fzKVIzbnpVKyNBIknoi1U7tQRE+pM7uXaXODVDBas=;
        b=sj2MdsjbF6AhFCQqKO0uvTlJG/D1DGwPQAHla7tKgsWGK6GQoPRGU9fRV9o+n54z8j
         yu9VhSV0WrHvOr4NFLyKVkjvWSrWDpcsx2ebFUkZl2uY26h2/I5Db5ywplFEcMQEygnU
         g29+lLjZV3wSupPT+tE4U20nsilTa2DiHSxt4fU+qtqtBtp6BCaDJLG/fMgGdl9SAu5z
         VtITh56msqwh0DJguBESKgYHo9zGx9GppOdckzL84sxw9w9qJ9JaQGnE2/bPmvQWLnjz
         Pr+hU55y6ouh40wYs/UuPo+5xNMiE2UZybsAXtHd0hli1xEfZkxIZnueO0Z3joEO9u+U
         7RHg==
X-Gm-Message-State: AOJu0YxDATQ5uJpgci74xOU2I/+mKZkGyJ5kH1ny9KCVWBmCKyl8tsem
	XQSl4xIME1WUJyvzbQRQhGY=
X-Google-Smtp-Source: AGHT+IEbUoqsSp6p6GVeUw8NbvczmwRhyCFzsObETLtL0XpH/0CMAtmvGAKngk90cPidVGLZYmDCPQ==
X-Received: by 2002:a9d:7f12:0:b0:6cc:dbe8:b861 with SMTP id j18-20020a9d7f12000000b006ccdbe8b861mr36588otq.22.1697481400496;
        Mon, 16 Oct 2023 11:36:40 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r26-20020a9d751a000000b006b99f66444bsm1787544otk.71.2023.10.16.11.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 11:36:40 -0700 (PDT)
Message-ID: <e2534a16-36f9-4a19-b05e-3ec1ba168d3a@gmail.com>
Date: Mon, 16 Oct 2023 13:36:38 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Content-Language: en-US
To: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
 <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Simonas,

>>
>> Me or James can walk you through all this if needed.
> 
> Thanks for offering. I have cracked open the file, and just started playing 
> around by adding a new `he_test_data` structure. Alas, I’m really hazy on what I 
> ought to be filing into the `capabilities` and `he_capabilities` fields. My 
> initial guess is something like this, based on one of the other tests around:
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
> This computes a rate of `25800000`, which I’m guessing corresponds to 25.8Mbps, 

Yes, sounds about right.  This is for a single NSS.  If NSS==2, then use 
HE_MCS_SET(MCS11, 2)

> perhaps? That’s fair I guess, since the only thing I really really changed in 
> there compared to the other tests is the `MCS11` (that’s supported by AX201) and 
> the `rssi`. There clearly are plenty of other fields that I should be filling in 
> here, I feel, if I wanted to accurately represent my hardware.

Right.  Easiest is to look at this with wireshark or iwmon:
https://rowelldionicio.com/identifying-802-11ax-support-wireshark/

> 
> I think I managed to grab the capabilities of both the AP and the client using 
> your instructions, but I’m really unclear on how to go from the output from 
> `iwmon` to fields in this struct. My best guess right now is to actually run 
> `iwd` under a gdb and place some breakpoints in the scanning code to extract the 
> capabilities. Would that make sense, or is there a better way to fill in these 
> fields?

Having the IE format from the spec would be easiest, but I can't find a public 
reference just now.

> 
> (As I’m writing this mail, I realize now that I probably want to somehow specify 
> NSS=2 for `2x2` MIMO…?)
> 

Yes.

> Another thing that confuses me a great deal is the fact that the scan results 
> with my APs don’t actually show any of the HE capabilities, only the HT and VHT 

Hmm, that would explain the low estimate.

> ones (see attached sample from the `iwmon` output.) I also tried scanning an 
> Android hotspot on a reasonably recent phone, and although the set of MCS 
> supported were different, the output still contains only HT and VHT 
> capabilities. I would love to attach my pcap here, but unfortunately I also have 
> no clue how to sanitize it, so I’m going to attach an excerpt from `iwmon`’s 
> output for the time being. Is this expected, or could this perhaps be at least 
> part of the problem I’m seeing? Is it possible that an AP could not advertise HE 
> capabilities at scan time, but for HE to still be used after authentication occurs?

Yes, HE Capabilities would be included during Association, so this indeed could 
happen.

Regards,
-Denis
