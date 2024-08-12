Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CC4964E
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723425593; cv=none; b=Oo1eGr7L/NN0spHw2Qu4iqleSUOkKuQbu9QZMmaOt0Jc1GYkyvhSX82/JhdVG7v9PxdCipN6JwsSXG48U6PLVXz0lC03LQyyy8gKtOpRVt7fT3zoNZki3fV3wBmhrjBtu/FwpppdcPQVMfrhfbDV/lPJOkkMNLtLa/bn/BcoDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723425593; c=relaxed/simple;
	bh=j+iTsvBG9NqaCEXyUhxxvEx3C/yVrmgn/iqVWCf/3VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsbUJNAAKYYbOZpkCUJ67bVv2p+Ou0vS/RksnIIE5pOVUzyM4GVlENHKeUEH7rmftdXQOzHkpN1oWOBb41bk3DfQ0AEhUGCgRyhg9uVdwFJN9mnRsHz5wnnwK3ufVnr9eYVEdd7vWLAdGMXfQK8mcTZK/Q9IBDCHBVADHXckgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC3WcbL4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC3WcbL4"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c1324be8easo2911198a12.1
        for <iwd@lists.linux.dev>; Sun, 11 Aug 2024 18:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723425591; x=1724030391; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO1on6Jh7E/AxP/1dTPpssvBQRS5gK9/hFxABjcK1io=;
        b=ZC3WcbL4hG2FfT2KvlsAYX5PnRC3fp78S0agaRGHJKfVtMqjVj6pMd+Z49nRTuGM2N
         2N/0Mx9FsLEcRb08f01oIsh5hio7Tbpc5SER1BTnBR3FsNkQezQf3uKKS8fevjupcd9Q
         9xLmmTb0v2JHt/qewqnyJL+HbTSsVlIubTaJ06fxWHauna7Qc9IxfEAK3rNbB+b3lJyA
         T0uikEjSkBmTRNGJRibvX49x21SJRcQtuPaCQMiuPD3qQm+R6Rb5fcFgiMH6Yvp32g3B
         M6pMBL4BzB6xG7vPEyfHu2k6uyMwhLE5a/pLaNBv7KWEErc1v1U52fPfB7/LI2WxclBd
         YtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723425591; x=1724030391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BO1on6Jh7E/AxP/1dTPpssvBQRS5gK9/hFxABjcK1io=;
        b=ow4QEv6c8txPFVRZ98OVGxPgKcUSX8+vleJa3xUMUPgR/K9lzodF03UpWZrlgwcJBN
         rR95h3Bk5LuaqIOWVYey7oCPEdfzBgn2i+WKk3SnDCqb+EB+3EUi/UOvdhOQI4RsRIue
         qgkqvYmIa3n0wTuHtCH8i34QnvRLMuULLWQXKcWrLubTS7WPfCo1H0Fn3fujbWEGc5t+
         XmZ6iqFgMzYAJl/d+z/T/mpUsTwC4AsvaGlFcD925ZctY5UvW/DV9hEUWUkBVfNZRqRc
         BUdSE3JyUtFwj1rqNp2w5B3cVPnclxeIOPCi9uF+bSPq6urTS5IsfiYqY5HOeu5n9WvD
         elhg==
X-Forwarded-Encrypted: i=1; AJvYcCXLnWshwBrMMCnuDjDpSzY5gpbMladjUvWkylCHyPdatlS+5YrIUZUm7FIuliCFHyc5LEEKhvj2geFmYAyAtRT0zDB4
X-Gm-Message-State: AOJu0YyUrNRg+RtBC0LOj6uAIB1X1labB+W3fMNGHYcLnCTwcPIyhAOJ
	T1KYYeStW6FoV/ByWIXzRtrYkt5DnWK73j/DpjjxzMnCW5mcEkZu5+2C4ieMqcd2bFhNEpS4L1B
	DAFynYckPXQPPygdkqLa3VFnzyKA=
