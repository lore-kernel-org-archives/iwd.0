Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D85CC8FF
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 14:50:02 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-3f9e33a3d3fso36317621cf.1
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687186201; x=1689778201;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZxzNOvPRrJMGqRs9Zi2NBX8dffKk0AcMmA+SgwTxh0=;
        b=qTh2JtgiWjaAYOLhXJhGipclnDeOUjZ+jkzQ30bHczU5smdYzALg9VbnQ2SgnCvm/H
         jAPQ6MxjxcN8Z9F+mJs6vB9p20D/KT0yUPBeMvS549EuqhKdAI3amV164LZXWygKnDAP
         DUJOwRMYse9MjtSsRRHBaCGFvVPpbZ1cPWGNo98BhXz5VDeLZduvAzoswZpzKEo7tXTY
         cXjjdMEpmpcKFlimTAeIFNchTF9GFrv5HQB7gBsscEECiti0dLyaLaKLrPX6aBJs08BY
         meVxczW9oPAUWhW2u/byRylu0IVdoBHAVB2+i+8Rr4ezuAVHY0dcAcsD48sWg5Rml+NL
         8rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687186201; x=1689778201;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZxzNOvPRrJMGqRs9Zi2NBX8dffKk0AcMmA+SgwTxh0=;
        b=cBWgUCb+8LTLkvYm1jJWx7E80sD00ihyN9ZEyl1dVLdmFhYij8Q6gJnfpBET335LkC
         JqYAG2bU1ZpzV5uo2zXVJiuulyHLpJdLkTQQ8acyaSiDur7PRalG4ScRcMRAkuldGmp0
         56N+LY6d3AQHdmkug1u7G0ivucu5qSDvy0awFkQrULovIDvNhkSvrTBL0OKiUYbefbLy
         oM8m82yI55DD14Jyn2LAjgyH+DWkQX/lGfCDO9qfbA5hSPuK3zjDTE7K3sxI0H213xmC
         Wds0IM8TIeb+HdEaat5liVSMorF4qovY1o2x20d5qWzEp5ASWXueI3yW6R1InAFcqMB2
         e7ag==
X-Gm-Message-State: AC+VfDzLocsZ0r80SoZ/EjMED+hIf7Hi83K6oCIpKeB7b/1u11AtLzy5
	PKdKNjMpVc8ehDt8aaSt90s8kB/vUiY=
X-Google-Smtp-Source: ACHHUZ65mhQmQEoSg946nqMcdz2l5qTHF43j4t6KsR9k6nYLdARphgtwF9/tAVvKwTwMd/cXPKelhA==
X-Received: by 2002:a05:622a:120a:b0:3f3:91bd:a46d with SMTP id y10-20020a05622a120a00b003f391bda46dmr13367194qtx.8.1687186200924;
        Mon, 19 Jun 2023 07:50:00 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id f4-20020a05622a114400b003f4ed0ca698sm10958559qty.49.2023.06.19.07.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 07:50:00 -0700 (PDT)
Message-ID: <f0558c33-1435-62cc-32f2-fe0673788531@gmail.com>
Date: Mon, 19 Jun 2023 07:49:56 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/7] wiphy: add [DriverFlags].PowerSaveDisable flag
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20230615192415.1718516-1-prestwoj@gmail.com>
 <20230615192415.1718516-4-prestwoj@gmail.com>
 <a3621173-3b82-2954-2454-a3039dd985ef@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <a3621173-3b82-2954-2454-a3039dd985ef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 6/18/23 12:07 PM, Denis Kenzior wrote:
> Hi James,
> 
> On 6/15/23 14:24, James Prestwood wrote:
>> Certain drivers do not handle power save very well resulting in
>> missed frames, firmware crashes, or other bad behavior. Its easy
>> enough to disable power save via iw, iwconfig, etc but since IWD
>> removes and creates the interface on startup it blows away any
>> previous power save setting. The setting must be done *after* IWD
>> creates the interface which can be done, but needs to be via some
>> external daemon monitoring IWD's state. For minimal systems,
>> e.g. without NetworkManager, it becomes difficult and annoying to
>> persistently disable power save.
>>
>> For this reason a new driver flag POWER_SAVE_DISABLE is being
>> added. This can then be referenced when creating the interfaces
>> and if set, disable power save.
>> ---
>>   src/wiphy.c | 13 +++++++++++++
>>   src/wiphy.h |  1 +
>>   2 files changed, 14 insertions(+)
>>
> 
> <snip>
> 
>> @@ -723,6 +725,17 @@ bool wiphy_control_port_enabled(struct wiphy *wiphy)
>>       return enabled;
>>   }
>> +bool wiphy_disable_power_save(struct wiphy *wiphy)
> 
> I named this wiphy_power_save_disabled to be consistent with 
> wiphy_control_port_enabled()...
> 
> I went ahead and applied this, but I think we have to fix the behavior 
> of this and wiphy_control_port_enabled().  Namely:
> 
>> +{
>> +    if (wiphy->driver_flags & POWER_SAVE_DISABLE) {
>> +        l_info("Disabling power save due to driver quirks: %s",
>> +                wiphy_get_driver(wiphy));
> 
> We shouldn't really use l_info here.  This method is meant more as a 
> getter and might have other users in the future.  Same case with 
> wiphy_control_port_enabled(), but that one is a little bit more complex 
> to fix.

Ok I can send a follow up patch. The only use for all these APIs is when 
creating the netdev so we *should* only see it then but now that we 
print these flags with wiphy_print_basic_info I'll just remove them 
entirely.

> 
> Patches 4, 6 and 7 applied.
> 
> Regards,
> -Denis
