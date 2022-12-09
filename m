Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D033214
	for <iwd@lists.linux.dev>; Fri,  9 Dec 2022 21:00:25 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-144bd860fdbso1246588fac.0
        for <iwd@lists.linux.dev>; Fri, 09 Dec 2022 13:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMI1AzAO+itkC9HukgnHA4oY+nEpoiZ5BuyAO09+7vo=;
        b=iRsB6z0TkR4qtpp0ah8P3Urtt8gWfBjCptJLOMJxSOKAzEx0suG2wgok7gMP1JttTC
         tbjy0HeSUxBTyJXjUC3c/XzdYL7rWK9TaccvLdvINvP9NB/bhjwlcWWoozu4/zM9AC1Z
         QqM3rnITD+70/Xy+3eZMTglE7efXAkKkmagOWx3aRSaPeOgu5YVLTfge5cpbr2EU5pxz
         L2WZMD0IDVFS9YvPnm24ildqZ4HfiR082Svh2J943HyFBQzD+fcgLzjFxFIkGFCqBZO8
         t6MYfPHdZFHdgs73VCyOVhK62qNggK9IX4e/drCk93MhsaT3IJrZ85Wuk9Vkm1vj8gZR
         SDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMI1AzAO+itkC9HukgnHA4oY+nEpoiZ5BuyAO09+7vo=;
        b=RY3Wrl66ZzVI0N75VqDlR5Y3WnPDRCwsOefVVKwBj8vcdK5BHjOs2P/BArNypmhAmL
         gUOebymSTlpyKx9iNpXa3fOvjElKKv9KM8twJilmI3IBP6uyHD7Ko4xI3yQ+yKrdYbEk
         DdEWv+OiuNzcvPMSBsOEv22GecQcg7v8BYteGyyMoDLQ0Uusc00iSU6yI7TklXpsWvPw
         zitc7JZw0or6BddD2TmJEOwvf1G9fNtwcdfstC3Dt0M//mLVEE+R7myYQa+hF5i+s20I
         x8vDMYMkcRXHwcM2GIpCydRCpG+H5Hknt11M6ejU4HtLKJJHhPhN7vQ3hnpxLSPvFh/K
         Wleg==
X-Gm-Message-State: ANoB5pnxlClXVjJ3cx/SrijgCPCxoNqxu/+Y//UYNyEojgFkl5pVp4An
	h3+YwB+whk16dFxoCbhbxi5SIfuGGys=
X-Google-Smtp-Source: AA0mqf4qwp3xbzAnZq51HnRrVtICER2NvqPPvAvfMs9XLXaFQ8QPiPQAP2a72LfxfjzL83T7TAN4ZA==
X-Received: by 2002:a05:6870:f216:b0:143:a049:19c8 with SMTP id t22-20020a056870f21600b00143a04919c8mr3775640oao.37.1670619624505;
        Fri, 09 Dec 2022 13:00:24 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id i15-20020aca2b0f000000b00359ba124b07sm865520oik.36.2022.12.09.13.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 13:00:23 -0800 (PST)
Message-ID: <029df79a-40b8-a994-7961-6f0de41dfb52@gmail.com>
Date: Fri, 9 Dec 2022 15:00:19 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/4] wiphy: use enum band_freq with rates getter
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221209193930.845238-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221209193930.845238-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/9/22 13:39, James Prestwood wrote:
> wiphy_get_supported_rates expected an enum defined in the nl80211
> header but the argument type was an unsigned int, not exactly
> intuitive to anyone using the API. Since the nl80211 enum value
> was only used in a switch statement it could just as well be IWD's
> internal enum band_freq.
> 
> This also allows modules which do not reference nl80211.h to use
> wiphy_get_supported_rates().
> ---
>   src/scan.c  | 2 +-
>   src/wiphy.c | 9 +++++----
>   src/wiphy.h | 4 +++-
>   3 files changed, 9 insertions(+), 6 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

