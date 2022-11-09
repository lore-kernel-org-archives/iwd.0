Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBC290F
	for <iwd@lists.linux.dev>; Wed,  9 Nov 2022 21:29:01 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id b3so28037013lfv.2
        for <iwd@lists.linux.dev>; Wed, 09 Nov 2022 13:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHuJz9i3KG+HkeFZ1vnWJ1ddO0XMWMLGLHhRP7GW2IY=;
        b=VU9AF98tjXyZmGFTLWb+H7BKcGURio06kQeLsHbs80gRlgHvlxFPwUTx5Mxd2h82g7
         oECijmSqC3GSDtryxc7GpERC9KrInGpZ3HsVs0PXvtTk8iHXAKOYwzU0CDE3wCspPQYP
         TxGiXvm8MrQdNo06u/0Y70Nfg2aR/VEgCt6RFZmHX5vmPxoaqUXTzroicF3PnEVo6HCP
         1NqLYkjkPsZwzJsPlRLyfbAlSGWGGPexSb3AjR8RwRE7Uv3oipTtGdGtEGSkIOQPdaX+
         iMMpsBjxPCx6VGtI4+i1NgpH8U7lvV4eRdUTWVYzloeikPB+VZ4JSc1gyHNblRazzxXv
         3/mA==
X-Gm-Message-State: ACrzQf0UcE3aXqp4+arLIytT9jJpWJ80Mlmkvn6KIlyPL/8ESf/5wQge
	4tUBdC80eBY6vswovVQHpPfjFS4Y4Ih/lw==
X-Google-Smtp-Source: AMsMyM4LkNWf53x01q3APU49cFFXV1xvoXirVo9KBLZkAR/p81/t2i0X2H/kFt3elzdzBBERq1kt2g==
X-Received: by 2002:ac2:4a76:0:b0:4a2:2210:f169 with SMTP id q22-20020ac24a76000000b004a22210f169mr892433lfp.317.1668029339319;
        Wed, 09 Nov 2022 13:28:59 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05651c169100b0027711348b33sm2353243ljb.139.2022.11.09.13.28.58
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 13:28:58 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id j16so27973124lfe.12
        for <iwd@lists.linux.dev>; Wed, 09 Nov 2022 13:28:58 -0800 (PST)
X-Received: by 2002:ac2:5107:0:b0:4b2:3b2:555e with SMTP id
 q7-20020ac25107000000b004b203b2555emr7781557lfb.429.1668029338155; Wed, 09
 Nov 2022 13:28:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221109170438.535300-1-andrew.zaborowski@intel.com>
 <20221109170438.535300-2-andrew.zaborowski@intel.com> <e7035cb1-17d0-22e5-3bfa-4e6515e2b4c9@gmail.com>
In-Reply-To: <e7035cb1-17d0-22e5-3bfa-4e6515e2b4c9@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Wed, 9 Nov 2022 22:28:45 +0100
X-Gmail-Original-Message-ID: <CAOq732Lhjow_iZyNHs9bn+j9q_yHsZDP7qX37pgWrzsUs+y=AA@mail.gmail.com>
Message-ID: <CAOq732Lhjow_iZyNHs9bn+j9q_yHsZDP7qX37pgWrzsUs+y=AA@mail.gmail.com>
Subject: Re: [PATCH 2/2] eap-tls: Add session caching
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Denis,

On Wed, 9 Nov 2022 at 21:45, Denis Kenzior <denkenz@gmail.com> wrote:
> On 11/9/22 11:04, Andrew Zaborowski wrote:
> > Use l_tls_set_session_cache() to enable session cache/resume in the
> > TLS-based EAP methods.  Sessions for all 802.1x networks are stored in
> > one file, /var/lib/iwd/.tls-session-cache, indexed by the EAP method
> > name and authenticator's MAC/BSSID (handshake->aa) because that's
> > ultimately what identifies the authenticator which will usually be the
> > TLS server as also.  We may want to add the SSID to the index.  Multiple
> > BSSes and even multiple ESSes (SSIDs) may be backed by a single
> > authentication server but it's hard for us to know that.
>
> But isn't the TLS session ultimately out to the RADIUS server?  So wouldn't the
> session id be identical between the entire ESS/SSID?

