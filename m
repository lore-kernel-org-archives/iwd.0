Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DC23A0
	for <iwd@lists.linux.dev>; Tue, 14 Mar 2023 06:14:45 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id ek18so26447037edb.6
        for <iwd@lists.linux.dev>; Mon, 13 Mar 2023 23:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678774484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXTvADP+3qSZDz+C73Kn07yjS6Caejm0cMb57r7IWjM=;
        b=flRQ1HevP1HRAu94/lDC3gs/Fzn4adv771fNPLbr11e8TAPspITjt1cNP7c8MWGA9o
         XvZRR+jjM5KchwWiuhd5uRV/ngHfBW3jbRgLYTqniYtqUJBLdx8bs1Ds9ghv70cy3HlN
         hKgRMkk0ohQTVBQNmawZyLQDec1Oova01r8aiiURsuBkPL09+8FSPYJHVSl2H3TY3vC7
         DKv428IrtpWbl/rhzl7T1ovsAGBYnlwdXbfZYEow6cEPON+wffjSaRiQs2fZfV9aXwqB
         u5xa2QFvMIKXIa5dHjwbsqV4wOa7gcsLExFPmD7QnChVHYVmFiR9NHLOt2REQDvSMSBI
         tLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678774484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXTvADP+3qSZDz+C73Kn07yjS6Caejm0cMb57r7IWjM=;
        b=gFCirdDANejYVa0rqP0rDA7oBIRo8UXF6s/rREWE82U6jwS9IpXMhgYPpFca7t0aA3
         youoJ1NArHoFWQ31bCMv3vgFs83J4vH+EFaJyTQZOG7yq8r851XvqwElTVdTcnnNtAv/
         OyeaURKt5iEHlUoNmu9m0bqLZ4+Ccv8d8IVhEXDH+Cr7WOEZ3eyKew8Z/FstgIwAR4Ck
         FuQ1mYeXUMc1FRmPUdS0pjSqr91C0l3eSehK1qlimAg5xTCOR6GG/aCeVOHxu7uDpn4j
         H79Skna/9QgiLWJmG/7TTadCGMZyxmykhmvG+hf9c2cCOwoR7OMRAwmv2ayG0Hx2/vic
         k9ww==
X-Gm-Message-State: AO0yUKU0wAfkpq+47GHU9NsHiJjzYik84XTIDaE8A6vyNgYdsaHqR5Lf
	fxhM9oNk0JBDZlUt7MJCHCsFndI/Eb+baH+Gn+I=
X-Google-Smtp-Source: AK7set+zaBBURSPlNVDHFLkbbM4aBTadwuG4fAmWoZZIU0Astg6Sut4/J4aKJdonBBHqa2xkklDAF2Blh5XdTj4waOA=
X-Received: by 2002:a17:906:d96a:b0:8bf:e82a:2988 with SMTP id
 rp10-20020a170906d96a00b008bfe82a2988mr612310ejb.4.1678774483737; Mon, 13 Mar
 2023 23:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH4auOnuK_dDemZRF4BMq3LPL6A5cmLfSgJKeFVKAYZUNGAk2w@mail.gmail.com>
 <CAH4auOnsUMnrBbfCPOh=vyvk2DnESz1YtDdpcD9fe_vzw3vbFg@mail.gmail.com> <00c6a4a6-425d-aede-1e09-b85a56df081a@gmail.com>
In-Reply-To: <00c6a4a6-425d-aede-1e09-b85a56df081a@gmail.com>
From: Alagu Sankar <alagusankar@gmail.com>
Date: Tue, 14 Mar 2023 11:44:32 +0530
Message-ID: <CAH4auOmWRehs8xcBeCZj-3sUc7dFS4ZHLsAJ=guH1Y0KRwOwWg@mail.gmail.com>
Subject: Re: 40MHz Bandwidth in AP mode
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, Mar 13, 2023 at 8:59=E2=80=AFPM Denis Kenzior <denkenz@gmail.com> w=
rote:
>
> Hi Alagu,
>
> On 3/13/23 05:07, Alagu Sankar wrote:
> > Hi,
> >
> > We are testing the iwd-2.3 version in AP mode for one of our
> > requirements.  When trying to configure the AP mode in Channel 36, it
> > was always selecting 20MHz.  The band_freq_to_ht_chandef() function is
> > supposed to select the best bandwidth. As we see, channel 36 is
> > configured as 40Mhz capable (operating_class 116).  Debugging this
> > further, we see that 40MHz spacing is rejected due to the following
> > condition
> > if (info->flags & PRIMARY_CHANNEL_UPPER && attr->no_ht40_plus)
> >      continue;
> > if (info->flags & PRIMARY_CHANNEL_LOWER && attr->no_ht40_minus)
> >      continue;
> > Channel 36 is configured as PRIMARY_CHANNEL_LOWER and the NL80211
> > attribute is indicating no_ht40_minus for this, but as per the
>
> So if NL80211 reports no_ht40_minus, we can't use this channel for 40HT:
>
> * @NL80211_FREQUENCY_ATTR_NO_HT40_MINUS: HT40- isn't possible with this
>   *      channel as the control channel
>
> > condition above, this is skipped. The check above seems incorrect.
>
> Why do you say that?
For a Channel with PRIMARY_CHANNEL_LOWER flag, if it supports HT40+,
then we are allowed to use 40MHz bandwidth. (Ex. Channel 36 and
HT40+). In other words for PRIMARY_CHANNEL_LOWER, if no_ht40_plus flag
is set, then we skip the channel for 40Mhz. When we used IWD with a
Qualcomm 11AX driver, for Channel 36, no_ht40_minus is set to 1 and
no_ht40_plus is set to 0. So the check shall be
if (info->flags & PRIMARY_CHANNEL_UPPER && attr->no_ht40_minus)
    continue;
if (info->flags & PRIMARY_CHANNEL_LOWER && attr->no_ht40_plus)
    continue;
> Is the currently set regdom somehow restricting HT40 operation?  Does set=
ting
> the regdom country help?  Perhaps via [General].Country?  See man 5 iwd.c=
onfig.
>
Regulatory is managed by the driver and set to US in our test.  Could
verify the channel and bandwidth availability through iw list command.
> > Can you please let me know if 40MHz bandwidth is tested on AP mode?
> >
>
> Yes, but things can always be tested better.  Our AP support is still qui=
te
> experimental.
>
> Regards,
> -Denis

Best Regards,
Alagu Sankar
