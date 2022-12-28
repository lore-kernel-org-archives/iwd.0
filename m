Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73C6D24
	for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 19:50:46 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id 78so11120665pgb.8
        for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 11:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0DN7Hnu66/BCzZ1PTjDZjO3ME9HIszXWmrXZoXK2io=;
        b=iWHuyVOC3qvuT11m9UvLq7yxfqDmSyIBZquw9cmruWgJmogH73On98nEA82aUMWtwJ
         PDT+bYdMejAx0XWaQWqkq6+Pf6TNpCZq8F5+8oAzpSYxraJgIukL02Eev2cz0bPpFgPy
         FKAfWtXvNXxTfXSkxMov7Ik0jEIZheprPId6vp4xR+OIPfT0GDqrJpz3oOglt0kXH6cA
         hAtuv3YJHkH9r4DH7P1hM/6idcmJRvK1B7O0Jeqt0W53X/F1jNwi/aEWoeLxOUS3dGVf
         Fp6MWS30i6wQNtqTB0+9wyDkVpvvP+wT6sYey5jZki0Y9BVoDmmyicXkUhhaMXDKrOGp
         YnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0DN7Hnu66/BCzZ1PTjDZjO3ME9HIszXWmrXZoXK2io=;
        b=DbXt8XCyEDTddGtD0eIeVnnen4hp/RnjOWKE9kxyMsP1DRyVnZ2Tb/kDtkcNfBpUuq
         gAxgnNUiSbdRJRx1r6XI3HMsks8M1Ddrn/QbzM+0nI1PpvuxDBWNVX6B5y0wcyil2or8
         5y7UTOb8OC303Vc+plV/o1vFFMsAmRLMBmD9g4Eklj5QLV/29/pmwAfWGHlMV77VZ9Pr
         Brjcogl29iNR4Kl7ZQz+sEuDLefjQAcGa4zrSBn/4TbM3dX5cAuj1EmFVEEQhpGzbYNQ
         pYWUkcI2QXpgnUp1fsNU0hEJVVVyTf/43jQp3laH0xHSsUCrtLPULJ/iSpvff+Fk0XG1
         IEjw==
X-Gm-Message-State: AFqh2kpAuvKy906aaiGdvBxAkeSjB6o7+cn9wPlTqzYPld6E/uG3RkNG
	8yjiZdwqZQ3AY+I4Ui/oL2lddSvehNY=
X-Google-Smtp-Source: AMrXdXvQg3yjSkgnL35a/C9nJ1ElwsN0MwQoMP95FaG9sdRDQHQH3M0bLrpG4bwWmBYLXZqV4Xwkew==
X-Received: by 2002:a05:6a00:3491:b0:581:5017:f960 with SMTP id cp17-20020a056a00349100b005815017f960mr8911921pfb.29.1672257045504;
        Wed, 28 Dec 2022 11:50:45 -0800 (PST)
Received: from [192.168.254.20] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z1-20020a626501000000b00573eb4a9a66sm10653884pfb.2.2022.12.28.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 11:50:45 -0800 (PST)
Message-ID: <ca84d3ce71bf2f17360f63303bbca1b841eb36cc.camel@gmail.com>
Subject: Re: [PATCH 05/10] band: add APIs to generate a chandef from
 frequency
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Date: Wed, 28 Dec 2022 11:50:44 -0800
In-Reply-To: <f1d0679d-a6df-f274-5c95-909a9a3ed383@gmail.com>
References: <20221220214318.2041986-1-prestwoj@gmail.com>
	 <20221220214318.2041986-5-prestwoj@gmail.com>
	 <f1d0679d-a6df-f274-5c95-909a9a3ed383@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2022-12-27 at 12:07 -0600, Denis Kenzior wrote:
