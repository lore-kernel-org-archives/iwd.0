Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558A8F69
	for <iwd@lists.linux.dev>; Tue, 14 Mar 2023 15:25:00 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id a9so16948898plh.11
        for <iwd@lists.linux.dev>; Tue, 14 Mar 2023 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678807500;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lL0qfJgbDlV7EEEgFezASpwRh52+/lT4pm+rY7TFpK8=;
        b=YTa3To5/3H7Dtx6dO9iLXC1Ebv6f2+Z1tUl6iR21+wJl4oJpmCwvaTk5f6G6XCsrOT
         VDCNXDiy69KxTQCX64w95HKyVaEcY4uzjQgAybuHX04QHCRgUTy95k226M1NAsza5NsT
         Alhgi2YSME1dx0YFJVE1Y8FuLRVkUC7OVS/UPdZT7oC3eILl6wuZY3mo7hFdzNCfSNMU
         qWhN0gM8IbLVirpDo9uppoeuXb8KXoM3qagRokiRMCkbWQ/w9hJaO+P943GrXGVYNV9L
         x8oeC9BqHXOnRs9G4+Ztt+BzmgCoOJA8g1SU+l7m0tX1nRuuEe0JIpn+CBv0KdhvP1UP
         h3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807500;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lL0qfJgbDlV7EEEgFezASpwRh52+/lT4pm+rY7TFpK8=;
        b=tYVtEWac3rUhhI4WoZCwzq96uJBH31r9LSl5D9bMKpnEGk+ckWUXGjxVGg+CJU0OcU
         UfyYwh1SDrz7d3TXZKiSlrNIDj9Hro+YlsFzgKqD1VH7Slt6Ua+YFgB1MXYcTzspZMYa
         T5LKJiNeB98UFDF+X+tBx0YwXhGjt/Rx223UuxWyFb9S9+pkH7ITDcFGQsbxUZPnkxgd
         xLTeINvUlo0c4Kdkv5Mj1U7VDmxrUfS7rUiCzKPlaeNHkUyK3/6pqQeuCGOoz87uiSvK
         zg/l03uw/6OLPuKQ5Xmtr8YiQdw6W+Z6B5GmQJ6WPazO5GCLDjvyGWAKH74iclesoI/J
         HQhg==
X-Gm-Message-State: AO0yUKXSn3YyzBLKodLjav7LYh0PxCR8qq40U5k/45B1xSyMhwo7raFY
	u02G6K06QsI8i2S5x6HuR1UWfM4r1Bc=
X-Google-Smtp-Source: AK7set+wty6YrUG5VG3p9FUTVa0nImL4eOmu5w8hnB6HJrseqq8uXlknz2MZKmx88afwKham2HjkZw==
X-Received: by 2002:a17:902:f548:b0:19c:947c:8819 with SMTP id h8-20020a170902f54800b0019c947c8819mr49847085plf.59.1678807500002;
        Tue, 14 Mar 2023 08:25:00 -0700 (PDT)
Received: from [192.168.254.16] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id ka8-20020a170903334800b0019c61616f82sm1899872plb.230.2023.03.14.08.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:24:59 -0700 (PDT)
Message-ID: <a69685007780471055e92c53b6c9d02d943c57e2.camel@gmail.com>
Subject: Re: 40MHz Bandwidth in AP mode
From: James Prestwood <prestwoj@gmail.com>
To: Alagu Sankar <alagusankar@gmail.com>, Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Date: Tue, 14 Mar 2023 08:24:59 -0700
In-Reply-To: <CAH4auOmWRehs8xcBeCZj-3sUc7dFS4ZHLsAJ=guH1Y0KRwOwWg@mail.gmail.com>
References: 
	<CAH4auOnuK_dDemZRF4BMq3LPL6A5cmLfSgJKeFVKAYZUNGAk2w@mail.gmail.com>
	 <CAH4auOnsUMnrBbfCPOh=vyvk2DnESz1YtDdpcD9fe_vzw3vbFg@mail.gmail.com>
	 <00c6a4a6-425d-aede-1e09-b85a56df081a@gmail.com>
	 <CAH4auOmWRehs8xcBeCZj-3sUc7dFS4ZHLsAJ=guH1Y0KRwOwWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alagu,