So like I said it may be but we can't know this.  There may be no
RADIUS server: looking at 802.1x everytime it mentions RADIUS it's an
"example" AAA and also mentions Diameter.  But there may be no central
AAA server in the first place.

For example 6.3.1 says: "The Authenticator and an Authentication
Server can be co-located within the same system, allowing that system
to perform the authentication function without the need for
communication with an external server. However most port-based network
access control applications use a separate Authentication Server, to
allow centralized administration (...) throughout a network.", similar
wording in other places.

And then multiple ESSes (different SSIDs) can use the same AAA but
it's the same situation because we can't know for sure (unless the
BSSID is the same)

I think indexing by BSSID should work well but can also change this to
use just the SSID, or both.

> I also don't see the need
> to store the EAP type here as well.

Ok.

> We can't have SSIDs with multiple EAP types.

I think some of the eduroam networks do support fallback EAP types but
I guess the TLS cache may be independent of the EAP type.

>
> This does however bring up another point.  Shouldn't you clear out the cache
> when a network is forgotten?

Good point, if we include the SSID as the (or one of) primary keys we
can drop entries related to that SSID.  Or we could expire old entries
with time.

> In which case, how do you reload the cache in the
> EAP module?

We don't need to notify the l_tls instances about the change.  They
share one l_settings object but they only look at it at one time in
the handshake and don't assume that the cache is unchanged between
handshakes.

>
> >
> > eap_{get,set}_peer_id() API is added for eapol to set the identifier of
> > the authenticator (or the supplicant if we're the authenticator, if
> > there's ever a use case for that).
>
> Okay
>
> >
> > eap-tls-common.c can't call storage_tls_session_cache_{load,sync}()
> > directly because it's linked into ead and some unit tests without
> > storage.c, so station.c sets pointers to the load & sync functions using
> > the new eap_tls_set_session_cache_ops().
>
> ead should probably start using storage.c anyway since that does profile
> encryption and we ultimately want that inside ead as well.  But we can solve
> this later.
>
> > ---
> >   src/eap-tls-common.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> >   src/eap-tls-common.h |  6 +++++
> >   src/eap.c            | 13 +++++++++++
> >   src/eap.h            |  3 +++
> >   src/eapol.c          |  4 ++++
> >   src/station.c        |  6 +++++
> >   6 files changed, 84 insertions(+)
> >
>
> <snip>
>
> > @@ -633,6 +645,26 @@ static bool eap_tls_tunnel_init(struct eap_state *eap)
> >       if (eap_tls->domain_mask)
> >               l_tls_set_domain_mask(eap_tls->tunnel, eap_tls->domain_mask);
> >
> > +     if (!eap_tls_session_cache_load)
> > +             goto start;
> > +
> > +     if (!eap_tls_session_cache) {
> > +             eap_tls_session_cache = eap_tls_session_cache_load();
> > +
> > +             if (!eap_tls_session_cache) {
> > +                     eap_tls_session_cache = l_settings_new();
> > +                     l_debug("No session cache loaded, starting with an "
> > +                             "empty cache");
> > +             }
>
> Can we run into a situation where we have two TLS sessions running with the same
> cache entry and it is invalidated somehow?  Do we need to notify the other TLS
> sessions somehow?
>
> Perhaps if we're running a multi WLAN setup and both are connected to the same SSID?

This should be fine, once a new session is ready it's immediately
added to the cache and other instances can resume the same session
even while it's active.  The spec says if the session is being
removed, active instances that use it can keep going, only no new
resumptions can happen.

Best regards
