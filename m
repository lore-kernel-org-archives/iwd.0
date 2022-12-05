Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F906125
	for <iwd@lists.linux.dev>; Mon,  5 Dec 2022 17:44:51 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id e141so15456678ybh.3
        for <iwd@lists.linux.dev>; Mon, 05 Dec 2022 09:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EWe8m0LHpE9pLoW1+47Px7bHTwGge7DU9bPU3Fi9O6Q=;
        b=glKmUerzu83cBVm54ERifMF8yOXRaaiXZPqofvnkUPRWPVSkdAlberKrgPG6jTRpSN
         O+8zrPRkE9qsbB2GeW/kfLcDfVLAxOy9z+7OxXy217/QzRnIVD0tm+Kqe3FtQP5qhaTq
         dbdNnO76BAU2gi59IVdnEFFzvgDxs63GKkY3pNRTQkzvm7GTAb3DJ6dIjvtFUD3jZIUN
         xgwkKAx4Sk2C2uwlf55en1VT5FyLD5+xLGf95cUVFhMpRIKbGZZR7gDoQkcFqEkTmWpg
         QBoCUqXdClNgZ2bfvBaKL77xYjLRf/m8ixl4WZBcOpPxpmUb7mg4X5gWrLPgyBA1gJc3
         l03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWe8m0LHpE9pLoW1+47Px7bHTwGge7DU9bPU3Fi9O6Q=;
        b=6S/PqBXrQpWR9wEkPjTLJ7qKFvl8uO7pOqe+Adwp6qTGyhHBoPTj/Zy7DKRZ7i/nKB
         M2VXXzLC1U7vfwVJAclrhyvdLsuwz/YY+Ox5j2qN3KihwuuwYr5cr+/XRiGHcrwGjds8
         UX+G9p+mMq8qru+3gv6Vl1WY2GqoxCEZ/9PspdWlQrpIU+u/laAhNz6TJRQ83mZJhBHl
         hn+TpexczxzAQdNM+VlpCaBAAcTQnX/jSsuvDoJD0xx6i9ajypd7zsUgnppPkbkqi4fI
         6tEronm6cKnDjGy1P71USLczbUUVpt2CVYSa/bm6BUcROtYSMSjAw2+o+4mxHLm+vX0e
         BcrQ==
X-Gm-Message-State: ANoB5pmB6HNbIpBnb/y4WOUUMiI9ZL2AzkeCVOHGPFw+rY+N/x2OtITQ
	ZRV4uwo4lLDCuLcgtOzQsqnP7VKp5fQyb7MPQ/o1zE2LvDE=
X-Google-Smtp-Source: AA0mqf76ozVj5j8UbOY/Sf588f7MkAuXY2hxb172t+3k8aQEM59j+DJN5D4AJDhDV9LEuzS0eS2VR9VsJTITARKyXCw=
X-Received: by 2002:a25:4fd7:0:b0:700:e0f1:6335 with SMTP id
 d206-20020a254fd7000000b00700e0f16335mr5097151ybb.520.1670262290963; Mon, 05
 Dec 2022 09:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACvgo51HZVDcmvHiaZK3XFJyp6LUGRFEM+G=5j1--av=XWni+w@mail.gmail.com>
 <d2df3b8c-2b0e-b587-bd04-4892e4e84f5c@gmail.com>
In-Reply-To: <d2df3b8c-2b0e-b587-bd04-4892e4e84f5c@gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 5 Dec 2022 17:44:39 +0000
Message-ID: <CACvgo53tii9sLJFcmsPymJ-8HBZjvwpuBR4DNKYLNVdoGFY3_Q@mail.gmail.com>
Subject: Re: WPA3 SAE passphrase limitation
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Dec 2022 at 16:58, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Emil,
>
> On 12/5/22 10:19, Emil Velikov wrote:
> > Greetings list,
> >
> > I was playing around with a router using WPA3 Personal (only) +
> > CCMP-128 (AES) and noticed something odd. Namely: the 8 character
> > limitation imposed by WPA2 is enforced with WPA3/SAE.
> >
>
> What 8 character limitation?
>
On all the routers that I've tried the WPA2-Personal passphrase must
be at 8-64 characters long. Anything outside of that and the router
will refuse. Although I admit that I'm not aware if that's required by
the spec or otherwise.

On the other hand I can use a passphrase outside of that range with
WPA3 only routers.

> > Whenever I try to use such a passphrase (via iwctl) I get an error
> > "Argument format is invalid".
> >
>
> Refer to crypto_passphrase_is_valid() for what we consider a valid passphrase.
>
> > I realise it's not the best practice but the exact same router just
> > works with my Android Pixel phone.
> >
> > Would anyone be interested in fixing this bug? Alternatively any
> > pointers where the validation happens would be appreciated.
> >
>
> What bug?  In theory the passphrase can be anything for SAE-only networks, but
> since there are plenty of cases where hybrid networks exist, managing separate
> SAE and non-SAE passphrases becomes tricky.
>

Whenever I try to use short passphrases ("testing", "foobar" or
"foo123") with a WPA3 only network, IWD fails to connect as mentioned
earlier. I don't have the spec to confirm, but this sounds like a bug.

Can IWD detect if the network is WPA2+WPA3 or WPA3 only?

It so, would it make sense to omit the `passphrase_len < 8 ||
passphrase_len > 63` restriction in crypto_passphrase_is_valid() when
the network is in WPA3 only case?

Thanks again,
Emil
