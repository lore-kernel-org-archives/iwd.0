Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176AC8E3
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 15:43:57 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56312517201so21021eaf.2
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687967037; x=1690559037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RLyLjPAlY5gCI1hym0VrQEhIyKapjtqeYgAstwyFLCM=;
        b=EPf4r4oTS3ctxYrwQsA/6okV3jx7Vx/8Uddlnvk8f/5JTi21rK/PC+LmXEOIhY+SQN
         Bb17izZ4K1ny24KgDd5yN1ka58IfrLIosSVqgNnjkqOX1KWt6Ce9KEJaXUr3YgmYQF5l
         cpNmiivuZQwvztMI4b4+j0I0UyxTR+FLHBGqaHoP+fDZSwU0H4cAIndCAaXICGwVXgd6
         qaTD6lbmyj8xcHC1D6Utr3ZUvzUoZLgbkhHKFyW90FW7YnA4n/0YVHuBZPdrnXDREmNs
         Vquge+xCdXVOSV72Y1wlE9AO8E/nQjaqiXaJ4RJsp/RI+//jB62zVn5fdGlWkkMPtW4h
         sZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687967037; x=1690559037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLyLjPAlY5gCI1hym0VrQEhIyKapjtqeYgAstwyFLCM=;
        b=BMiJLejxiV281Ge4BtZAKWRofBmqW040Rad7ANwAXoeFOnXzev7DyYPf4pwjIkomAl
         cPdtEG0hgiKXPHKrPCCiTa+1ff4WqzRgEw+g8Kw3WhqE3hHSEqQIi9EvW6uD6PdQKqUr
         EaLUN/W76GNeNbSyxtYsdGVCb8wRZNumPppjKPu4zzEtkHeid+DREePMLd2p+xio/puK
         /iiPhWBNSrZSBXsA72f+Aydww34bGqxRCGy5Mu+UZ8/WqSPVVYYXdh3vH5ejwelugd8H
         xG1WOIolSQwnNahuK8zvDoF9G6Zc0CS3OR+eAtpIsBRy/ndN0hJQ5NJVu1DnbPhLwfFa
         Vclg==
X-Gm-Message-State: AC+VfDwxo1hNWBi6DTHo4//iJXPi5RF/cM32NFnWshdmBdtrSPnGBJJX
	+fsfRMUhDEqERga7mF1TVlo=
X-Google-Smtp-Source: ACHHUZ41KuiSUfQKLBjInA4BHranJ4zrcyCiroPc+GcxW3B0TP9LGfy+YEOZuTZDNB7n5VD0ffjNcw==
X-Received: by 2002:a4a:d1b4:0:b0:565:a7bd:3917 with SMTP id z20-20020a4ad1b4000000b00565a7bd3917mr1561704oor.5.1687967036878;
        Wed, 28 Jun 2023 08:43:56 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id b26-20020a4ad89a000000b0056309321491sm4359469oov.3.2023.06.28.08.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 08:43:56 -0700 (PDT)
Message-ID: <7c2ca71d-5cba-c067-04bf-75a9341f3db6@gmail.com>
Date: Wed, 28 Jun 2023 10:40:34 -0500
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
 <2c35a14a-3ed7-fefb-5a78-fb29199f0fd4@gmail.com>
 <82ba7228-441f-ebf1-22d2-890b00c676e2@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <82ba7228-441f-ebf1-22d2-890b00c676e2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> Unfortunately once you move the radio into another namespace you lose any events 
> associated with that radio, due to the PID of hwsim being associated with a 
> distinct namespace (I think). So ADD/DEL_MAC_ADDR won't help here.

Which events though?  You should always be getting HWSIM_CMD_ events for _all_ 
radios since only a single hwsim instance is registered, no?  Aren't these all 
you need for the purposes of sending packets to the right radio?

The NL80211 WIPHY events aren't really needed.  We only use these for 
informational purposes (only the name is used, I think?)  I guess we also use 
this information for the radio_ap_only() optimization we do, but we could 
probably solve this another way.

Regards,
-Denis
