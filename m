Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342082F45
	for <iwd@lists.linux.dev>; Mon, 13 Mar 2023 16:56:13 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id p20so13632576plw.13
        for <iwd@lists.linux.dev>; Mon, 13 Mar 2023 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678726572;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9E30T6h3Zc93hwRUC4dhm0VPrTWZgg7cPC2dxvZh43g=;
        b=phuRBYqNOSCACD+mK9B/4m7ScBUXJ8OuD7n+IYcNLTj+jqdtwctb3Fx3UcGnfVXjDW
         XzmVKSSlsCVqDqnL2oyS8gk2KemviTYsloSdjsd8/CTEbW/24ukyqKWrELSARFnqrHcS
         +8CMf1yJKBrrV1LXFVUsLQJlRIM/7HqxdTGBD8qqOSAbJ9vKm32epNf8g4E2hEHQ8HDO
         av2GbFuUVAZ775+L7mOfR/oPnQDolp+03EEX2q2/lpFmJUhKS7guoATMs9UMh/I8Tpbr
         R0OUad7KfWKJfOgcCAhbuP6LVCLSpOq4EW3Rx5oArZcnJ/DGYB63a45OAOW1zDSFuqse
         XWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678726572;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9E30T6h3Zc93hwRUC4dhm0VPrTWZgg7cPC2dxvZh43g=;
        b=5e3kdH0c/kw8HcR21V0h7jAC+Z7D2hCeJT4Q3xUtv9j7JmkBgM9A+kyfUUwIPzplfL
         oC0LLwavlGygL/qPZb2Emj+0eXzMiDGHg2b6Gn6uO7pRAlrT9Mm+kActs2Pg93U0y5Bi
         29JFuCMPKuxeNeuQF/witDpyvolRGvtSMrvMvoIZ8UzXC+sKfFwZIYzbUH0otvCvt1AB
         aXgFTxyaODZgqE6pxZ9AjEjqAf+Sh+XinWhhqLNsSkJc3vk6Jcp0QZ7qjMQOsQ9AuTp+
         LFMg7RmtmDCcH2JTklBrx071ofvk9/eRXsfp4KhrtmucNkrdcoFXi//jqfNFaRr4ab9z
         v8+w==
X-Gm-Message-State: AO0yUKVka6EBxgPGGnvE5aOV7QZXpyCCREdkRFzlCd61LUs45Uwse5JT
	fLHMskLDwPjrY/YVMU+llGSPHDvVoV8=
X-Google-Smtp-Source: AK7set9kt+GVROJU5AAbxaTtdhmvmfMz+dEhb7hHn56hDckryNiQV46WxlbhQDMFJk79MW8cR1cJ6w==
X-Received: by 2002:a17:903:22cb:b0:1a0:6139:e9d6 with SMTP id y11-20020a17090322cb00b001a06139e9d6mr823667plg.53.1678726572547;
        Mon, 13 Mar 2023 09:56:12 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id z12-20020a630a4c000000b00478c48cf73csm4814996pgk.82.2023.03.13.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:56:12 -0700 (PDT)
Message-ID: <e9d64559432a759066a00fa1d4bd753c517f8cd4.camel@gmail.com>
Subject: Re: 40MHz Bandwidth in AP mode
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, Alagu Sankar <alagusankar@gmail.com>,
  iwd@lists.linux.dev
Date: Mon, 13 Mar 2023 09:56:11 -0700
In-Reply-To: <00c6a4a6-425d-aede-1e09-b85a56df081a@gmail.com>
References: 
	<CAH4auOnuK_dDemZRF4BMq3LPL6A5cmLfSgJKeFVKAYZUNGAk2w@mail.gmail.com>
	 <CAH4auOnsUMnrBbfCPOh=vyvk2DnESz1YtDdpcD9fe_vzw3vbFg@mail.gmail.com>
	 <00c6a4a6-425d-aede-1e09-b85a56df081a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2023-03-13 at 10:29 -0500, Denis Kenzior wrote:
> Hi Alagu,
> 
> On 3/13/23 05:07, Alagu Sankar wrote:
> > Hi,
> > 
> > We are testing the iwd-2.3 version in AP mode for one of our
> > requirements.  When trying to configure the AP mode in Channel 36, it
> > was always selecting 20MHz.  The band_freq_to_ht_chandef() function
> > is
> > supposed to select the best bandwidth. As we see, channel 36 is
> > configured as 40Mhz capable (operating_class 116).  Debugging this
> > further, we see that 40MHz spacing is rejected due to the following
> > condition
> > if (info->flags & PRIMARY_CHANNEL_UPPER && attr->no_ht40_plus)
> >      continue;
> > if (info->flags & PRIMARY_CHANNEL_LOWER && attr->no_ht40_minus)
> >      continue;
> > Channel 36 is configured as PRIMARY_CHANNEL_LOWER and the NL80211
> > attribute is indicating no_ht40_minus for this, but as per the
> 
> So if NL80211 reports no_ht40_minus, we can't use this channel for
> 40HT:
> 
> * @NL80211_FREQUENCY_ATTR_NO_HT40_MINUS: HT40- isn't possible with this
>   *      channel as the control channel
> 
> > condition above, this is skipped. The check above seems incorrect.
> 
> Why do you say that?
> 
> Is the currently set regdom somehow restricting HT40 operation?  Does
> setting 
> the regdom country help?  Perhaps via [General].Country?  See man 5
> iwd.config.
> 
> > Can you please let me know if 40MHz bandwidth is tested on AP mode?
> > 
> 
> Yes, but things can always be tested better.  Our AP support is still
> quite 
> experimental.

Yes, AP mode certainly could use more testing but the adapters I have
tested on have worked with 40MHz. 

As Denis said just because the operating class allows 40Mhz doesn't
mean your wifi hardware or country allow that operation.

To tell 100% in your case you'd need to get an iwmon log of IWD
starting up. This will get a full log of any channel restrictions, more
info here: https://iwd.wiki.kernel.org/debugging

Thanks,
James

> 
> Regards,
> -Denis
> 


