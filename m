Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9855C8E3
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 15:33:11 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso6075223e87.3
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687966389; x=1690558389;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iH0iLc5aY1dXx75586KaWjXJTn5aKF9uLNV+M97zZXU=;
        b=aULP4oCukTKXwQ8P0FXIWp8qxSO/BzGSUtrC9oNWcZlTHkDEa2d1MDeE4FqAdQBfhH
         eAbsqYubek1eWG/asS8Oa+GFaYPqKGh1BqDS+85g//2d7uJZ/6Yqexywng4S9uk0fYd2
         DwWrkoJ3Frxu8Djfjtc5JdUbGtzKD/NR3VnQZIfYSqPT3aPN7nHPhZsGi2+sCiAXuVpe
         ZfUm0LoDzeUXguoVKo03kPVmPmz7n+w3B64yzYI0NnD53E15huMdskOP86gCory24Pbt
         BN+rIqOmzUKUnJfk7pWuQZ3ezNvsC8R5Rn+cXzlaIkEgjkXuedHyEVA7G4pxKY6fEgrf
         UyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966389; x=1690558389;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iH0iLc5aY1dXx75586KaWjXJTn5aKF9uLNV+M97zZXU=;
        b=PHB886eH+c5Qyvz2zMx08F/6owKFTB4N61MjH2U4FfO8hXTsy5cyYm3Qr71y3PTxF1
         UHfa8NwZlUtEPRIL3dU+B9C0/4QPXb1MLwajZ81tNGuiqQy6U7BPWCL4Wul/28yPyTgv
         /a154BAcWgGKr5U0tJsSV43BtTQ4AfT2TYb9CqZoFqETCTqndzE8zLFwK7taOuJQoefv
         Ym9ZBybcvcMs5wRu4dlhRE0ln2wrHMLuJV9eXbeINhBYc4u3P4usKNuGyYfouEdYPLGr
         4+FwKmOkNVuuCRjl3w5h2R8PcXHeaxItwGP98PWTRQcC66zZ34AEQAVsEdwXj5scAebB
         FjTQ==
X-Gm-Message-State: AC+VfDypriuY0QhNDo2cHbA/m9FZK1LJF20JrQpwvPGGs9lVORYB+tiR
	xF5sekuQ3hUwrxVdockxhGntZIuN1Q0=
X-Google-Smtp-Source: ACHHUZ45GxPoFemdz6ht8+CqyDRCDcDI1Inaij3KXUeflxvBHygJ6Op/K9CdN7PloYZqQRgRsrAuYA==
X-Received: by 2002:a19:6904:0:b0:4f8:6d53:a692 with SMTP id e4-20020a196904000000b004f86d53a692mr16431642lfc.61.1687966389096;
        Wed, 28 Jun 2023 08:33:09 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id o16-20020a05651238b000b004fb8a2b9485sm543205lft.248.2023.06.28.08.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 08:33:08 -0700 (PDT)
Message-ID: <82ba7228-441f-ebf1-22d2-890b00c676e2@gmail.com>
Date: Wed, 28 Jun 2023 08:33:04 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] hwsim: remove 'optimization' sending to only known
 MACs
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
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
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <2c35a14a-3ed7-fefb-5a78-fb29199f0fd4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 6/28/23 7:49 AM, Denis Kenzior wrote:
> Hi James,
> 
>>
>> So one other caveat with this is that IWD creates its interface while 
>> inside the namespace. So we actually cannot track that. Only thing we 
>> could do is force the interface creation ahead of time, and make 
>> namespace'd iwd's use the default interface.
>>
> 
> Yep.  Since iwd will have to handle multi-mode devices and multiple 
> interfaces, there's really not much we can do in the general case.  This 
> is why we need to pay attention to HWSIM_CMD_ADD_MAC_ADDR.
> 
> Looking at that kernel commit again, it seems to already invoke 
> mac80211_hwsim_config_mac_nl() on add_interface and remove_interface.  
> So maybe everything needed to handle interface creation/removal inside 
> namespaces is already there?  If not, then any missing event generation 
> should be fixed in the kernel.

Unfortunately once you move the radio into another namespace you lose 
any events associated with that radio, due to the PID of hwsim being 
associated with a distinct namespace (I think). So ADD/DEL_MAC_ADDR 
won't help here.

But still, its nice getting the ADD/DEL_MAC_ADDR events purely for 
supporting address randomization.

> 
> Regards,
> -Denis
