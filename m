Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42A6331A70
	for <iwd@lists.linux.dev>; Mon, 23 Feb 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867874; cv=pass; b=DruaKr4UyBZp1H0hvApI7nxAvU+uFjZP1F/6d4i3jUa1Bw7uWA2/GoSuBNSDGctiO2Svyg5o/kZZGNa0RtJMrSp3BH2/v2qN7gE357G+1MkrHlEVzFGJ4+iTtdyjuP4ehn8RpaD692X3GWieVC1SL7jIPTzYh2lAfgHzy2ZJ3Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867874; c=relaxed/simple;
	bh=J3JxO0uDadCUiQOxk6Jvb1O0l4XMk3dcALoxXqO1oFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mFVBByMAzi040rHsiX1Sor4VA1ta3qMoR+VdGWaAnZkON4zFn887XRf7s+l3oAsLEOlbV9qifUlPIXkrY0VTAqpTx5CNUZxLEpuKU+xdf04HlZu9SFr7maCYWoyQK1dZaG5wcEl3Mh9PzfTTwXuBXcRFUOpIsUvaEOSOrspNRzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig6TxTtk; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig6TxTtk"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45f171cb842so3326465b6e.1
        for <iwd@lists.linux.dev>; Mon, 23 Feb 2026 09:31:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771867872; cv=none;
        d=google.com; s=arc-20240605;
        b=FEp8D2bJWEAHswOijM2hBCUT4Y+paEQ1m3v0UmYX+9eX4Dcs53hnubtZ5BuBItemx5
         AvaZ5DI+VGSVR2eNXJDKnPodYfFroujxjwQ4Fiu2gMnJKKLM0D+qJL2zYNUGHupbIZ/x
         KY+y5AbX1Su5Iyub0jl1yPf+cFsXwHVqe0+jReE6pbmd4FOyq/tguskFnLw1xEv/BUkB
         W4ee5jf9lCg3pwA9+ZzNPF2/WgT/sb3AOq9OgyBftLtQ/apdX6zgbpXOo34k/3oZo88o
         ZRvi03W9Eflqyuufyxp452+1OXZLWEJ4Jbx8eWNXmyT4c98e6oh7azC5Qrv73Dv6ThVh
         20mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J3JxO0uDadCUiQOxk6Jvb1O0l4XMk3dcALoxXqO1oFo=;
        fh=LVwSdJJT2poHpWJpvI73c3fFqaJVA08Td3ZAiex6+kI=;
        b=lFDotpRT3A8jrYTQKmATX3TiFFMZaqLljYTJG+VAvpUXuu90niKb8J9C3021ol0QtT
         UXDesRndZBUAhxtMMvH+3xux62gy1O0ham/5AcZc9wANQsdNRlaUjkOxIL1yWKBaCb3F
         m7Xc2ae3NH0N4f4aAmovEci+NAmF6ZlgsQ9V2bl2TNf9i0ae2UTidAjrKFDTuYB3ufuQ
         MMt+xW54XlvmA0ScBMtUw9YsCwFG5X8GftBuSMxMxaUSxYjulmUS2o4znAAwTX4sVuaP
         RYXzF7nMJx0BIIsN+GGoQGOoX4/+oao1kC613IE/xAmPPCB+kCsSdMUdvkYpqJd7ugly
         HyVg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867872; x=1772472672; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3JxO0uDadCUiQOxk6Jvb1O0l4XMk3dcALoxXqO1oFo=;
        b=ig6TxTtk6XGdyo/Q4rIGCNAwS15j+IUxeC3jrioUbNxT8O3M1CG0o/zyAUWDJjzplI
         Y7d7EHIt3rostOeBuOIHCyXLez9hTpZqvOEK3Tcu67kcneWc6X/eAkCQm0g92PvqbHsK
         Vp/dIMOJH2GCPKJy9cxQ9krHjZ0Zv0WxtkzfWG7OfvHiHe0Q5GkXGk52Cal/BLD6RrSZ
         aJDUMWOxy7nRfz220iUiVDNv7aK0X4xGu+rGb89a4KkJdGp/IW7eP6qkU/+u/V0ceUXy
         PPxskGxsGEaGCH7Luwhm9JnTrVSj6v+cCr8JWFZe0tSZ5JFufcI5dp6NZt++WWQmaQzY
         ZDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867872; x=1772472672;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J3JxO0uDadCUiQOxk6Jvb1O0l4XMk3dcALoxXqO1oFo=;
        b=dVtNBDDI80scBlInnRpwooDNRjlju/d9Lwu/H9JLFaoDsuWGKWHbTptEm56Bi14zuz
         EpvWgQyfkVBRC1Tdgto/hKBo4S9Sxvy49btK6p7yheZw56iBSxB48kJQRmOtHgVg/rUu
         RU6tBXMVDMXfDosvXb5gXx/F8PsLwzYh0KjXymbuTbEo/HgPtUg1HVvbQF1vVYIa0EL7
         jV1LchaesuDZOLQOrw5iyOUE0E7UucW1/XBbLxQVlGHQpB1AiVhGI1ejZbJvZefl71Ns
         fJDi3jgOxIUD3YJg55S+7Iw0sqrCSfkBSj6kvY14PYXjF8eegZCcJgyRz53V/q5o5IT9
         Hqtw==