> Hi James,
> 
> On 12/20/22 15:43, James Prestwood wrote:
> > For AP mode its convenient for IWD to choose an appropriate
> > channel definition rather than require the user provide very
> > low level parameters such as channel width, center1 frequency
> > etc. This adds two new APIs to generate a channel definition, one
> > for legacy and one for HT.
> > 
> > The legacy API is very simple and chooses the first matching
> > operating class using 20Mhz channel widths.
> > 
> > The HT API is a bit more complex since it has to take into account
> > 40MHz and check any channel restrictions. If an operating class is
> > found that is supported/not restricted it is marked as 'best' until
> > a better one is found. In this case 'better' is a larger channel
> > width. Since this is HT only 20mhz and 40mhz widths are checked.
> 
> I wonder if the HT one can be implemented using the noHT one?
> 
> > ---
> >   src/band.c | 159
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   src/band.h |   4 ++
> >   2 files changed, 163 insertions(+)
> > 
> > diff --git a/src/band.c b/src/band.c
> > index d89b2a90..b1e319d7 100644
> > --- a/src/band.c
> > +++ b/src/band.c
> > @@ -1194,6 +1194,165 @@ int oci_from_chandef(const struct
> > band_chandef *own, uint8_t oci[static 3])
> >         return -ENOENT;
> >   }
> >   
> > +static bool freq_in_oper_class(uint32_t freq,
> > +                               const struct operating_class_info
> > *info,
> > +                               enum band_freq *out_band)
> > +{
> > +       uint8_t channel;
> > +       enum band_freq band;
> > +
> > +       channel = band_freq_to_channel(freq, &band);
> > +       if (!channel)
> > +               return false;
> 
> You already call band_freq_to_channel right at the top of
> band_freq_to_chandef 
> (but not band_freq_to_ht_chandef?).  Not really a big deal, but why
> continue 
> calling it inside this function which is being called in a loop?  You
> already 
> know the channel and the band...
> 
> > +
> > +       switch (band) {
> > +       case BAND_FREQ_2_4_GHZ:
> > +               if (info->starting_frequency > 5000)
> > +                       return false;
> > +               break;
> > +       case BAND_FREQ_5_GHZ:
> > +               if (info->starting_frequency < 5000 ||
> > +                               info->starting_frequency > 5950)
> > +                       return false;
> > +               break;
> > +       case BAND_FREQ_6_GHZ:
> > +               if (info->starting_frequency < 5900)
> > +                       return false;
> > +               break;
> > +       }
> 
> So you don't trust band_freq_to_channel?
> 
> Also, I'd really like to isolate 'magic frequency numbers' use as
> much as 
> possible.  Ideally contain this in band_freq_to_channel and
> band_channel_to_freq 
> only.  And even then maybe we should look into whether we can rework 
> band_channel_to_freq to use the e4 table.

Yeah this was dumb, I removed this completely and just use
e4_has_frequency() in the loop for both functions.

> 
> If there's a chance that band_freq_to_channel can produce a
> channel/band 
> combination that isn't in e4, then perhaps we should simply add a
> 'band' member 
> to 'struct operating_class_info'.  That way this could be sanity
> checked directly.
> 
> > +
> > +       if (e4_channel_to_frequency(info, channel) < 0)
> > +               return false;
> > +
> > +       if (out_band)
> > +               *out_band = band;
> > +
> > +       return true;
> > +}
> > +
> > +/* Find a legacy chandef for the frequency */
> > +int band_freq_to_chandef(uint32_t freq, const struct
> > band_freq_attrs *attr,
> > +                               struct band_chandef *chandef)
> > +{
> > +       enum band_freq band;
> > +       uint8_t channel;
> > +       unsigned int i;
> > +       const struct operating_class_info *best = NULL;
> > +
> > +       channel = band_freq_to_channel(freq, &band);
> > +       if (!channel)
> > +               return -EINVAL;
> > +
> > +       if (attr->disabled || !attr->supported)
> > +               return -EINVAL;
> > +
> > +       for (i = 0; i < L_ARRAY_SIZE(e4_operating_classes); i++) {
> > +               const struct operating_class_info *info =
> > +                                               &e4_operating_class
> > es[i];
> > +
> > +               if (!freq_in_oper_class(freq, info, NULL))
> > +                       continue;
> > +
> > +               if (info->channel_spacing != 20)
> > +                       continue;
> 
> nit, but you might want to check this first.

Looking at this function again after a break I don't even think we need
it. Since the only width for non-HT is 20MHz and we just set the
frequency...

The caller could just validate the frequency (which it already does)
and set into the chandef if HT is not supported.

> 
> > +
> > +               best = info;
> > +               break;
> > +       }
> > +
> > +       if (!best)
> > +               return -ENOENT;
> > +
> > +       chandef->frequency = freq;
> > +       chandef->channel_width = BAND_CHANDEF_WIDTH_20NOHT;
> > +
> > +       return 0;
> > +}
> > +
> > +/* Find an HT chandef for the frequency */
> > +int band_freq_to_ht_chandef(uint32_t freq, const struct
> > band_freq_attrs *attr,
> > +                               struct band_chandef *chandef)
> > +{
> > +       enum band_freq band;
> > +       enum band_chandef_width width;
> > +       unsigned int i;
> > +       const struct operating_class_info *best = NULL;
> > +
> > +       if (attr->disabled || !attr->supported)
> > +               return -EINVAL;
> > +
> > +       for (i = 0; i < L_ARRAY_SIZE(e4_operating_classes); i++) {
> > +               const struct operating_class_info *info =
> > +                                               &e4_operating_class
> > es[i];
> > +               enum band_chandef_width w;
> > +
> > +               if (!freq_in_oper_class(freq, info, &band))
> > +                       continue;
> > +
> > +               /* Any restrictions for this channel width? */
> > +               switch (info->channel_spacing) {
> > +               case 20:
> > +                       w = BAND_CHANDEF_WIDTH_20;
> > +                       break;
> > +               case 40:
> > +                       w = BAND_CHANDEF_WIDTH_40;
> > +
> > +                       /* 6GHz remove the upper/lower 40mhz
> > channel concept */
> > +                       if (band == BAND_FREQ_6_GHZ)
> > +                               break;
> > +
> > +                       if (info->flags & PRIMARY_CHANNEL_UPPER &&
> > +                                               attr->no_ht40_plus)
> > +                               continue;
> > +
> > +                       if (info->flags & PRIMARY_CHANNEL_LOWER &&
> > +                                               attr-
> > >no_ht40_minus)
> > +                               continue;
> > +
> > +                       break;
> > +               default:
> > +                       continue;
> > +               }
> > +
> > +               if (!best || best->channel_spacing < info-
> > >channel_spacing) {
> > +                       best = info;
> > +                       width = w;
> > +               }
> > +       }
> > + > +   if (!best)
> > +               return -ENOENT;
> 
> So why not limit the above loop to 40 mhz channel spacing, and if
> nothing is 
> found, do something like

We still need to support 20Mhz since there is this distinction between
20MHz HT and 20Mhz no-HT. If only 20MHz HT is supported we should pick
that rather than the non-HT width.

> 
> if (!best)
>         return band_freq_to_chandef();

So ap.c just tries to pick the best chandef so in theory we could fall
back to non-HT and this wouldn't be totally unexpected (from the users
perspective). The problem is we would then need to disable HT in ap.c
if we fell back to non-HT.

