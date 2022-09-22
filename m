Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341166E8
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 15:42:02 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso2840271pjk.0
        for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=UMTKpw13LLivb8Bw1H33PLe/9cUIcdPmPhIG6qthho8=;
        b=DGEReNIAM6h9fuNBOimr4yKHZJNSOXFnIskVhrNCbxFd326sGW3pMECg2nzN7VpceX
         2e5UhzBHeiIN0jtwFZQXEp73AcZgnSO6za4b6UxwP1UUiJ4rgXWKk7iDLFLNhkn6nEXM
         yiakPqIzn05cSCxY8ryMUJ/C8L+yzgtmGFSDj+GOQmgHA1KELXKqhYqp3LKT16NuLrjp
         awFVq7fn4lL73mu2d/GhoY9En56jF64LUXr9DT1NRbChGQVILJGEFvEHHlK9+qidrixA
         Osqx8YBwAl6Uo+m2vXjRUs/NrBOYlE+iasLB+VC2WguAvKOLN2FV4xxkeMRGA92KfvRw
         qLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=UMTKpw13LLivb8Bw1H33PLe/9cUIcdPmPhIG6qthho8=;
        b=q2/LzHjxcaypFa8zCQb/OOTe/U9dExaxvM2yLfM8f2zwSRUhuMUK974ygWxUXyGA05
         ZZohCaCTChnBT5vNCcxGM1ecPriUzlNE1ZdRfMLLCDoDXylVCdTsh9nDlFyMVZmQZNiw
         5fZO3zgrADJcct+EZsHZZNNJ4tjAZGcJNIWpCUlBVv0muPgu4Z944QEqAl/sf/Amlo6d
         ItfaxSMw0/BHoCzU33sDMHQUvQ9scuWVSxaQ8Tqv8E3b2+pICgSjRQDxc428Vu5mxVEg
         /p+73RUcObq8e1cZxkpcrm+kHcRX3nShqBQtfMPoyLBRzhYXGBJ1RCJODCHM/MPE/RAo
         IE/Q==
X-Gm-Message-State: ACrzQf0k9pj/Fa3HbRSeudMtxDuppwMrywpqRuyvOe9TZ8paWa7eecOd
	sNr3owbgu6DLMIDQiW9WMI4AI5mj4Do=
X-Google-Smtp-Source: AMsMyM77ESHwbaTSxtrTrZSBCYPKanS2Uab35pFyUt/Y8atuE8ZBe5ws5yu9szXCRx0csq5/opXh5A==
X-Received: by 2002:a17:902:834c:b0:178:be25:203c with SMTP id z12-20020a170902834c00b00178be25203cmr3793114pln.96.1663861321331;
        Thu, 22 Sep 2022 08:42:01 -0700 (PDT)
Received: from [192.168.68.95] ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902760100b0017870f471f6sm4196114pll.226.2022.09.22.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:42:00 -0700 (PDT)
Message-ID: <052453327454f732c39f4bdeb888a737eca53cf5.camel@gmail.com>
Subject: Re: [PATCH v4 05/15] ft: netdev: prep for FT isolation into ft.c
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Date: Thu, 22 Sep 2022 08:42:00 -0700
In-Reply-To: <258acf4a-457b-4154-9be1-f78eb0154bdb@gmail.com>
References: <20220921223158.704658-1-prestwoj@gmail.com>
	 <20220921223158.704658-5-prestwoj@gmail.com>
	 <258acf4a-457b-4154-9be1-f78eb0154bdb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2022-09-21 at 21:40 -0500, Denis Kenzior wrote:
> Hi James,
> 
> On 9/21/22 17:31, James Prestwood wrote:
> > Currently netdev handles caching FT auth information and uses FT
> > parsers/auth-proto to manage the protocol. This sets up to remove
> > this state machine from netdev and isolate it into ft.c.
> > 
> > This does not break the existing auth-proto (hence the slight
> > modifications, which will be removed soon).
> > 
> > Eventually the auth-proto will be removed from FT entirely,
> > replaced
> > just by an FT state machine, similar to how EAPoL works (netdev
> > hooks
> > to TX/RX frames).
> > ---
> >   src/ft.c     | 312
> > ++++++++++++++++++++++++++++++++++++++++++++++++---
> >   src/ft.h     |  22 +++-
> >   src/netdev.c |  28 +++--
> >   3 files changed, 329 insertions(+), 33 deletions(-)
> > 
> 
> <snip>
> 
> > @@ -45,6 +69,9 @@ struct ft_sm {
> >         void *user_data;
> >   
> >         bool over_ds : 1;
> > +
> > +       uint8_t prev_bssid[6];
> > +       struct l_queue *ft_auths;
> 
> Is ft_auths still needed?

Oops, this was carry over from earlier versions.

> 
> >   };
> >   
> >   /*
> 
> <snip>
> 
> > +int ft_associate(uint32_t ifindex, const uint8_t *addr)
> > +{
> > +       struct netdev *netdev = netdev_find(ifindex);
> > +       struct handshake_state *hs = netdev_get_handshake(netdev);
> > +       struct ft_info *info;
> > +       int ret;
> > +
> > +       /*
> > +        * TODO: Since FT-over-DS is done early, before the time of
> > roaming, it
> > +        *       may end up that a completely new BSS is the best
> > candidate and
> > +        *       we haven't yet authenticated. We could actually
> > authenticate
> > +        *       at this point, but for now just assume the caller
> > will choose
> > +        *       a different BSS.
> > +        */
> > +       info = ft_info_find(ifindex, addr);
> > +       if (!info)
> > +               return -ENOENT;
> > +
> > +       ft_prepare_handshake(info, hs);
> > +
> > +       ret = ft_tx_reassociate(ifindex, info->frequency, info-
> > >prev_bssid);
> > +
> > +       /* After this no previous auths will be valid */
> > +       l_queue_clear(info_list, ft_info_destroy);
> 
> So why are we clearing the entire list?  Shouldn't we be clearing it
> only for 
> the ifindex in question?

Yes, it should just be per-ifindex.

> 
> > +
> > +       return ret;
> > +}
> > +
> > +void ft_reset(uint32_t ifindex)
> 
> I think a more descriptive name is required.  Like 
> ft_purge_authentications_for_ifindex() or something? :)
> 
> > +{
> > +       struct ft_info *info;
> > +
> > +       while ((info = ft_info_find(ifindex, NULL))) {
> > +               l_queue_remove(info_list, info);
> 
> This looks like a O(n^2) loop instead of doing the purge in linear
> time?

True, I guess I could do l_queue_peek_head() in the while condition,
then pop/free if the ifindex matches.

I've run into this a few times. Would be nice if we had an API to
remove/free multiple entries based on a match function. Or if an
l_queue_entry loop allowed removal, maybe it does already.

> 
> > +               ft_info_destroy(info);
> > +       }
> > +}
> > +
> > +static int ft_init(void)
> > +{
> > +       info_list = l_queue_new();
> > +
> > +       return 0;
> > +}
> > +
> > +static void ft_exit(void)
> > +{
> > +       if (!l_queue_isempty(info_list))
> > +               l_warn("stale FT info objects found!");
> > +
> > +       l_queue_destroy(info_list, ft_info_destroy);
> > +}
> > +
> > +IWD_MODULE(ft, ft_init, ft_exit);
> 
> Does netdev need an IWD_MODULE_DEPENDS on ft now?

I don't think so? Since init/exit aren't using any netdev calls I think
its safe.

> 
> Regards,
> -Denis


