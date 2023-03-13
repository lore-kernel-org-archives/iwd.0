Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9B28F2
	for <iwd@lists.linux.dev>; Mon, 13 Mar 2023 15:29:15 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id bg11so9696902oib.5
        for <iwd@lists.linux.dev>; Mon, 13 Mar 2023 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678721354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3DFNyVcKBG0SwNwh8Shz/fOmriu7sCjsLbRMVl4c1P4=;
        b=Bj1Fz8qRRdlkH5K/NtM2gD4Ai16XACJbbwXnICzw/urxBQj7LX4QQHabJCx/qRVW5v
         fGtDGhIgr0BMUBh9kIwjLUVmSpNg2Y5yb4BNsPIM1cjJWtHO/6Iz9LHWj2xN/jKOv3Bb
         dNuvVMChWuECa+4t2rRD7B5OKdmnxgN0rFS2FaJv1BVAOav6pE1qLoUhGRMX8gNDUi2X
         f90v35CbvtbBrK4Uj7sh72tGND1z4/t7xhfIEmm0YW2At2JEJ7KS7PBpwvhCVrs6B5Mg
         oenJN+HoUf8qX+M0LpfjoMZ6N2cNbQQuyVKFLIWuN+9V5QzwUIamofbi0Pf3UXMnhkQ3
         K8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DFNyVcKBG0SwNwh8Shz/fOmriu7sCjsLbRMVl4c1P4=;
        b=EFKgbAvP7RZL1DjZSMuVfJyCwINx0c0vV3XhjTuqAAL/jyZC3MnjCimQ+DoftpHFMv
         LK36m/vnnSWjcNHG+lfzlI6p5xbToR4tgyDybfIhgltWmmsny5fjxLeZ/SFJxelWd9th
         qL4Ufk2ZY1giaS33U03QnZMiMWvck+dha5ZJT49OV8OIgkBb5K9ffl8iTjRYQV1hRLRV
         4Nzmp9sE65JYVO0YxScl9cztmLE8KViuDunQ9L7E7hwKrzwTKKNwur9s9ubyrFoobzv0
         t058yxzp4bvvFWj23d3AS7lxLZDMOGvsfKCtoDfRrAA8TV2+FEiIZUWNYk5Tvl+HZB9o
         toWQ==
X-Gm-Message-State: AO0yUKUkqefUSnfSNG5eL7AqYwLofa6GRACw2oDz9XkOiiUvKcb2lOYc
	CJZQqtFPC1DG9C9bDDFAdcA=
X-Google-Smtp-Source: AK7set+9S3Ln5VwDIfKtJJOqajv5adXp8ZK+WRnUEE0PK6sJP7L+mAl8TiCyMPVm+PZnVqZHyFs+LQ==
X-Received: by 2002:a54:4718:0:b0:35c:4ddb:b879 with SMTP id k24-20020a544718000000b0035c4ddbb879mr15928339oik.11.1678721354358;
        Mon, 13 Mar 2023 08:29:14 -0700 (PDT)
Received: from [192.168.1.10] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ex25-20020a056808299900b0038440f0f63dsm3208888oib.37.2023.03.13.08.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 08:29:13 -0700 (PDT)
Message-ID: <00c6a4a6-425d-aede-1e09-b85a56df081a@gmail.com>
Date: Mon, 13 Mar 2023 10:29:11 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: 40MHz Bandwidth in AP mode
To: Alagu Sankar <alagusankar@gmail.com>, iwd@lists.linux.dev
References: <CAH4auOnuK_dDemZRF4BMq3LPL6A5cmLfSgJKeFVKAYZUNGAk2w@mail.gmail.com>
 <CAH4auOnsUMnrBbfCPOh=vyvk2DnESz1YtDdpcD9fe_vzw3vbFg@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAH4auOnsUMnrBbfCPOh=vyvk2DnESz1YtDdpcD9fe_vzw3vbFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alagu,

On 3/13/23 05:07, Alagu Sankar wrote:
> Hi,
> 
> We are testing the iwd-2.3 version in AP mode for one of our
> requirements.  When trying to configure the AP mode in Channel 36, it
> was always selecting 20MHz.  The band_freq_to_ht_chandef() function is
> supposed to select the best bandwidth. As we see, channel 36 is
> configured as 40Mhz capable (operating_class 116).  Debugging this
> further, we see that 40MHz spacing is rejected due to the following
> condition
> if (info->flags & PRIMARY_CHANNEL_UPPER && attr->no_ht40_plus)
>      continue;
> if (info->flags & PRIMARY_CHANNEL_LOWER && attr->no_ht40_minus)
>      continue;
> Channel 36 is configured as PRIMARY_CHANNEL_LOWER and the NL80211
> attribute is indicating no_ht40_minus for this, but as per the

So if NL80211 reports no_ht40_minus, we can't use this channel for 40HT:

* @NL80211_FREQUENCY_ATTR_NO_HT40_MINUS: HT40- isn't possible with this
  *      channel as the control channel

> condition above, this is skipped. The check above seems incorrect.

Why do you say that?

Is the currently set regdom somehow restricting HT40 operation?  Does setting 
the regdom country help?  Perhaps via [General].Country?  See man 5 iwd.config.

> Can you please let me know if 40MHz bandwidth is tested on AP mode?
> 

Yes, but things can always be tested better.  Our AP support is still quite 
experimental.

Regards,
-Denis
