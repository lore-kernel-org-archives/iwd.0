Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60246AD
	for <iwd@lists.linux.dev>; Fri, 14 Jul 2023 03:51:16 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6b9bf1ed7feso46063a34.0
        for <iwd@lists.linux.dev>; Thu, 13 Jul 2023 20:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689306675; x=1691898675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMKt+maqeivDJA05l2U0mdWg+VLC/yrUqUfKJVdU4p0=;
        b=ATveFsbMj1eDfbjmNhI836KpLDv2ntc/GFTBRUDJHS0LloOPHIlVe2octCgvuz7Z1o
         sLASMTT00WRKDeDuBYrBRNBOiDO/qUJn3nxvBDyIC+etxbXz2DPwPIllOaiFnQ2gKE5P
         YVbjPy7BQjm0pRLkXlwKTtS733mSJIOY+36hfOQQpZa815GmkOyA1+zHeDbHqJkyCkqI
         wHi4UrRDTzzWq1RNnldG+yvPPj7vlw8suFsGqanm/WsTx2h5W6yS046A2pkBkm6L9Ks4
         VFJ7FR42aOfUfdjuEuWBjdkQsE2mgdNnhVIA72V+nwBHwxukTGz42AA6I+HdIcVKPbGo
         oVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689306675; x=1691898675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMKt+maqeivDJA05l2U0mdWg+VLC/yrUqUfKJVdU4p0=;
        b=RcLvnuRIuOmwfn4c5f4bwOIdB4d6J83d+2j7TJeYC7WyfGLKFhe0+GmJtsgzwLD3kV
         lMG53pGMrKxjPgkrGDBQvCL8NEePLtdae57+2DhvWmEWc0UzRwUFWLl55li3dIkrXc1f
         44ZQulExXSk18FtcZi+2n1QUEY58UVihIF4Mfxi7nlQYwtj8rd35XvLB+xZq4uiEkgYw
         wb0+33LfQDrT88ak2OZSC1GyMK+ExDDytARYRskLBenhKMYBZ7DreAz380+IjDoIO4WW
         5NIdCsejSwXlK2I7+FX+tW6wVYYr4rk57VK3W8dg0K9vUSVk+uK+whTqDGQ4v2v+UF/D
         SEow==
X-Gm-Message-State: ABy/qLbLusE3NVR4ouw3H8CcqhmdEfEOAf1Iup/DycDKRzHTvlvbUZkl
	rFh9F9eZ94W8oRIDKOetshI=
X-Google-Smtp-Source: APBJJlFod5rcsIU/8TgBO07L7Xfj1/a52nZyseX6N/zpqgCEi4lOSEzVofMMF7tpEfEaEuIzykGxQQ==
X-Received: by 2002:a05:6830:1494:b0:6b9:9e42:9319 with SMTP id s20-20020a056830149400b006b99e429319mr4179979otq.9.1689306675275;
        Thu, 13 Jul 2023 20:51:15 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r3-20020a05683001c300b006b4281cf424sm3486461ota.4.2023.07.13.20.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 20:51:14 -0700 (PDT)
Message-ID: <5c6f96fa-dd84-df1a-7684-5692944fcb4e@gmail.com>
Date: Thu, 13 Jul 2023 22:51:13 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] netdev: relax requirement for OWE AKM in assoc reply
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: Wen Gong <quic_wgong@quicinc.com>
References: <20230713144237.2977210-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230713144237.2977210-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 7/13/23 09:42, James Prestwood wrote:
> Some APs don't include the RSNE in the associate reply during
> the OWE exchange. This causes IWD to be incompatible since it has
> a hard requirement on the AKM being included.
> 
> This relaxes the requirement for the AKM and instead warns if it
> is not included.
> 
> Below is an example of an association reply without the RSN element
> 
> IEEE 802.11 Association Response, Flags: ........
>       Type/Subtype: Association Response (0x0001)
>       Frame Control Field: 0x1000
>       .000 0000 0011 1100 = Duration: 60 microseconds
>       Receiver address: 64:c4:03:88:ff:26
>       Destination address: 64:c4:03:88:ff:26
>       Transmitter address: fc:34:97:2b:1b:48
>       Source address: fc:34:97:2b:1b:48
>       BSS Id: fc:34:97:2b:1b:48
>       .... .... .... 0000 = Fragment number: 0
>       0001 1100 1000 .... = Sequence number: 456
> IEEE 802.11 wireless LAN
>       Fixed parameters (6 bytes)
>       Tagged parameters (196 bytes)
>           Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
>           Tag: RM Enabled Capabilities (5 octets)
>           Tag: Extended Capabilities (11 octets)
>           Ext Tag: HE Capabilities (IEEE Std 802.11ax/D3.0)
>           Ext Tag: HE Operation (IEEE Std 802.11ax/D3.0)
>           Ext Tag: MU EDCA Parameter Set
>           Ext Tag: HE 6GHz Band Capabilities
>           Ext Tag: OWE Diffie-Hellman Parameter
>               Tag Number: Element ID Extension (255)
>               Ext Tag length: 51
>               Ext Tag Number: OWE Diffie-Hellman Parameter (32)
>               Group: 384-bit random ECP group (20)
>               Public Key: 14ba9d8abeb2ecd5d95e6c12491b16489d1bcc303e7a7fbd…
>           Tag: Vendor Specific: Broadcom
>           Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Parameter Element
> 
> Reported-By: Wen Gong <quic_wgong@quicinc.com>
> ---
>   src/netdev.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 

Looks fine to me.

Wen, any chance you can test this patch so I can also add your Tested-By?

Regards,
-Denis
