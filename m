Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44291A612
	for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 18:15:31 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id p8so4737669lfu.11
        for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 10:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEahLaAjZK5TGFw3EfAKCicB9ued91zDzXrzjvSk8VU=;
        b=tGbZtnvuVTTF3lBJfuwl4pfvkehHbr+uy5tjs127HywG13yssUmB+wduicNbfxJtP3
         bq9cRvR9MZTvsOigFB+HBp8D6RoG7r+AXWuUfTTtpHPwSKjrzsawCxhsvDqknPHl2kTJ
         YnY1IuW8EWx0GGQyaKtN7FcbWumjvUvvdfyNAOkx5y8OrRdWJ7jAq6/nWwkz5wNc2lUR
         PtziBj8bbfeWdFQIRKCIogyxeZj0tc0NaTCGCxXGsdcNEJxGDpv6d9yNG43y0e6DuZzz
         QTIdF6SBMhm6Bq6qHqoQRJ5nSSuaCEnWO8GB6KKQaIyUGWl4j1ylZ4ZIzXzZzB0VtffV
         9a5Q==
X-Gm-Message-State: ACrzQf0Q0FOua7bJt8EJz9lRTpsYmZHmovhBr81Auci/otqEgBE0DU/X
	E/XlQgMKEFJNlcu4v+8NQhgLsAsBuqJ4Bg==
X-Google-Smtp-Source: AMsMyM5mmC0Q1HrZMa0+LVUX/Qi4aBacSiZwtOvY9ouTys2Kv34uOiE6qL28RKFDkqGBzVd9kc0ykw==
X-Received: by 2002:a19:6a13:0:b0:4b1:753b:e66f with SMTP id u19-20020a196a13000000b004b1753be66fmr1748761lfu.276.1668104129336;
        Thu, 10 Nov 2022 10:15:29 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id f14-20020ac2508e000000b0049478cc4eb9sm2845214lfm.230.2022.11.10.10.15.27
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 10:15:28 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id l12so4771776lfp.6
        for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 10:15:27 -0800 (PST)
X-Received: by 2002:ac2:5931:0:b0:4a2:6242:329f with SMTP id
 v17-20020ac25931000000b004a26242329fmr1723352lfi.197.1668104127042; Thu, 10
 Nov 2022 10:15:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221109170438.535300-1-andrew.zaborowski@intel.com>
 <20221109170438.535300-2-andrew.zaborowski@intel.com> <e7035cb1-17d0-22e5-3bfa-4e6515e2b4c9@gmail.com>
 <CAOq732Lhjow_iZyNHs9bn+j9q_yHsZDP7qX37pgWrzsUs+y=AA@mail.gmail.com> <7931ee49-c4fe-51b2-81c0-afc473c19fda@gmail.com>
In-Reply-To: <7931ee49-c4fe-51b2-81c0-afc473c19fda@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Thu, 10 Nov 2022 19:15:14 +0100
X-Gmail-Original-Message-ID: <CAOq732+gHv3qJfP7=fve0LN1VgH87S7qEyu2Q=NwfYFZggN-ZA@mail.gmail.com>
Message-ID: <CAOq732+gHv3qJfP7=fve0LN1VgH87S7qEyu2Q=NwfYFZggN-ZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] eap-tls: Add session caching
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Nov 2022 at 16:18, Denis Kenzior <denkenz@gmail.com> wrote:
> >> But isn't the TLS session ultimately out to the RADIUS server?  So wouldn't the
> >> session id be identical between the entire ESS/SSID?
> >
> > So like I said it may be but we can't know this.  There may be no
> > RADIUS server: looking at 802.1x everytime it mentions RADIUS it's an
> > "example" AAA and also mentions Diameter.  But there may be no central
> > AAA server in the first place.
> >
> > For example 6.3.1 says: "The Authenticator and an Authentication
> > Server can be co-located within the same system, allowing that system
> > to perform the authentication function without the need for
> > communication with an external server. However most port-based network
> > access control applications use a separate Authentication Server, to
> > allow centralized administration (...) throughout a network.", similar
> > wording in other places.
> >
>
> Right.  A centralized RADIUS server is the general case.
>
> > And then multiple ESSes (different SSIDs) can use the same AAA but
> > it's the same situation because we can't know for sure (unless the
> > BSSID is the same)
>
> Sure, but why even bring this up?  We can't know whether different SSIDs would
> use the same RADIUS server.  But it is pretty much expected that a within an
> ESS, the same RADIUS server is used.

I don't have actual statistics but the other case ("co-located AA
server") also exists so to me this question is similar in that IWD has
no data to assume either option.

But I'm fine just ignoring the co-located AA case if that's what we want to do.

>
> >
> > I think indexing by BSSID should work well but can also change this to
> > use just the SSID, or both.
>
> Ultimately I don't see why we would want to limit this to just the BSSID?  Lets
> say you logged into a WPA-Enterprise network on 'AP A'.  You suspend your laptop
> and move within the building.  Resume and re-connect to 'AP B'.  There is a high
> likelihood that AP A & B share the RADIUS server and thus the TLS session.
>
> But even if 'AP B' doesn't share the TLS session, what is the harm in trying?
> Worst case the TLS server will reject our session ID and we'd have to start from
> scratch.
>
> So if we index by
>         a) SSID -> there's a good chance that we can reuse the session across routers,
> even if that fails in some cases
>         b) SSID + BSS -> We never try the session ID unless we have been connected to
> the same BSS before.  In which case there's no advantage over PMK caching?

The flipside of this is:
   a) SSID -> since we only store one session so everytime we switch
BSSes we overwrite the cached session in the co-located AA case and
rarely see the benefit of the cache.
   b) BSSID -> we store one session for each BSS and after some number
of reconnects every next one is going to be fast.

That said the RFC-recommended session lifetime being only 24h makes
this less practical.  Since we can't know how long each server's
session lifetime is I wonder if IWD should set it to a higher value in
case we're lucky.

>
> <snip>
>
> >> We can't have SSIDs with multiple EAP types.
> >
> > I think some of the eduroam networks do support fallback EAP types but
> > I guess the TLS cache may be independent of the EAP type.
> >
>
> We also can't use multiple method types within our profile either.

Right, let me remove it from the group name.

I put the full method name in there partly to make the contents of the
file more self explanatory to somebody who happens to open it in vim.

>
> >>
> >> This does however bring up another point.  Shouldn't you clear out the cache
> >> when a network is forgotten?
> >
> > Good point, if we include the SSID as the (or one of) primary keys we
> > can drop entries related to that SSID.  Or we could expire old entries
> > with time.
>
> I would think we need to explicitly drop anything related to the SSID of the
> network we just removed via KnownNetworks.Forget()

Ok.  I don't believe we do this for known frequencies though.

>
> >
> >> In which case, how do you reload the cache in the
> >> EAP module?
> >
> > We don't need to notify the l_tls instances about the change.  They
> > share one l_settings object but they only look at it at one time in
> > the handshake and don't assume that the cache is unchanged between
> > handshakes.
>
> Yes, but how does eap remove the relevant entries from the cache?

If we want to do this I'll probably move the cache singleton to
knownnetworks.c and drop the relevant group and not notify eap.
eap-tls-common.c would use something like
known_networks_get_tls_session_cache().

Best regards
