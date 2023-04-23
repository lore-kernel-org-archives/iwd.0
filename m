Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCF3D76
	for <iwd@lists.linux.dev>; Sun, 23 Apr 2023 23:25:24 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6a5e2289965so3290882a34.3
        for <iwd@lists.linux.dev>; Sun, 23 Apr 2023 16:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682292323; x=1684884323;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1O2KPT8Vsfr0ZIdvwuTUD+V5fIP/gcxRv4znnoq3N8=;
        b=euGWOv0D8VnQtm3zaumoEGrqAqvMxH4XYlgwkuMcSQchFX9E5MRR0KbigPjRPgrFUw
         EvolLYSWD7PDyZpzoGp+JJ+Y6MS3OmULrwsx4waYEv+oXvl6ILNM6ZrxU41+1yCqJ3bo
         NDcSWxamSNZdpoATsKML6rXoqL0TC2J2NkEYc3O0Juk/cUalsUJ/FXzmBbKBwud0vMjv
         LXT8dtxUm3+pT+HelWkBqUQNhQ4frk6jkxvrgU+SWyVKwNFWCUWD7bqOC9cwz5ChyLR9
         fgM2XxxJnh+izcG3wyMb7EDUh1IosTwFBdo9SS+STdCl6QLwu4YtCi2f3+FJQ384+25K
         +UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682292323; x=1684884323;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1O2KPT8Vsfr0ZIdvwuTUD+V5fIP/gcxRv4znnoq3N8=;
        b=fTTgY/YPLMCwCfXsPTVFc85W0Ev9ewiHPQDSt6aEdkDYPEhNNB+gSH/a0xbP+am3WE
         WfbF9Li9Yi7/Vw7OAO1fdyNT8UYcgyekauYFr6ZrmOHwpZH7Ocs3N6yuZFZJ3Nrjh23R
         IWnSXk8UisPCGEYp6HRcsjU/nJsD3UL4NF61Z8P9L8PxU62J3P+OtAD1DQ17MCciBDCb
         U/4pPsjvmi0/kEpoXSJc2PfKrin1yimO/0iwYW4OC/qEY+IDPvGVqtGnzMkJ41cihgaw
         hblPkBKjqYwnKxT1kuiXNUUfD3pSyvEtirFBDe9rTM0Qf+s5LXfP2Wx+FsHe1MzIlxod
         WYPg==
X-Gm-Message-State: AAQBX9dgFaO7TT97StQFvOFstBe+f+T18PqQIDYqHB0sQrjLMrLvfY1g
	8DXGSa3OxdYhLWGn1Hm0dhE=
X-Google-Smtp-Source: AKy350adtxLi20wwUB8Zgx44oAjRyRSfg6YkEcUUccAvfYkfsdsZYV1hTnHiSCco5b5OlwTacRBy6A==
X-Received: by 2002:a05:6870:51c6:b0:187:7758:ea63 with SMTP id b6-20020a05687051c600b001877758ea63mr8166912oaj.25.1682292323523;
        Sun, 23 Apr 2023 16:25:23 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w22-20020a056870a2d600b00172428894e0sm3927632oak.28.2023.04.23.16.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 16:25:22 -0700 (PDT)
Message-ID: <5789f7e4-793e-8e42-29d1-1a92696ec2f4@gmail.com>
Date: Sun, 23 Apr 2023 18:05:15 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID
 generation
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com>
 <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
 <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> The AP can advertise both FT+8021x and 8021x.  STA can preauthenticate to such 
>> an AP.  It can then connect to this AP using PMKSA caching, potentially 
>> selecting FT+8021X as the AKM for the initial association. Table 9-151 even 
>> hints at this: "0 (open) for FT Initial Mobility Domain Association over IEEE 
>> Std 802.1X or PMKSA caching".
> 
> Yes I suppose then preauth + FT is broken, or at least incompatible depending on 
> hostapd version... but fixing this is somewhat impossible right? We don't really 
> have the opportunity to try both derivations since we don't know what the AP 
> used (unlike eapol where we have the PMKID KDE to reference).

The spec is somewhat contradictory, but I think Preauthentication should still 
work in this case.  We should not be re-computing the PMKID when we attempt 
preauthentication, unless the PMKID is not recognized by the AP.  But this can 
happen regardless.

Here's some relevant quotes:

12.6.10.2:
"The result of preauthentication may be a PMKSA, if the IEEE 802.1X 
authentication completes successfully. The AKM shall be set to 00-0F-AC:1 in the 
PMKSA that results from preauthentication. If preauthentication produces a 
PMKSA, then, when the Supplicant’s STA associates with the preauthenticated AP, 
the Supplicant may use the PMKSA with the 4-way handshake."

12.6.10.3:
"When the PMKSA was not created using preauthentication, the AKM indicated in 
the RSNE by the STA in the (re)association request shall be identical to the AKM 
used to establish the cached PMKSA in the first place."

12.7.1.3:
"When the PMKID is calculated for the PMKSA as part of preauthentication, the 
AKM has not yet been negotiated. In this case, the HMAC-SHA-1 based derivation 
is used for the PMKID calculation."

The three quotes above hint at PMKSA being established via pre-authentication 
with the PMKID being calculated via the legacy plain 802.1X/SHA1 derivation. 
Which means that we are be able to pre-authenticate, and then use the derived 
PMK at the new AP, even if we pick a different AKM than plain 802.1X.

The 'pick a different AKM' part is a bit unclear though.  Since there's another 
passage which is contradictory to the three above:
"Upon receipt of a (Re)Association Request frame with one or more PMKIDs 
following Open System authentication or (only in the case of a DMG AP) if IEEE 
802.11 authentication was not performed, an AP checks whether its Authenticator 
has cached a PMKSA for the PMKIDs and whether the AKM in the cached PMKSA 
matches the AKM in the (Re)Association Request; and if so, it shall assert 
possession of that PMKSA by beginning the 4-way handshake after association has 
completed and shall include the PMKID in message 1 (see 12.7.6.2). If the 
Authenticator does not have a PMKSA for the PMKIDs in the (re)association 
request or the AKM does not match, its behavior depends on how the PMKSA was 
established."

Do note however that nl80211 doesn't include the AKM in the PMKSA cache.  Who 
knows what hostapd does?  Probably some testing is required as to how exactly 
they interpret this.

But the spec clearly intends pre-authentication to use SHA1 for PMKID 
derivation, so we should make sure we do that, at least.

Regards,
-Denis
