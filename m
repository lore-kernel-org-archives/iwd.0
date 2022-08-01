Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FA87F
	for <iwd@lists.linux.dev>; Mon,  1 Aug 2022 16:18:48 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-10bd4812c29so14231668fac.11
        for <iwd@lists.linux.dev>; Mon, 01 Aug 2022 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPKf050muhKp/ND0QDVEEU/kpJZJbudR9gOqX/2pxMg=;
        b=qhA2qnhe0LNUR3I43RyXwasndz4UPhxROHjp5z1F7AOcT3sp/7pjkR4vd4zYLinCuZ
         71LhLfSduNDklZE9NxhuA7KfnECdPkDr6wYTlo6QK968AqGvef7UpQBPK0HYXm7E3IhE
         jFmtRbqmshGhgB/5Rr03LA7+HqCiJwN5yO0UmhIQK6SWI2Ef4eF7TOVDSlzF7i79aY5v
         g8rna6PfM/qe8faT3/yx52RqPbeJeIzuox5jU4Gjcvgtt8BlWZhNGtbjRWTVxK7TSQ9a
         u9MgBbJvYT8v9s4BjKZe/nCgHKmFTLBnlzth3Laa/ClkdtU/9KuJvobMKXH3mXlYwWqB
         i1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPKf050muhKp/ND0QDVEEU/kpJZJbudR9gOqX/2pxMg=;
        b=QPnE7qRUmW7Knxoijwe6653CHTFryH7SvZO9Xxv1YThgymq5Uw+92zLXndWGqqLr+M
         5xAjS2Kv37hQGOiwo5i2BqY4S0ba64juMakP5A3UxIkauJ6FmKA8iRwuNP4oOala7l43
         p+XYU6r3zhQikUSpsZOWtMjMIxr9kmIdFplFwNlZZ3LoUsgo6lhjhAn68kcgHc4kWTGK
         lEUqtYs4Aac2aVuZBXt8c8UbSDdjBTlOI+EoYC5rYXCRV3rzbM0PpGwqzMMohubCN8ZO
         fumeo24NLcrZVZ+eALmEF436h6TSc5YauNrpLBSOhNUUBU6OG8wSzfDlFaqx2MVGqd7Q
         gnkQ==
X-Gm-Message-State: AJIora+zfAL2vd6lL0VvsXhdYEL54wFf9U0pJPPblL6fqFZGj95RxGip
	gZ2vvDnd2+ufA3ZDmmFmpTni/nLDF4dH1zkN265hStUmBQnSow==
X-Google-Smtp-Source: AGRyM1s6ac2vdZYv1qG20WJgNPfSp54VOq8hxN7FnPvGBYO9bK8AJtyfK4DSCMobE+FJeHJC1DVft1lnROQ1wGgjsi8=
X-Received: by 2002:a05:6870:4586:b0:10d:2ec7:be6 with SMTP id
 y6-20020a056870458600b0010d2ec70be6mr8328224oao.7.1659370727699; Mon, 01 Aug
 2022 09:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220801100631.41605-1-mjohnson459@gmail.com> <6bc199e2-2f40-b192-9de6-30fceb2510ea@gmail.com>
In-Reply-To: <6bc199e2-2f40-b192-9de6-30fceb2510ea@gmail.com>
From: Michael Johnson <mjohnson459@gmail.com>
Date: Mon, 1 Aug 2022 17:18:36 +0100
Message-ID: <CACsRnHULBH=jmCiG4=kczJALPsy7Whx+TmDf-JhQryyc5GwBow@mail.gmail.com>
Subject: Re: [PATCH 1/2] netdev: Add logging for CQM messages
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Denis,

On Mon, 1 Aug 2022 at 16:27, Denis Kenzior <denkenz@gmail.com> wrote:

> > @@ -1106,10 +1120,14 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
> >       }
> >
> >       if (rssi_event) {
> > -             if (rssi_val)
> > +             if (rssi_val) {
> > +                     l_info("Signal change event (above=%d signal=%d)",
>
> I'm not sure 'above=%d' is going to work.  rssi_event is only set on
> THRESHOLD_EVENT_LOW/THRESHOLD_EVENT_HIGH.  If RSSI_LEVEL is being reported, that
> pointer is still NULL.

Should the top level `if (rssi_event) {` not cover that case? I
believe it checks both
pointers before the info statement. I didn't add any output in the case of an
RSSI_LEVEL but no THRESHOLD_EVENT_* as I haven't seen this actually occurring
so assumed iwd didn't set up non-threshold events?

>
> > +                                                     *rssi_event, *rssi_val);
> >                       netdev_cqm_event_rssi_value(netdev, *rssi_val);
>
> Hmm, I don't think wpa_s uses RSSI_LEVEL stuff in the kernel, does it?  The
> reason I ask is that we do have UIs that setup RSSI level reporting for
> displaying connection link quality (in number of bars for example).  Since such
> events are quite common, I think you're going to get quite a bit of spam in the
> logs.  Are you only interested in cases where the roaming threshold is reached?
>   If so, you may need to modify netdev_cqm_event_rssi_value() instead.

Sorry, I should have included more reasoning behind the change.

In my use case the client is running headless and so the logs are
really the only
insight into why the network might have degraded to the point of causing issues.
For example, if the client stops receiving data, it is useful to know
what the rough
signal level is that caused it as that might imply a dead zone or
interference. All
debugging is done remotely as well so we can't ever debug the network while
it is currently in a bad state hence the log part.

The useful data isn't just the threshold but the general signal level
at the time of
an incident. If all is working then we would have roamed before the signal gets
bad enough  to cause issues (it follows that we don't really care about _good_
signal values so maybe we could reduce spam there?)

As for the general spamminess, does the UI RSSI reporting cause more events
than running normally? I believe I was only seeing events when the signal had
changed more than the hysteresis value in netdev_build_cmd_cqm_rssi_update
(5 dBm). This doesn't seem too frequent (for me at least) when the client is
mostly static. When it is moving it is generally useful information.

For wpa_supplicant, I'm not sure the exact mechanism it uses but it does report
almost identical output at a fairly high frequency if the client is moving e.g.
```
May 08 08:56:04 p3-2019 wpa_supplicant[842]: wlp2s0:
CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-62 noise=-93 txrate=6000
May 08 08:56:14 p3-2019 wpa_supplicant[842]: wlp2s0:
CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-76 noise=-93 txrate=6000
May 08 08:56:27 p3-2019 wpa_supplicant[842]: wlp2s0:
CTRL-EVENT-SIGNAL-CHANGE above=0 signal=-79 noise=-94 txrate=6000
```

Finally, the reason I made this `info` level was in the hope that I could
remove the `-d` flag from iwd which does produce a lot of spam in the logs.
This isn't really feasible at the moment as there isn't enough `info` logging
to track down any issues that might occur on production systems where
changes are harder to make. If the `info` level becomes to verbose, maybe
iwd could set the default logging level to `warn` to reduce spam?

>
> > -             else
> > +             } else {
> > +                     l_info("Signal change event (above=%d)", *rssi_event);
> >                       netdev_cqm_event_rssi_threshold(netdev, *rssi_event);
> > +             }
> >       }
> >   }
> >
>
> Patch 2 looks fine btw, so I applied that one.
>
> Regards,
> -Denis

Regards,
Michael
