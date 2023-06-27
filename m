Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D20A47
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 02:48:50 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-19fa4346498so3256583fac.1
        for <iwd@lists.linux.dev>; Mon, 26 Jun 2023 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687834129; x=1690426129;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJU/YapliTKFs6WeOywZRCM27DmUi2e0w8NHh9DwcuA=;
        b=BjD9gzhn1NSQmB+NYz+Y1JSNE9GBiYkdn5c+43ZAaEpOtttqYZi0rD9KaU9KjVD1BQ
         9AWArA9azqo30N4M95of8Z6C/NxufCC9+Znsxn4IlVuArJ51qrxML5+QXtB4QjbRlNq7
         jwBBNk6+hp34FrtAX1Oi9Hbt8XrSJEqOhRQB8ztU4SqQI9BmJXjHeI7V43j7YJg72r9T
         tKuJ+q4eW9unWFEFyMGy5jTioXHwWgbIxzWLdHtjF7I8R1WzAgwyL88X6HmRw0dc7iEd
         mVRUQxJ+cRuHLwb79RW9WiEVT2UXNLASBPHCCvo0+Es7WWyin8oqMOOEPmNbyDyxZbU/
         VJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687834129; x=1690426129;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJU/YapliTKFs6WeOywZRCM27DmUi2e0w8NHh9DwcuA=;
        b=KpOU3nTIqOBXt3NtaDy3EtEgSsO/Zq2L3kFg0K/9PhEGA+LazhRIgOU+aDaC2kBz0R
         ACS1CYSqlTDvPkZ2D7L+aMn2WYSc/3VWJMEmXcgITH6ilM3CgALzwaSTGgyLtgUbrleL
         xnxdZJYZ1GNcCa4Md3i718AfrI+/0XRIU1aiFGyEGvaMHQ2u2kn8cjWyeWAfMpeRRRGq
         rqNA9Uuo3S73BpeSmR84oa3n24qhzy2cZJqoKBdsos8QsvCkKi58eoZC2hhTNDDjLTCU
         QB4kW7fBz3LaeaOeT8kl5+4s4yfoybJho/xO5whoEPUGaRujZjjgDoDL9Djyurs2AkAQ
         +ruw==
X-Gm-Message-State: AC+VfDxZwshLwW2v3tjwGotXrexucZD1fH25a2Lot8WjReuQt9uyQsow
	4naV7RaLWJj9uMp1RADqs6zpJEKXj/o=
X-Google-Smtp-Source: ACHHUZ4UNicUMNh7rbEM7FAfodAmW2Il2/ETCNXAdBfuDHxdzvnlMsMfT3NcQxRSyZpdHJtPMp4m4w==
X-Received: by 2002:a05:6870:8805:b0:187:92fb:6ecb with SMTP id n5-20020a056870880500b0018792fb6ecbmr23588556oam.20.1687834129587;
        Mon, 26 Jun 2023 19:48:49 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id pu4-20020a0568709e8400b001a66a48a68asm4413383oab.57.2023.06.26.19.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 19:48:49 -0700 (PDT)
Message-ID: <1742c6eb-bbd5-7883-5a72-53021a771ca6@gmail.com>
Date: Mon, 26 Jun 2023 21:31:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
 <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
 <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com>
 <63162827-5b8b-3c70-7f6f-fc7b513f2b6d@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <63162827-5b8b-3c70-7f6f-fc7b513f2b6d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> Just an update here. The reason hwsim was behaving like this was because 
> DEL_WIPHY isn't handled but DEL_INTERFACE is.
> 

Funny.

> So when hwsim starts it dumps and tracks all the radios but when a radio gets 
> moved into another namespace only the interfaces get cleaned up. Then a frame 
> comes and hwsim won't find a matching interface->addr to send the frame, and 
> bail out. But when I removed that block of code it wouldn't bail out and since 
> the radios still existed in the queue the frame could be sent out to all radios 
> including "removed" radios. Since the kernel doesn't care about namespaces those 
> "removed" radios still got the frames.

Ok, that makes sense now.

> 
> So at least that's sorted out. How we want to support namespaces is the 
> question. A few options:
> 
> - Peek into the frame at the destination address and use that as ATTR_RECEIVER, 
> but this won't work with address randomization for phys outside of the root 
> namespace. IMO this is probably fine for testing purposes, if we know about it 
> ahead of time.

You can try to see whether HWSIM_CMD_ADD_MAC_ADDR works?  See commit 
5cc58a9ecfa1 ("mac80211_hwsim: notify wmediumd of used MAC addresses")

> 
> - Add support to hwsim to move radios to other namespaces, and keep track of 
> those radios (similar to what we erroneously have today). This is fragile though 
> because you no longer can remove radios/interfaces, nor do you know if they have 
> been removed.

Hmm, but radios are namespace independent.  They can only be added/removed via 
HWSIM_CMD_ADD/DEL_RADIO, no?  Since phys are moved wholesale across namespaces 
(you can't only move a given interface), you could assume that once a radio is 
created and populated, its interfaces do not change for the duration of the 
test, even if they're moved to a different namespace.

Or if the HWSIM_CMD_ADD_MAC_ADDR API works, that might make things even simpler.

Regards,
-Denis
