Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9029A2
	for <iwd@lists.linux.dev>; Tue, 30 Apr 2024 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519648; cv=none; b=ELWculZNsk24uHLntUMVx1uUYX+0oo2JveX7Hbw2d72wiTfFOAAjDl/f1ENzZUChOcN4v2WGwVmt9F3pqyV2CH53F/D2SC6ilvuEFy9Jf0WDypH5eEE5ZOTjkpxM5xErXnnU18YBwELAQh2o4mbkyTN3U+J7tHEUmlIWvwPUt64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519648; c=relaxed/simple;
	bh=MFvI1XXO+gRjYUvI8dMJfn4GX6jRrnC/FCZ4mIrdsdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5IrCCZ3fllQEsR7QoHhUWEDy2DfCcxYI2Xj2f7MCdhU0gA9he7bJr/1b+ztUOVepONueQkTc7FHy/3HjtAcictFxzmDx0Mzbq/3o6VWS7xOBIEYM5g72dPT4u4HIYlJrZREnlyOykVdWrplPTq9D/bQN2zhfIId393tfB7zAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4AqWp5E; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4AqWp5E"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ae913878b0so4757986a91.2
        for <iwd@lists.linux.dev>; Tue, 30 Apr 2024 16:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714519646; x=1715124446; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yH+AsK7ocY1NZH5Kr8udP5SU3pU6aPB5f9VVjmLtpw=;
        b=X4AqWp5EPYRlTIVFNJkYfFB+A5jdvW/QYHEQZdUcXPBY1BcIv9yDOBPTACLRWeEahY
         xUintj1RYmL8gh4lC1FjYjWnVPiaXV6yy6uz0T/vIhGugqhZ1ZjX+JeRmShv1/HgzwWi
         mSp8fapm31aXVakKOaK3EgZliFfaa8zR6t8j+ud7hk0Bj0m4e9PCKnFCynUym4WQ1lwp
         +EUNlhaCFypQtjqNl5He+uiMtblJfXrstmJ1CBKjJ92rRU6X2o7Wt5qeAkEF4jFX1qW5
         8Yi960mshO2QsEb8rYYFarT+VKzRr8ryxVGTSiyjp+Av36vtddsmkHa6794k0SkrY35d
         aCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714519646; x=1715124446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yH+AsK7ocY1NZH5Kr8udP5SU3pU6aPB5f9VVjmLtpw=;
        b=RUbBc8nIFwnzyLFl/U8a5P2wS4MzLUDmAA2w7LDKMOargVs4V2OGyNOnVdwbzGETR7
         3vUu3zOxun15DdrFb9SoRnikuupI/pJtR2cMzpq7xPfYf7hJG1e1Qn/1n0GNFpavwtA0
         YgVdxe+/2GXUo0xcctWRVKcrI5YufqLqL0ItLhKNYfGXIbsx5xjkoXy8FHDD+Hu7zYN6
         AIyaczE3lFP3fnFxrCq+Yb/MDh/3JrIYJFzTsN48SYT8ALM1MwYBtjP45W4hMcSNFCoV
         sGblPrrnvjXfimq2TaXRUKofdR1tg6vJaOVbVXTDblrmPMQidzrghw4FUYjV+Up7ZBgy
         sVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG0pNbjacJ2K0KP4Kq/QOlghQ+Y9uh+vTrecRBC0zFaQ2WzNdWuTc0uYcrDpOzdKq5olArUD+tL1wnsbO7sOWj7dh/
X-Gm-Message-State: AOJu0Yydfso/fRauoN96Q/o7eSgMsGNWBneqF33A3hYVVIEPek9i9yRo
	dLbbSdGTtB3uTe6Jha2A5hI9DnWVSWhWPld1zIwIKvOc7aHFEXCrtcoM22fXpLZxNXIyiBE/LcJ
	5zXIWpL6N9nb43K08L/eM7y+Pbd7iHUrL
X-Google-Smtp-Source: AGHT+IF9lQZnv+n0364Hbyo9bYUXLisYieU9XE11AqGYUJAHZmRFGatBuu5jX9A6MTdvBVUwAPFrObxOeE+5TbP8Vz4=
X-Received: by 2002:a17:90a:d48b:b0:2a2:1900:493 with SMTP id
 s11-20020a17090ad48b00b002a219000493mr822222pju.40.1714519645651; Tue, 30 Apr
 2024 16:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240421125050.6649-1-brandtwjohn@gmail.com> <13851d8a-e91d-47e8-b9c1-0b1e7369edba@gmail.com>
 <fd8371c5-38a4-4302-ba1b-fa4577c5492e@gmail.com> <32416c35-4279-4e3a-9633-89cb71c7ce1d@gmail.com>
 <6d9bac04-4522-49b3-879c-809b7e4f533f@gmail.com>