Since I may just remove band_freq_to_chandef() entirely I might instead
keep the -ENOENT return and fall back inside ap.c itself. Then I don't
have to check chandef->channel_width after a successful return and we
know this will always return an HT chandef, or fail.

> 
> Or alternatively, pass in a parameter for maximum desired width.
> 
> > +
> > +       chandef->frequency = freq;
> > +       chandef->channel_width = width;
> > +
> > +       /*
> > +        * Choose a secondary channel frequency:
> > +        * - 20mhz no secondary
> > +        * - 40mhz we can base the selection off the channel flags,
> > either
> > +        *   higher or lower.
> > +        */
> > +       switch (width) {
> > +       case BAND_CHANDEF_WIDTH_20:
> > +               return 0;
> > +       case BAND_CHANDEF_WIDTH_40:
> > +               if (band == BAND_FREQ_6_GHZ)
> > +                       return 0;
> > +
> > +               if (best->flags & PRIMARY_CHANNEL_UPPER)
> > +                       chandef->center1_frequency = freq - 10;
> > +               else
> > +                       chandef->center1_frequency = freq + 10;
> > +
> > +               return 0;
> > +       default:
> > +               /* Should never happen */
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >   uint8_t band_freq_to_channel(uint32_t freq, enum band_freq
> > *out_band)
> >   {
> >         uint32_t channel = 0;
> 
> Regards,
> -Denis


