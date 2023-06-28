Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA3C2F8
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 14:49:42 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-565a8d74daeso398220eaf.1
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687963781; x=1690555781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tcrKvZ8Mnz4E66nW9NgNAr+V8RwWXJiujKhimnRuhZw=;
        b=R9eEeHbYke+t8bpgsy5bEUJRmvAyWY2p8b8oPjphHw4nNCF9NwQNy655OP7LP2h8Dp
         ubjhn2xjIdxLgHLynaUrQ8I+3ysOYpMLriBAYji7hgNuqCrha+GQRmCGczSckUapAn2J
         TcJloDdNXLHfTM5okX/wQPbJbybbgcfwN12ApGp34nzGmuexL19EAd7+QHu/bURVfTlM
         izCm71Td7Cc4YCzGFXc/yvyIE0CxpngJokX9aO2xFZR45VYi3SwKz9c/yqL+0EYU/Edd
         QR1/dTJqjkYhQ6ZFB3dLyz2N4KvPFltTplb3e5xA0dc3rV2PCVPdv/1X2Stq0bjvjJVr
         /lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687963781; x=1690555781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcrKvZ8Mnz4E66nW9NgNAr+V8RwWXJiujKhimnRuhZw=;
        b=ZXjGQuUJM7EYd4KfV/72Fvpa6x8q1KUQ2MpXOa6nd2f5wyYkFrpJuhGK3oOHDT8m9w
         OwEIJm4RHht0WRskPDSMH+UprsSjEMevxAMGyJVmOwh2mHtBnDM+LjA6m7jkIacyV5SS
         /D1YesQ7lK/tnhJznyJwG1crP8QvvOPi+1EhSx5IJsuCoj2QAyEXJzbXhwh/2IdSVfZ3
         6xCZAVNiq3IBN0D/bG7URLc6B6K7o/CgassC3u8P6M0e+nemgPmDINIvetsi32Qg4nzJ
         tlpLPr/h9qxBYy/rMCDoSPZaUtlMao6rEalwlbp0/GNtCrENsV9sy4ihuXIbnlxG5Ny8
         mVlQ==
X-Gm-Message-State: AC+VfDzdrDvh6uyLWzmmdbwl8Bi57G5U9X5Xa+IPG1nP6lKMwH+OSKM+
	MC9u+71FvE+TGyEkMka87HRl96gXvC8=
X-Google-Smtp-Source: ACHHUZ5BkuOVBR56f9q0Bqr+Twr1yx7sjXoRgUniDQ5de+eKW+9htC0Anp/aJKQCcIUBbx00WbeTlg==
X-Received: by 2002:a4a:dd0d:0:b0:562:ff8a:75b7 with SMTP id m13-20020a4add0d000000b00562ff8a75b7mr1045471oou.3.1687963781539;
        Wed, 28 Jun 2023 07:49:41 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r2-20020a4ae5c2000000b0054fd51435efsm4325306oov.8.2023.06.28.07.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 07:49:40 -0700 (PDT)
Message-ID: <2c35a14a-3ed7-fefb-5a78-fb29199f0fd4@gmail.com>
Date: Wed, 28 Jun 2023 09:49:39 -0500
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
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230504215247.581443-1-prestwoj@gmail.com>
 <54ae38d6-cc94-9410-8121-44ece399b24c@gmail.com>
 <39610c47-eaba-2299-9b03-5217355e8d47@gmail.com>
 <88f638ea-bb37-c417-3b1c-1d7151506911@gmail.com>
 <7fdc5d67-e740-d593-253b-564bdf92048f@gmail.com>
 <d2d0841b-62a0-c8df-924f-851df5f88203@gmail.com>
 <865cf0a3-1be4-34cb-0535-e76cf43d6753@gmail.com>
 <63162827-5b8b-3c70-7f6f-fc7b513f2b6d@gmail.com>
 <1742c6eb-bbd5-7883-5a72-53021a771ca6@gmail.com>
 <3790483a-442f-9602-03c9-b205376d9262@gmail.com>
 <280831cf-933a-95b0-3889-ddca6ca544cc@gmail.com>
 <24a0ae5c-529b-a061-0fb4-0ba8a66fe76b@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <24a0ae5c-529b-a061-0fb4-0ba8a66fe76b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> So one other caveat with this is that IWD creates its interface while inside the 
> namespace. So we actually cannot track that. Only thing we could do is force the 
> interface creation ahead of time, and make namespace'd iwd's use the default 
> interface.
> 

Yep.  Since iwd will have to handle multi-mode devices and multiple interfaces, 
there's really not much we can do in the general case.  This is why we need to 
pay attention to HWSIM_CMD_ADD_MAC_ADDR.

Looking at that kernel commit again, it seems to already invoke 
mac80211_hwsim_config_mac_nl() on add_interface and remove_interface.  So maybe 
everything needed to handle interface creation/removal inside namespaces is 
already there?  If not, then any missing event generation should be fixed in the 
kernel.

Regards,
-Denis
