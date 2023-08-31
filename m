Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2110E1
	for <iwd@lists.linux.dev>; Thu, 31 Aug 2023 01:41:53 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-57355a16941so247157eaf.2
        for <iwd@lists.linux.dev>; Wed, 30 Aug 2023 18:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693446112; x=1694050912; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZMsBVpFiu1Z4UaDRIFNz7s2Kpc2XSOUelNDvoY2C6A=;
        b=KOYo587OMr7ssA2bUJ/yQTStHWlZs5rH5SluDhRhhOJWhhEaGJR5KTUtE94JnXK/pf
         Kt9fnP9tGTAWpq2HOTVbc36z2q1t/E1SoG/x+oSCpyB+7RWd7iGiCI3nkXg398cIU/qf
         uh9gAj25hpvhZb9izgqXT9AzAjs+001H7OjgOv5KkCcmd8OVX4aSWzw9iKUOGZhG9DTb
         F1eR9CUdVZDClsAeYKfweA3/FQnVfosLpMBe/QyXPjHJ5dxGQ5GhqbMh5AZBhZH3jutu
         k5kQfizrG8ggCnDBEnL6HbCbPMfPrri/L5qSrlek3uXgI5LKmJw5XoamnQ8cQuSRoRi5
         q89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693446112; x=1694050912;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZMsBVpFiu1Z4UaDRIFNz7s2Kpc2XSOUelNDvoY2C6A=;
        b=Q6fyfqmC4HCnVnpsTxn01oxnHArW6S7TyKzHrQHO0Kel0InmW9/1d1cJ7CM7iG2gZt
         xDoAquVCZNFAwwNYiXNKEIyqj6xRID6qWf1DlXyxHQj4NoAyzJ8/kxgvcqNQBc4nlZuj
         GrSK2434+Wz1Gx19B/vXBCUElBMRWuv3menjjZnVkx7TDLLoVllk4GPGIfXMSv16SpCQ
         U65y9ZC3JY8T0/pohbhusQtYBU2Ek/+pR3/dihikiTktk9j6kMBXvv/jaOVNQL8H3o5I
         j0m611iSBoLBPsRGbbaygnL+nBK6aPK2JuP+d7pRRQ0WkADQIIBhWM3OdJ3DzpLT57FU
         +Ygg==
X-Gm-Message-State: AOJu0Yxtw0J15uDkWBOW0L7TaKI3eVt6aWqZYzggSJrbK/tAbVSLnIJR
	yE2i89GD9P7Olyr0zjXkXcw=
X-Google-Smtp-Source: AGHT+IFlIgcPiIF/FfcAb2+ilmTP0nB4gX4AuRwYLXuHMmDEnycgmV+LpReIhO1i8TXBveVn5m9U2w==
X-Received: by 2002:a4a:6f16:0:b0:56c:7120:835f with SMTP id h22-20020a4a6f16000000b0056c7120835fmr3799095ooc.5.1693446112538;
        Wed, 30 Aug 2023 18:41:52 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x44-20020a4a97ef000000b00569c5eadf15sm188923ooi.26.2023.08.30.18.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 18:41:51 -0700 (PDT)
Message-ID: <93e5c862-dd6f-3658-3f72-3f98918b022e@gmail.com>
Date: Wed, 30 Aug 2023 20:41:51 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] auto-t: require a complete hostapd default config
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230829143955.267742-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230829143955.267742-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/29/23 09:39, James Prestwood wrote:
> In many tests the hostapd configuration does not include all the
> values that a test uses. Its expected that each individual test
> will add the values required. In many cases its required each test
> slightly alter the configuration for each change every other test
> has to set the value back to either a default or its own setting.
> This results in a ton of duplicated code mainly setting things
> back to defaults.
> 
> To help with this problem the hostapd configuration is read in
> initially and stored as the default. Tests can then simply call
> .default() to set everything back. This significantly reduces or
> completely removes a ton of set_value() calls.
> 
> This does require that each hostapd configuration file includes all
> values any of the subtests will set, which is a small price for the
> convenience.
> ---
>   autotests/util/hostapd.py | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
> 

Both applied, thanks.

Regards,
-Denis