X-Gm-Message-State: AOJu0Ywd5i62SyAJnLVgdb5xYHTm9GDSv34IeLUqnUHQLU+5ymleP068
	G6ZXN0gKSnod/IJ55NgADYDh80J+KulohpPjzWLoQnoUPyi1iR+qHXzVajaGRk+s8xgFn0FBszU
	KyL84fvVvDZ9Ur393p1aqnZqKlqKQ3BTVXk7S
X-Gm-Gg: AZuq6aIEaO0nLQuJZ7eoebq2rqQcshIiy5nMo2vH2nkr29jW9jRQjJ6ZLwYHhcwlHkn
	DlMTKGUOsTYwnTwtwMjeMorvsNzbCbe1KpNlvKdReUa9NjYShz/eNWkgzCDM62vLEfVTtRyW+Cv
	TkAIfy058GSTGfWT/D1U0tb0U1tE76US0JicNOXuXtupD/sBQ7+UxYqvgJISyHRfrpeejnBqLIh
	URJNxgGuMcMtTLmZsQwcoDUtm6wFuoZlAqaYPAMYLw+vtOVCYWY3GzywvXhkYKtYUT6wITDx7yN
	/fdkdQW33g==
X-Received: by 2002:a05:6808:308b:b0:450:d4b5:3527 with SMTP id
 5614622812f47-4642761c69cmr7747417b6e.24.1771867871825; Mon, 23 Feb 2026
 09:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANZiGuEaFwDLHD8jGk4-POxfnJAWeER1ss7COtur8b0ohEi3Fw@mail.gmail.com>
 <72a14187-ae0c-4de1-898c-c416de541e7f@gmail.com> <CANZiGuHAzX4GDQvEKHDRoWF-CMdaR26pVarEzr1PSG6HLyrj3A@mail.gmail.com>
 <baacf3fb-aee1-4b9a-9d42-0e5909719091@gmail.com>
In-Reply-To: <baacf3fb-aee1-4b9a-9d42-0e5909719091@gmail.com>
From: =?UTF-8?B?Um9tYW4gxb1pbGth?= <roman.zilka@gmail.com>
Date: Mon, 23 Feb 2026 18:30:59 +0100
X-Gm-Features: AaiRm51syG7qByYyzDqgGIm5bVNlhYoXIre9BWIQnioe4SxIQzzTYwS6CuLF17w
Message-ID: <CANZiGuE+kw9pRM1MvNjY0uJtcWh83poiWwZK2ULGTrk4dBQS4g@mail.gmail.com>
Subject: Re: systemd-networkd MAC address randomization stops working when iwd restarts
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 5:57=E2=80=AFPM James Prestwood <prestwoj@gmail.com=
> wrote:
> On 2/23/26 8:43 AM, Roman =C5=BDilka wrote:
> > On Mon, Feb 23, 2026 at 2:36=E2=80=AFPM James Prestwood <prestwoj@gmail=
.com> wrote:
> >> Looks like the issue is in the configuration. IWD removes/creates a ne=
w
> >> fresh interface on startup, which conflicts with how you want to use
> >> randomization with systemd. If you want systemd to manage the interfac=
e
> >> you need to tell IWD to use the interface systemd/udev creates by usin=
g
> >> this option in main.conf:
> >>
> >> [DriverQuirks]
> >> DefaultInterface=3D<driver>
> > thank you, that fixed it. It has no bad side effects, does it?
> >
> > I have to say, the situation still looks like a bug. Having systemd
> > manage the interface and using iwd for 802.11 is a supported
> > configuration, I assume, so iwd shouldn't collide with systemd
> > components then. Also, I would never think of looking at
> > DefaultInterface: there is no driver quirk, the name sounds unrelated
> > to the issue and I actually don't understand the terse description
> > (what is a default interface?).
>
> Having IWD manage the interface was a design decision made since IWD's
> inception. But there has always been a way to use the interface the
> system creates via "default interface" options. So yes this is a
> supported configuration.

Oh...

> I'll admit, the use of [DriverQuirks].DefaultInterface in this context
> isn't typical. The reason for this option in the first place was because
> some drivers didn't support removing the default interface, or at the
> very least would cause issues. brcmfmac is one example. In you're case
> the driver itself supports interface removal/addition but you're trying
> to also have systemd manage the interface when IWD expects to manage it.
> There's no other way to tell IWD this situation except this DriveQuirks
> option.
>
> In case I wasn't clear a "default interface" is the network interface
> that the kernel/driver creates during initialization.

It would never have crossed my mind that iwd might remove and
re-create an interface in the first place.

Anyway, I'm off the mailinglist. Thanks again,
Roman