X-Google-Smtp-Source: AGHT+IEq88ex5gToNupCNWo0uk0zlsrr5igZvodx3UhmFuncFHNlWqXin0LIzp8BR3Lb1xMbwsN3/WPBwGC2/wmU8Hk=
X-Received: by 2002:a17:90a:4e0f:b0:2c3:2f5a:17d4 with SMTP id
 98e67ed59e1d1-2d1e7ed39f7mr12504361a91.4.1723425591166; Sun, 11 Aug 2024
 18:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
 <ef38aa12-634e-4870-888c-219c961f301c@gmail.com> <b0ef10a2-c30b-4b6c-8370-66f9e0ace7b1@gmail.com>
 <CAG17S_P_MO4_BZYTCp4WDkJ_q4j=0s_s3azCOWrsvqmLD0ravw@mail.gmail.com> <de951e97-547f-4c14-841c-267f64b0020b@gmail.com>
In-Reply-To: <de951e97-547f-4c14-841c-267f64b0020b@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 11 Aug 2024 20:19:39 -0500
Message-ID: <CAG17S_Oh_1NS9SUSadAJkMXtJ3s_AjMhnUDSqrKMzEiO69jBPA@mail.gmail.com>
Subject: Re: [Request] iwd to support brcmfmac 'SAE with AUTHENTICATE'
To: Denis Kenzior <denkenz@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 2:38=E2=80=AFPM Denis Kenzior <denkenz@gmail.com> w=
rote:
>
> Hi Keith,
>
> >      Supported extended features:
> >          * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
> >          * [ DFS_OFFLOAD ]: DFS offload
> >
>
> <snip>
>
> >
> > The pcap is uploaded to my gdrive:
> > https://drive.google.com/file/d/1vIuje60MGFPklcXtSNMi9-IOlV_6sBJ8/view?=
usp=3Ddrivesdk
>
> What is the PCAP supposed to show?  There's no Connection attempt in ther=
e.
>
> >
> > Hopefully, this helps to get started.
> >
>
> Anyway, I was curious and snooped on wpa_s from git trying to connect to =
an
> iPhone 12 Personal Hotspot (Maximum Compatibility option off, so it uses =
SAE).
> Not a pretty sight.  Firmware fails with errno=3D-52, Invalid exchange.  =
Has
> anyone from RPI team actually tested this firmware before pushing it out?
>
> I also tried the old firmware with SAE_OFFLOAD bits, and that doesn't wor=
k with
> wpa_s or iwd either.
>
> Until someone sends me a iwmon trace showing CMD_EXTERNAL_AUTH exchange w=
orking
> on an WPA3-Personal Only network, I remain skeptical that any of the Cypr=
ess
> firmwares actually work.
>
> Regards,
> -Denis

Denis,

I did not attempt a connect with that first log. I misunderstood what
James was asking for. I tried connecting
with my Samsung phone and was able to connect so it seems that the AP
is working and allows a
connection from my phone.

I tried to connect from the Pi with iwctl:
https://drive.google.com/file/d/1f1jnD0EUOJSaJXd8l7uYG9nisAxCPeo4/view?usp=
=3Ddrivesdk

I uninstalled iwd, installed wpa_supplicant (built from git) rebooted
and tried to connect with connman and collected another pcap and it
did not connect:
https://drive.google.com/file/d/1zuVSF0xu4Nk2fN9ketBSv1tiquT-Sc-p/view?usp=
=3Ddrivesdk

I then tried from wpa_cli and did not connect. I tried again with a
wpa_supplicant.conf and also could not connect.

Now I am trying to figure out what I did to allow this connection to a
sae AP... Now that I have nlmon
module and iwmon, I will see if I can re-connect, somehow.
The brcmfmac is such a pain.
When I get a wpa3/SAE connection, I will make a pcap and post it.
I actually was able to make one with wpa_supplicant once and actually
passed data, but it does not seem to work today.

Keith
