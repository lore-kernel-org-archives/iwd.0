Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA535886
	for <iwd@lists.linux.dev>; Tue, 26 Sep 2023 19:18:17 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ae5ce5c5b0so539555b6e.0
        for <iwd@lists.linux.dev>; Tue, 26 Sep 2023 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695755897; x=1696360697; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Em4MGs5VZUdpz5P0wpXoTtfeDRZ/RDJGlRXJoWZZe9A=;
        b=IhO0tvzlXBQdBYrsA7221LyA+zu/FJ7h3ReIofZStsdHlteuWxFFn14UOMcPa6PxjH
         3juBe7NMrKtFSchowDYq9ImkcXvnD+xP07B6m81geKeQmg/hGL7jsG5KNLZwTrgoPnkT
         ScGeVNt8y41RKApJ4OSWd82PPzhUMc0KhHYEqvJ97E6c7vzWCPvko0tkXe5nrKby8h6R
         Sn9kygLvK+1n2wW1BAv/FGAwDiN+eI2VXHOUuotsnUvNjvA72UNsAAAtGrVuA+u8HX1t
         cBYYwXv1adgyfQSaTWEw5dVIoeFvBUcR0+WL3BxJHYkkBqXlxB0sfkUfIuhKKVv9tGxH
         7CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695755897; x=1696360697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Em4MGs5VZUdpz5P0wpXoTtfeDRZ/RDJGlRXJoWZZe9A=;
        b=C9WQ0A42z/WLmD2IWrdOndnLIciI8z0xvzfFUuXqsEpaIZU5lfpRCGJsmF7P9pHjPZ
         v/C7AI99cz0RbtocP4UmHE5S8jUBQcznVlN8Mls4uMZ28P9ag12VBwDzstphWQcMrWHn
         YIJBZD8LatiZNwUSat4oUhBuJTNGb/SBT8Oa1C+KcDdAIPpqYd//pvsVWpzrpRux1bBf
         ZvT7OQc3+wb99G4t5p9EGDRhgTRjnvvVSIW37QYVvoKakC/GsSbpFjQCkJRcmF61mcq3
         kVZpSq6CO9qvQKn6H6QO5xtv8PnJMfK2BnmD+qmaKt0D3lfwuc55Ee7QjTZKoSqoOxrM
         LvVg==
X-Gm-Message-State: AOJu0YzkR+/S3/I4FyWP/ER9zdoFxc/VpK2x4AJPlQP1LHIYiPSNmkV5
	WHyK1PPEsRzr9K9ZRvI7ar4=
X-Google-Smtp-Source: AGHT+IE61CLMGMHVYLyhL/ZzzYP20IOnTV7uShTQz8WNZxzh5xb71wR2h0u+AGPqhbq7xW0vRCHAqA==
X-Received: by 2002:a05:6808:1798:b0:3a7:5346:fcee with SMTP id bg24-20020a056808179800b003a75346fceemr2571386oib.0.1695755896666;
        Tue, 26 Sep 2023 12:18:16 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cb12-20020a056871e10c00b001cd1a628c40sm2858300oac.52.2023.09.26.12.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 12:18:16 -0700 (PDT)
Message-ID: <631dd09c-94e1-44bd-88a0-32ecd12f8221@gmail.com>
Date: Tue, 26 Sep 2023 14:18:14 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Content-Language: en-US
To: Bryce Johnson <bryce@redpinelabs.com>,
 James Prestwood <prestwoj@gmail.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
 <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
 <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com>
 <5789f7e4-793e-8e42-29d1-1a92696ec2f4@gmail.com>
 <PAXPR01MB921752F18978A3F5A5E53C91F4E8A@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <82109cb9-3264-4b99-a6f7-e3d71da45270@gmail.com>
 <c69115a4-858b-4602-acf7-f968be707ea4@gmail.com>
 <PAXPR01MB9217D3D30DCE9AB01A000F5AF4EEA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <8ad9aec4-b72a-4838-aff4-cc52e6018dcf@gmail.com>
 <PAXPR01MB9217F29A004603E62CF9FA2AF4EDA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <1f4a9aaa-6e7f-4f07-9ee3-87599b47eb3e@gmail.com>
 <CADXxVSJV88op2uJxpY1uW3ruoGvh290__EhXUJpH27DU=7g+ew@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CADXxVSJV88op2uJxpY1uW3ruoGvh290__EhXUJpH27DU=7g+ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bryce,

> Still having issues with wifi certification around the PMKSA caching.
> After finally convincing the person at the wifi alliance support
> person where the spec didn't say PMKSA caching disabled needed to be
> in open mode I got this back:

Which test spec is being used here?  I assume something like "Wi-Fi CERTIFIED 
WPA3 Test Plan v3.4.pdf"?

> 
> "Thank you for sharing the PMKSA_caching information from the IEEE
> Spec. It appears that it only describes the correct behavior of the
> DUT with PMKSA caching but does not provide any information about
> PMKSA caching for WPA3 SAE-H2E.
> 
> However, according to Security R3 MRD v1.3 (May 2020), PMKSA Caching
> is mandatory for all devices, which means your device must have the
> PMKSA caching function. You can find more details in section 6.3.1,
> 'SAE Hash-to-Element,' of the Security R3 MRD v1.3.pdf document, which
> can be downloaded from the following link"
> 
> Those lines are here:
> 6.3.1 SAE Hash-to-Element
> • Support for the SAE Hash-to-Element (H2E) technique defined in
> 802.11 REVmd D3.0, including support for Rejected Groups, and back
> compatibility with the SAE Hunting-and-Pecking technique
> ▪ H2E support is required for all mandatory and optional SAE-based
> WPA3 features that are supported by the device
> o Note: PMKSA Caching is mandatory for all devices; FT-SAE is optional

Indeed.  Funny that the Test Plan above does consider PMKSA optional:

"If the STAUT cannot support PMKSA
caching when the disconnect is
triggered on the STAUT, trigger the AP
to deauthenticate the STAUT."

> • Support for BSS Membership Selector indication for H2E-only SAE, as
> defined in 802.11 REVmd D3.0
> • New MAC/PHY/Bands shall only support the SAE H2E method.
> 
> I can provide a copy to the PDF if someone was interested.
> 

I'm not quite sure what benefit there is in supporting PMKSA for WPA3-Personal. 
Maybe lessening the CPU load on the AP?  The number of messages exchanged will 
be identical if I recall correctly.

> Honestly the wifi alliance has been pretty frustrating to work with
> and takes 1-3 days to get anything back from them.  Depending on the
> followup response, for this product it looks like I might have to
> revert back to wpa_supplicant and deal with some of the issues with
> using that.  I got spoiled with IWD ease of use (and it seemed to work
> better in some situations).
> 
> Products must be getting certificated using IWD right?  Did I just
> come across the wrong support person?

You're the first I've heard about.  If anyone else is going through the 
certification process, I'd certainly love to hear about it.

Regards,
-Denis
