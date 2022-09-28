Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9584C62
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 19:14:22 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id w10so12520987pll.11
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=JCuyQMdEfJXN7DkbYL1aZEqk3GW6JjP5RNR/NbaMGnE=;
        b=VUPEoN3sVEVo/rlleeQ/ZJn2tQOW3rLCRBSFM2osQuLtkli0r9j7JqLWVMydoZOzZS
         fyH84cOB8ElViHHM8AXG+zelsUYVW1VaLVrSbmuwcJeKlXkgS7CtmuSFtnVey8QOG0R0
         idcTx/QR7mdy6E1PhnGZK8hdVcfbACPwKIa/n2Ybx1hfyI8dJamZvTUZR4FRMdXOyr9M
         QAGRQgD26aJq2X/+MAaF8giyAd3EmXCva5z1+FS8raNbqVFfceapovQCwz5kCzUgHami
         XKiyaCTC8QGIF5zZT1JDz1QBaL3ICcD5Sf4UqaZeyMEEU+AdIOyVft6yfClAAfsfA246
         nCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=JCuyQMdEfJXN7DkbYL1aZEqk3GW6JjP5RNR/NbaMGnE=;
        b=kueGtgc5oz5cZvsartRAeXB3Tv+ctL+SuLl+cZ/b/MsgmgDzZu2YJ36f6S0F2IMRAY
         W0LK3JLKhS7tMXsx+wXN43RMqckAvJNXaOC0cqu4D1wAq3zm+GHdeTRl+gZH7HCcz/k7
         eSpz9ZsKYJULbU2ntvsnGMWnZdEAEYpFPk2AO+lgOAjrNJVcz2gPuNFTuni+TFBDdA3I
         wOw+04FPkThMdtvyqhjPaDGUvz2Wa54O9o5e66/MEU6FMUrfQDUt+UkrqAmbAaNVhyd7
         PFFMXwX1ozEHwVaxBmZZLSTMpNG8ldxoDKGjrBYt5NNzIKqjk7UqJrQZOudtEmZi+o2Q
         htSw==
X-Gm-Message-State: ACrzQf1H6iSeEyPCaM+qwawJ5Y+hBFi8MK3BWlcvLLMiT5NhWhnIUaXX
	jB4VkYFFidP1/UZFwgLBtd4=
X-Google-Smtp-Source: AMsMyM4EAsP8FAnWvz77a4huTA6FbdeFdnCrtumq+qe2WwpejSVuXILwG8KqRhFMElX1FsUBoNXsIw==
X-Received: by 2002:a17:90b:350b:b0:202:8495:6275 with SMTP id ls11-20020a17090b350b00b0020284956275mr12405304pjb.216.1664392461575;
        Wed, 28 Sep 2022 12:14:21 -0700 (PDT)
Received: from [192.168.68.74] ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902dac600b0016c50179b1esm4175899plx.152.2022.09.28.12.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 12:14:21 -0700 (PDT)
Message-ID: <7c06640fa31b8844b55349f4edb93fd0d6ee0e13.camel@gmail.com>
Subject: Re: [PATCH 1/2] station: add two new roaming states (FT/FW)
From: James Prestwood <prestwoj@gmail.com>
To: Alvin =?UTF-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Date: Wed, 28 Sep 2022 12:14:20 -0700
In-Reply-To: <20220928184817.nwc3w4awwsssv32x@bang-olufsen.dk>
References: <20220928183351.363600-1-prestwoj@gmail.com>
	 <20220928184817.nwc3w4awwsssv32x@bang-olufsen.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alvin,

On Wed, 2022-09-28 at 18:48 +0000, Alvin Šipraga wrote:
> Hi James,
> 
> On Wed, Sep 28, 2022 at 11:33:50AM -0700, James Prestwood wrote:
> > This adds two new station states to differentiate between
> > reassociation (ROAMING), Fast transition (FT_ROAMING) or a firmare
> > based roam (FW_ROAMING).
> > ---
> >  src/station.c | 33 +++++++++++++++++++++++++--------
> >  src/station.h |  4 +++-
> >  src/wsc.c     |  2 ++
> >  3 files changed, 30 insertions(+), 9 deletions(-)
> > 
> > diff --git a/src/station.c b/src/station.c
> > index 372e23c1..6bd66ffc 100644
> > --- a/src/station.c
> > +++ b/src/station.c
> > @@ -197,6 +197,13 @@ static bool station_is_autoconnecting(struct
> > station *station)
> >                         station->state ==
> > STATION_STATE_AUTOCONNECT_QUICK;
> >  }
> >  
> > +static bool station_is_roaming(struct station *station)
> > +{
> > +       return station->state == STATION_STATE_ROAMING ||
> > +                       station->state == STATION_STATE_FT_ROAMING
> > ||
> > +                       station->state == STATION_STATE_FW_ROAMING;
> > +}
> > +
> >  static bool station_debug_event(struct station *station, const
> > char *name)
> >  {
> >         struct l_dbus_message *signal;
> > @@ -1461,6 +1468,10 @@ static const char
> > *station_state_to_string(enum station_state state)
> >                 return "disconnecting";
> >         case STATION_STATE_ROAMING:
> >                 return "roaming";
> > +       case STATION_STATE_FT_ROAMING:
> > +               return "ft-roaming";
> > +       case STATION_STATE_FW_ROAMING:
> > +               return "fw-roaming";
> >         }
> 
> I think you have to update the API doc in this case? doc/station-
> api.txt:
> 
> Properties      string State [readonly]
> 
>                         Reflects the general network connection
> state.  One of:
> 
>                         "connected", "disconnected", "connecting",
>                         "disconnecting", "roaming"
> 
> Is there a general policy regarding such extensions to the API? I am
> asking because our network management code tracks this state over
> DBus,
> and with this change our code will need some changes. I don't find it
> objectionable but it might mean I should keep a closer eye on the
> mailing list :-)

This is only changing the internal to_string() function, not the DBus
API (it has its own state_to_string function, mostly duplicated). This
should only effect the debug prints for state changes and expose any
weird driver behavior related to the ROAMING state rather than hide it.

> 
> Kind regards,
> Alvin


