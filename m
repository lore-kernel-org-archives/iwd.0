Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745F23AC
	for <iwd@lists.linux.dev>; Tue, 25 Oct 2022 14:27:46 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id f205so14819929yba.2
        for <iwd@lists.linux.dev>; Tue, 25 Oct 2022 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lp430r2heOgRbr6DLbFreGdiJmk3+f43LvzbEwIzGJM=;
        b=IwgwZt+g6d38OLkVCwsuI0Hp1yUKg7adyeCkH94JZkPNz0X4BLg9nXbHBL2ASbv9cl
         q3gGN308wihXBRm+8MpQDI2IxckMGjTHy2Z5TKrqvjFY4jd1cIhpoZvN/MhYvSCmOhvo
         oOytY0vYe78X00rbAe6WIUdWqiZxwfndUdxZmDsHGFYqArS4mUT0y6LndruYqVqfhpyk
         tzf9ZVfPgwVOc3pB4kVUGqn76SUK1DR1e99WqhyKyv9bGSexXT2no00IojJuoCf6blP0
         iZsh1nc4BuSE0ydiVL8qa7Sx7cXFLLF2gfAyiLteiO85v0kCc17MzLN0OkXXDvSo9ncb
         cFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lp430r2heOgRbr6DLbFreGdiJmk3+f43LvzbEwIzGJM=;
        b=CpO8cLFnfraZ8/Z+Twn00LMtbJQ2d1aUdqGpELOY/PVp21pybqR0XZIThn6Iu3B6e/
         b3A8FV1SkXXy1Qc7VUKTi43vEMJ/+Z6JJtlaqkWG3t0sw4gKjf936n1GMTwqUBHyFExN
         T16+7vSB0lK3HS1j6fII7qwY4RbWmWOtuRA791XVc8jq6IBtmLJWvFMyC8kma7qdJVtk
         VHNESbjZj34iGXqSBsE2zWTB1LVKtipbed/C+w0rVMYlADpKt9yO0tlW+uKZhCcJvG3I
         AKn9QJ7Y1nk05A1IPPohbTlaf6R2gMyEppgmqHt5h6G/AsSOvkDI2Jo/B7ru1awJ45+B
         yBEQ==
X-Gm-Message-State: ACrzQf1lgchpsIEvQgoGjTugjgYTn/WOq2I7BjUZ/uQQqamrCbALvjkD
	GRMCVPg1m15l1CuuwGxTMvP7FnsbkZvVsRq3LwLtbNcZlhA=
X-Google-Smtp-Source: AMsMyM4vXU8yi8rkmHF7Juojyz1ZQke2VkSOW70ADlbzqKdEtPeFfsKWFVU2s/XtP6h8u54TLimxQq8OuXqoEq3ubSs=
X-Received: by 2002:a25:5:0:b0:6c5:3855:d87b with SMTP id 5-20020a250005000000b006c53855d87bmr34922626yba.84.1666708065770;
 Tue, 25 Oct 2022 07:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACvgo52+1i7iZ-vzqf1RUpZvMa3-EgaDoid=Y9dch4=d_dq-5Q@mail.gmail.com>
 <772f09aa-fe9e-708e-2ec2-a89f8784d391@gmail.com>
In-Reply-To: <772f09aa-fe9e-708e-2ec2-a89f8784d391@gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 25 Oct 2022 15:27:34 +0100
Message-ID: <CACvgo50aJHxkC-3E7OHDfjkyH5Rrp+Za+F-ATTCs8w-oX=dhcA@mail.gmail.com>
Subject: Re: GCMP and other unknown ciphers
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Denis,

Sorry for the late reply - been busy with some non-computer stuff.

On Thu, 6 Oct 2022 at 15:34, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Emil,
>
> On 10/6/22 08:22, Emil Velikov wrote:
> > Greetings team,
> >
> > Recently we've noticed that IWD fails to connect to WPA2-PSK networks
> > whenever GCMP+CCMP cipher is used. Browsing through the IWD code-base
> > it appears that it lacks support for GCMP, GCMP-256 and CCMP-256
> > amongst others.
>
> We do not support or select GCMP. But I'm not sure why this would prevent a
> connection?  We would always select CCMP instead.  See wiphy_select_cipher().
>
> Hmm... maybe we reject GCMP at a lower layer...?  Try the attached patch?
>

Now that I've got the hardware at hand, it looks like iwd does not
list the network at all. I will try your patch and report shortly.

Details:
 - Nighthawk X10 running dd-wrt
 - WPA2 Personal (without SHA256)
 - CCMP-128(AES) + GCMP

> >
> > Was my analysis correct - is GCMP supported? Are there any plans on doing so?
>
> No real plans, patches are always welcome.
>
Do you have a rough estimate of how much work that might be -  are we
talking about weeks or months? How does one get access to the 802.11
spec these days?

> >
> > Somewhat relatedly - is there a configuration knob that one can switch
> > and let IWD fall-back to the other supported ciphers? In the GCMP+CCMP
> > case, we can opt for CCMP for example.
> >
>
> This should already happen.
>
That was my assumption as well, yet empirically it does not.

Thanks again
Emil
