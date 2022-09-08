Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E805CA6
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 20:04:12 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id 73so17794343pga.1
        for <iwd@lists.linux.dev>; Thu, 08 Sep 2022 13:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=F/uZjwwOJ8K/Y5+ek6GSP/e7XCjqJDNxRTtWfU+J1qs=;
        b=dQFxZqY4E7GWrcuqkEXzxE+L9u/DfUsg4pQvNyjwkz0CFaM0AbQLRQNX79/6TihjDL
         4WWEYWhwSy90Hq4UXZeT8jlOJSFRQOdX3f7D3neUviwHRXu4zXmyMETB9s9ROQQnBTLf
         XDcvprH/KeKPXn+gAX+hU0G80hcY8dHzkxZskVxFI8ifkCwSYfcoayy4o0tgGSAXbWF5
         TkYR8RzJQs7S+V2kXs6c0ZlUpGFIVp554TpAZNKzrMuEvC0gbtmNzc/UXFmOIu7o1Wzn
         868GQ+L+8QP3dAvbUAa+3VXT6lRDyKXcQCoDEC9Gx3K7NtHX/71lbGDdyUn3+mOvEXqF
         ek5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=F/uZjwwOJ8K/Y5+ek6GSP/e7XCjqJDNxRTtWfU+J1qs=;
        b=LS6RBkc1SrKdDOvZUO0JlxCG1l68421j24HgX9aHIEgGMcWxFbQhcGNP2nUcqMnMk0
         XNslfBaOqJT1NHA48K01JiQXgRPhQe6kn8tJH200GTN1HtvM31Ea57g1jj9zgXALMClA
         qAnYbbxOcRLNZUcvoJNJgqhsgrecX460/OHRf9t4BF7tcilT1mVtwSuqkHewHOZ4N+kn
         HSHfJ2yBo/zIzbz9wxV1v1UzECY+5QZ4ocv7784T5xJsrtMkRzRkfMSTWx40Jij3ezBB
         QaxVEQ06Fbise4YOMnCKLgkl8/K4rzEQyt0Za+wSu0nSsCijWo4sY7c61r5glXtn5VUN
         lFzg==
X-Gm-Message-State: ACgBeo2YFM//2ArjtT/fvSimmQzd0W/S3jn1I8IC2T8qN01UmvE9X6xP
	nyvrPZ10RBZTVwnjTVPwgv0=
X-Google-Smtp-Source: AA6agR5SeGQXhmc33cCWA97vG48wyFzBBgyez32cfJk0FyFzZBClyf9T/X5DRhsPwi8Faq2Rq1tjmg==
X-Received: by 2002:a63:91ca:0:b0:436:64db:c902 with SMTP id l193-20020a6391ca000000b0043664dbc902mr4297082pge.87.1662667451955;
        Thu, 08 Sep 2022 13:04:11 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b001768db880c4sm12290706plb.275.2022.09.08.13.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:04:11 -0700 (PDT)
Message-ID: <57215da9fd5a65e4b804bd2f4602f2660065c85f.camel@gmail.com>
Subject: Re: Could not start RRM scan error - repeated
From: James Prestwood <prestwoj@gmail.com>
To: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>, "iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Date: Thu, 08 Sep 2022 13:04:11 -0700
In-Reply-To: <AS8PR01MB7493EE14AFA1C016A6FFA60DF4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
References: 
	<AS8PR01MB7493D4E15D3465B3B0491B22F4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
	 <0913644cbda1bd56a556a3733fd2acbf9ab433f6.camel@gmail.com>
	 <AS8PR01MB7493EE14AFA1C016A6FFA60DF4409@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> 
Hi Bryce,

> > Event: Frame (0x3b) len
> > 124                                                                
> >                                                                    
> >                                  1662665471.868517
>     Wiphy: 0 (0x00000000)
>     Interface Index: 3 (0x00000003)
>     Wireless Device: 1 (0x0000000000000001)
>     Wiphy Frequency: 2417 (0x00000971)
>     Reserved: len 4
>         00 00 00 00                                      ....
>     RX Signal dBm: -77
>     Frame: len 67
>         Frame Type: 0x00d0
>             Type: Management (0)
>             Subtype: Action
>             Action Category: Radio Measurement (5)
>             Radio Measurement Action: Radio Measurement Request (0)
>                 Dialog Token: 52
>                 Repetitions: 0
>                 IEs: len 38
>                     Measurement Request
>                         Token: 52
>                         Request Mode: 0
>                         Type: Beacon
>                         Operating Class: 125
>                         Channel: 149
>                         Randomization Interval: 0
>                         Duration: 50
>                         Measurement: Active
>                         BSSID: ff:ff:ff:ff:ff:ff
>                         34 00 05 7d 95 00 00 32 00 01 ff ff ff ff ff
> ff  4..}...2........
>                         00 0b 72 69 76 65 72 68 6f 75 73 65 31 01 02
> 00  ..riverhouse1...
>                         00 02 01
> 00                                      ....
>         d0 00 3a 01 38 5b 44 08 16 d5 50 d4 f7 c2 a3 e2 
> ..:.8[D...P.....
>         50 d4 f7 c2 a3 e2 b0 24 05 00 34 00 00 26 24 34 
> P......$..4..&$4
>         00 05 7d 95 00 00 32 00 01 ff ff ff ff ff ff 00 
> ..}...2.........
>         0b 72 69 76 65 72 68 6f 75 73 65 31 01 02 00 00 
> .riverhouse1....
>         02 01 00                                         ...
> 

Nothing seems particularly wrong with this request. I but I have a
hunch it has to do with restrictions on your device. Its asking for an
active scan on frequency 5745. Could you check if this frequency is
restricted in any way, e.g. 'iw list'.

For example under section for 5Ghz bands you'll see frequencies listed:

Band 2:
	...
	Frequencies:
		...
		* 5745 MHz [149] (22.0 dBm) (no IR)

As you can see, mine has a 'no IR' restriction meaning active scans are
not allowed. And I don't see that we check this anywhere in IWD, so at
the very least we need to do that to prevent the kernel bouncing back
the scan request.

Thanks,
James

