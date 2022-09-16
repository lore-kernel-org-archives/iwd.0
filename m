Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5D5C81
	for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 16:18:29 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so143552pjk.4
        for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=JPHH/SNrrqbP40KF8lMYKr6FgGKYcuKJvVoAZ07Nin0=;
        b=f13GsUMfPtPbs0lNlcqjjQCxDWTw0bjlpEA/3XDc8Ckok1FBPDISC2klxi/n449k1e
         pK4icS2XgO/7LqK15zZ5JxE9lDSrQy7D9Le9Q7AT5t85aVDf7OidVh+/5IE15nCmWeEE
         hgzz65vPXDJr5huBPmX3lkJ3I/wUwrx4GF08tSE7t4J36J6bbQUXZGAGKca4X0zZhiLn
         3HCXEr2LDN1Z8oYGlGMHUcaMLzj8CgNFm1mK1FD3MTGCsUD2nKkRhnq3wR5TQk27uiVY
         iqu/3OZ3gty3rxrQpcTPl9Xgh1KgQmNshnjLiFZenWJ1DbmlKEG80HcuKljo++pS8GPq
         qqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=JPHH/SNrrqbP40KF8lMYKr6FgGKYcuKJvVoAZ07Nin0=;
        b=HtA2FYnzVxWVFafHvDw8Zdr3jpt5b1jMthsB2k7MPPf4D7DhglxvQV9Sxd9jGSiJ2u
         dz0u5Y3cnfxAUQNdS9kj6eQUO1xSG+Fd34/p/2lKZ6zbRhSElFt5t3DnPlLYNGenTGGp
         zIYnONt2/rJM5xkX2pRh7GWg2e/4NnOkh8f29yIoC43dYLmSSSS373QASsFYiN+6WETy
         Y/UpcWmvYtqFjJBpNodQNV5jPVwugbtArQeXNjaMFl32CoRA4XEBlxLTCsF65Ne4LJZF
         5vlNq84l2I4PkyLri6isLjk/9vK0xgHv4H49EJXbhqPWXYUSkygRW3fMTmFnOgC1GZki
         gR2Q==
X-Gm-Message-State: ACrzQf3iSYecsdyrLzSM4G2gyHcH1iSDvEHdK7Bi1cJWp5o9QQfVX16f
	HhP7KCkPDaST0CnUS2Cz+BWrLROWG8o=
X-Google-Smtp-Source: AMsMyM4ekF5pbGav/TjM/jG+3VJ+eFPvgSYmatkSYIlrsTMMFtD791tUPSNeJM+JhYsq1vO9hqbxpA==
X-Received: by 2002:a17:902:d2d0:b0:178:329d:a5ed with SMTP id n16-20020a170902d2d000b00178329da5edmr600914plc.142.1663345109112;
        Fri, 16 Sep 2022 09:18:29 -0700 (PDT)
Received: from [192.168.68.90] ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id y10-20020a62640a000000b0053e6bda08e0sm14683396pfb.219.2022.09.16.09.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 09:18:28 -0700 (PDT)
Message-ID: <2fff0f5abad37fdd79aea33817d7085b3297a319.camel@gmail.com>
Subject: Re: [PATCH v3 03/14] ft: remove OCI element from auth/assoc
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Date: Fri, 16 Sep 2022 09:18:28 -0700
In-Reply-To: <41488706-bce4-6160-5eab-78ad4b350c7b@gmail.com>
References: <20220915220741.1128728-1-prestwoj@gmail.com>
	 <20220915220741.1128728-3-prestwoj@gmail.com>
	 <41488706-bce4-6160-5eab-78ad4b350c7b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2022-09-16 at 11:05 -0500, Denis Kenzior wrote:
> Hi James,
> 
> On 9/15/22 17:07, James Prestwood wrote:
> > FT is moving to authentication via CMD_FRAME which breaks the
> > ability
> > to get the OCI from the kernel (since its now an offchannel
> > operation).
> > Using OCI during FT isn't that useful anyways, so its being
> > removed.
> > ---
> >   src/ft.c     | 26 ++------------------------
> >   src/ft.h     |  2 +-
> >   src/netdev.c |  3 +--
> >   3 files changed, 4 insertions(+), 27 deletions(-)
> > 
> 
> Hmm, why don't we just keep this code in case the kernel starts
> providing us the 
> OCI info prior to Associate?  These paths just won't be hit when ocvc
> is false, no?

True, we can leave it in there.

> 
> Regards,
> -Denis