In-Reply-To: <6d9bac04-4522-49b3-879c-809b7e4f533f@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 30 Apr 2024 18:27:14 -0500
Message-ID: <CAG17S_Mw90_LsvHdWix0hhfFAZG3V6_7-hPDJc=DCU72ckOekA@mail.gmail.com>
Subject: Re: [PATCH 00/11] Basic SAE support for AP mode
To: James Prestwood <prestwoj@gmail.com>
Cc: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

James,

When this is ready to go, I can test on my Pis...

Just need to know how to tell AP mode how to use wpa3/sae

Keith

Keith

On Mon, Apr 29, 2024 at 7:04=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi John,
>
> On 4/28/24 5:04 PM, John Brandt wrote:
> >
> >
> > On 4/24/24 05:07, James Prestwood wrote:
> >>
> >> On 4/22/24 6:52 AM, James Prestwood wrote:
> >>> Hi John,
> >>>
> >>> On 4/21/24 5:50 AM, John Brandt wrote:
> >>>> This set of patches adds basic SAE support for IWD in AP mode. It ha=
s
> >>>> been tested by connecting to IWD AP using wpa_supplicant. Note that
> >>>> this
> >>>> does not yet correspond to WPA3, since WPA3 would also require the
> >>>> support of Management Frame Protection.
> >>>>
> >>>> Normal client functionality has also been confirmed to still work.
> >>>> After
> >>>> applying these patches it remains possible for IWD client to
> >>>> connect to
> >>>> WPA3/SAE network.
> >>>>
> >>>> Remaining TODOs are to include better sanity-checking of received
> >>>> frames.
> >>>
> >>> I took a quick pass and I'm impressed you took the initiative to
> >>> implement this. I do need to take a closer look from the spec side
> >>> of things but overall it looks good.
> >>>
> >>> Assuming we are compliant with the spec my only concern merging this
> >>> would be the TODOs. You do mention this is experimental and certain
> >>> checks are not done, but you'd be surprised at the number of people
> >>> using IWD in AP mode. The minute we merge this we're going to have
> >>> people using it, which in its current form would be insecure. I
> >>> think we first need to get the frame verification implemented as
> >>> well as MFP. But anyways, this is a good start and I'll give it a
> >>> full review when I have some time, hopefully this week.
> >>>
> >>> Thanks,
> >>>
> >>> James
> >>
> >> Reviewed. I also forgot to mention the CI we have showed test-sae
> >> failed after your patches, so that will need to be addressed as well.
> >> I keep getting reminded I need to also email the patch submitter.
> >>
> >> Thanks,
> >>
> >> James
> >
> > Thanks, I've mostly incorporated the feedback, and also added extra
> > frame checks. I can post the v2 version later this week.
> >
> > I'm unsure whether I'll also have the time to experiment with MFP.
> > Maybe it's possible to already add SAE support without yet mentioning
> > WPA3 for the AP mode?
>
> MFP may be sort of automatic, it is for station mode. All IWD does is
> some minimal validation since it has an explicit profile setting to
> enable/disable/require MFP. It also checks the cipher support related to
> MFP. But I think for AP mode all you'd need to do is ensure that
> connecting stations are capable of MFP when connecting via WPA3. And set
> the proper bits in the RSNE.
>
> Thanks,
>
> James
>
> >
> >>>
> >>>>
> >>>> John Brandt (11):
> >>>>    ap: ability to advertise PSK and SAE
> >>>>    ap: accept PSK/SAE in auth depending on config
> >>>>    sae: add function sae_set_group
> >>>>    sae: refactor and add function sae_calculate_keys
> >>>>    sae: make sae_process_commit callable in AP mode
> >>>>    sae: verify offered group in AP mode
> >>>>    sae: support reception of Confirm frame by AP
> >>>>    ap: add support to handle SAE authentication
> >>>>    ap: enable start of 4-way HS after SAE
> >>>>    eapol: support PTK derivation with SHA256
> >>>>    eapol: encrypt key data for AKM-defined ciphers
> >>>>
> >>>>   src/ap.c    | 135 +++++++++++++++++++++++++++++++++-------
> >>>>   src/eapol.c |  58 ++++++++++++-----
> >>>>   src/sae.c   | 175
> >>>> +++++++++++++++++++++++++++++++++-------------------
> >>>>   3 files changed, 265 insertions(+), 103 deletions(-)
> >>>>
>
