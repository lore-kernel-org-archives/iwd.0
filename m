Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF845C81
	for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 16:28:25 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id g4so20869799pgc.0
        for <iwd@lists.linux.dev>; Fri, 16 Sep 2022 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=rvzUwpIENuH0xs3WxONKhBvS9vGerma2oPkDOiFA6dI=;
        b=OzcP9snMt2ksKNPQOncfvWZjuf87+OmJbNXN87/WB8ybzsN8iRgMQnuTIFoZwy8Qrf
         TPyFzkInorc50E6P1lTaYhwRKaUaVN1AG1Py6K6goYK7gNnmDuhD2jpVR4ZBhKdruomj
         YHcCE/APnklSlI/s5xoPVIWN6rnh8mu7AQfLuYbSp4gjcEfuqdhg4YxfU3xmFZn4h311
         vzfa7Y5OBrK30uFaDC/2HpPVImqD8HzY9Jx0xwzNbm2/bBtdibRnYFCEZ9TapgNIcyYL
         XymqQQfYBRAYzZo6D+HfDEV0hZV2vqEvjkDCFWs12vz0H7u3Mm+4aQt7yg/UzVAFBA5B
         ggbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=rvzUwpIENuH0xs3WxONKhBvS9vGerma2oPkDOiFA6dI=;
        b=oaWQ/zevZKKeHV1Kt86ysuq9qxC55rbcDl5rL0qbKsgwiyjlLjZqqYcD5IZVBtaqaO
         o1CxIhaRY3Tg8KrR1LM662ihqxbKabnUgrrdCr/WnVk3My7a2q5JM/3NbCwVmAql7WFy
         J7Q47eUVDwB3gENWbFltGLiCVmE8FXHPtGMLn84DD9g/wkFCMHmQETdYNkuoGhz5zfs2
         +QmZR+smFLk7SX1knc0zuglrNtDQmZ7IZEmqaHq7TS3SuskMrBSvVQKkkc8hBjh5SxcF
         6uGGAjeZfkIpRV1LUQuwD/pR6OIxTjTJ+wF7Gx8maYDGHHm/udUAabUPFrF9whvflze3
         kCCQ==
X-Gm-Message-State: ACrzQf3g+vVt7zIdbPNCiwLmlWvyAh0z2rN9RkQrrxPeV3sI9ljhA1P0
	s8f59ZchhkAyBiZwaU4xuOI=
X-Google-Smtp-Source: AMsMyM6BqvUug7/EymmPUOspgOtDuJgtzro4KwcpuTKdgFThVp2njdJC3QBSSCdyFTP1bccNB+T+LQ==
X-Received: by 2002:a05:6a00:a04:b0:534:d8a6:40ce with SMTP id p4-20020a056a000a0400b00534d8a640cemr5738685pfh.15.1663345704650;
        Fri, 16 Sep 2022 09:28:24 -0700 (PDT)
Received: from [192.168.68.90] ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709027e0800b0015e8d4eb1f7sm15195583plm.65.2022.09.16.09.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 09:28:24 -0700 (PDT)
Message-ID: <96760884d04356a782581ca9f4174f6102689266.camel@gmail.com>
Subject: Re: [PATCH v3 04/14] frame-xchg: create global group enum
From: James Prestwood <prestwoj@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Date: Fri, 16 Sep 2022 09:28:23 -0700
In-Reply-To: <bebd8b2e-2b65-6da5-5d66-2d164aaee5d1@gmail.com>
References: <20220915220741.1128728-1-prestwoj@gmail.com>
	 <20220915220741.1128728-4-prestwoj@gmail.com>
	 <bebd8b2e-2b65-6da5-5d66-2d164aaee5d1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2022-09-16 at 11:06 -0500, Denis Kenzior wrote:
> Hi James,
> 
> On 9/15/22 17:07, James Prestwood wrote:
> > Only P2P utilizes groups for now but to avoid conflicts in group
> > numbers for other modules create a global list which can be added
> > to as needed.
> 
> A non-zero group implies opening a new nl80211 socket.  Do you really
> need/want 
> to do this for FT?

I did it that way because the over-air path uses frame-xchg with a
prefix/callback provided rather than a separate frame watch. So the
frame watch is only used for that Authentication sequence.

The alternative would be a single frame watch with an extra timer...

Unless frame-xchg can handle the prefix/callback being provided to
start() with group 0, not duplicate the watch for each auth attempt,
and filter and random auth frames it might get when we aren't
expecting.
 
> 
> > ---
> >   src/frame-xchg.h |  7 +++++++
> >   src/p2p.c        | 24 +++++++++---------------
> >   2 files changed, 16 insertions(+), 15 deletions(-)
> > 
> > diff --git a/src/frame-xchg.h b/src/frame-xchg.h
> > index 360bb4d4..5b55ded8 100644
> > --- a/src/frame-xchg.h
> > +++ b/src/frame-xchg.h
> > @@ -37,6 +37,13 @@ struct frame_xchg_prefix {
> >         size_t len;
> >   };
> >   
> > +enum frame_xchg_group {
> > +       FRAME_GROUP_DEFAULT = 0,
> > +       FRAME_GROUP_P2P_LISTEN,
> > +       FRAME_GROUP_P2P_CONNECT,
> > +       FRAME_GROUP_FT,
> 
> Anyway, I dropped the FT enum for now.  It doesn't belong here
> anyhow. 
> Applied, thanks.
> 
> Regards,
> -Denis