On Tue, 2023-03-14 at 11:44 +0530, Alagu Sankar wrote:
> Hi Denis,
> 
> On Mon, Mar 13, 2023 at 8:59 PM Denis Kenzior <denkenz@gmail.com>
> wrote:
> > 
> > Hi Alagu,
> > 
> > On 3/13/23 05:07, Alagu Sankar wrote:
> > > Hi,
> > > 
> > > We are testing the iwd-2.3 version in AP mode for one of our
> > > requirements.  When trying to configure the AP mode in Channel 36,
> > > it
> > > was always selecting 20MHz.  The band_freq_to_ht_chandef() function
> > > is
> > > supposed to select the best bandwidth. As we see, channel 36 is
> > > configured as 40Mhz capable (operating_class 116).  Debugging this
> > > further, we see that 40MHz spacing is rejected due to the following
> > > condition
> > > if (info->flags & PRIMARY_CHANNEL_UPPER && attr->no_ht40_plus)
> > >      continue;
> > > if (info->flags & PRIMARY_CHANNEL_LOWER && attr->no_ht40_minus)
> > >      continue;
> > > Channel 36 is configured as PRIMARY_CHANNEL_LOWER and the NL80211
> > > attribute is indicating no_ht40_minus for this, but as per the
> > 
> > So if NL80211 reports no_ht40_minus, we can't use this channel for
> > 40HT:
> > 
> > * @NL80211_FREQUENCY_ATTR_NO_HT40_MINUS: HT40- isn't possible with
> > this
> >   *      channel as the control channel
> > 
> > > condition above, this is skipped. The check above seems incorrect.
> > 
> > Why do you say that?
> For a Channel with PRIMARY_CHANNEL_LOWER flag, if it supports HT40+,
> then we are allowed to use 40MHz bandwidth. (Ex. Channel 36 and
> HT40+). In other words for PRIMARY_CHANNEL_LOWER, if no_ht40_plus flag
> is set, then we skip the channel for 40Mhz. When we used IWD with a
> Qualcomm 11AX driver, for Channel 36, no_ht40_minus is set to 1 and
> no_ht40_plus is set to 0. So the check shall be
> if (info->flags & PRIMARY_CHANNEL_UPPER && attr->no_ht40_minus)
>     continue;
> if (info->flags & PRIMARY_CHANNEL_LOWER && attr->no_ht40_plus)
>     continue;

I think you may be on to something actually. I apparently misunderstood
the terminology of HT40+/HT40-. The spec doesn't use these terms, but
nl80211 does:

 * @NL80211_CHAN_HT40MINUS: HT40 channel, secondary channel
 *	below the control channel
 * @NL80211_CHAN_HT40PLUS: HT40 channel, secondary channel
 *	above the control channel

Specifically for operating class 116 we have the PRIMARY_CHANNEL_LOWER
behavior limit, which indeed means this is HT40+. Good catch!

So far all the hardware I tested never set any of these flags. For
HT/40MHz channel widths you are implicitly limited anyways since the
operating classes define the upper/lower behavior.

Since you found the bug and already have a fix you could send that to
the list? If not I'm happy to do it as well.

Thanks,
James



> > Is the currently set regdom somehow restricting HT40 operation?  Does
> > setting
> > the regdom country help?  Perhaps via [General].Country?  See man 5
> > iwd.config.
> > 
> Regulatory is managed by the driver and set to US in our test.  Could
> verify the channel and bandwidth availability through iw list command.
> > > Can you please let me know if 40MHz bandwidth is tested on AP mode?
> > > 
> > 
> > Yes, but things can always be tested better.  Our AP support is still
> > quite
> > experimental.
> > 
> > Regards,
> > -Denis
> 
> Best Regards,
> Alagu Sankar
> 


