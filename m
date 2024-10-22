Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75E1E515
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629889; cv=none; b=hycF/L60fhbsFzuPNhV7V83zfYk6JvYwh7J5KsEqiNBdF/iq3Z7ApoTeznycch/XRRvi5jLTWvyuXYmbh55yh0kxTDUufv6KoDDLQUXTNfMUA1j9dAIVio+B/Xbg/bFpH342whnx2wNgnFwOE2+482KbNdD1qWHmC74HihiSXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629889; c=relaxed/simple;
	bh=t9EeFt/5qOdpxtFEAUunLsuUzKTJUMd85w8fVbG/OTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0chPVW5rtvzsuipf2KomEeeTrz8dbgQMRC7+9A+o7bHNMPJCvlOu7ne3HkbhhoJlbzAHZi//6Ry/hEfJeA6VlOxsTyfRP3EI//jYlrS86E8CfLngayfsPHP/IlMzjwCR/xBaWMaPJ9v0pId0LbPvzt6FarkrZZlevpyvsCcTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRQF/gEq; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRQF/gEq"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e61a779148so17708647b3.3
        for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729629887; x=1730234687; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YR+h347d0w3wX5J6Ueeid48ssON3DB36SNi3KGV/m5k=;
        b=jRQF/gEqxpMqC7I/e5jEdwU/lg2GZEivWIhCqaa2Y0ZBRY0r9mAvSs4EXnRzbMwMMO
         J/SVavPZOS7MPb7LQe2NU421EKafyxJ7tkk5y4MXzJhi56Ep2I/d7HJbGe7tHxeTNO28
         AeyZokzEZnsVIaxV4bSPtNfluIx5klOjfyWao6qZVFJ4mLRUC2rnTrsMGuN5lTZjuEQe
         fKhtP71p9lcF1PaEeNo2MFK2+2mPNoch9zDtEfUpJ8Xz9xqjyfhWcVJd/Ga1mFIsMCuF
         OxGBlqwM4vu3onHKz8hNvVmf2B78FKrbjXbAgdZZf75EkrE0XFLXLQiRhgtUa7k3KtGS
         Wgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729629887; x=1730234687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YR+h347d0w3wX5J6Ueeid48ssON3DB36SNi3KGV/m5k=;
        b=O0bM0TP1UCCy+/6aBhNddwVS+WKqaDV1/bWeNscbwz3uf8o0j1Qo5dSDvvwsK5ArzX
         loYa1x3Za/y705f5qKDc2bcnI8ylTIkGOkn5gXsMEwsjCx7cUH6ZWBLHHOKwQwlREYyu
         /4RYYhmDL2/DUdhChKo+kNGgUkzGZ4GB53LUsc34A/ltnCei44tEXpNgL2PCrYGjk3Ii
         ws4WlNF8M8u818QTrSQ5gIdZrmeD1cIblcDhTeEiORvMMxXrYHZnboiSoG8MqDpW5iFT
         6pT5HonnzUxh3MYsMOfpE9pjQctJT3uJ7g5COQbxSemGkJSa5M0xqXCA/AnDhouSoaQE
         MpuA==
X-Gm-Message-State: AOJu0Yy9cLRwSVUiJ1IEeIacLIBsEIW0LYrP5Cea5PxO4w2kKtl8+WWR
	M1/q0aCNy/I8jZ1jywiOCrl+wb3xEBrf95yOMgK4uxBB6kARE9yiKPos/HKfFcyOfL+BX+Em0nc
	w3EU2Z86QPcQSqK+10yfA2F6BxPR7/lIy+OI=
X-Google-Smtp-Source: AGHT+IFJGiW6mDvHCPJjL50P3OgszuKfP/cESEZZFgKtf+vM/i/25/O7YFDhf5cD8D2EfQH1Bq6VURJX1/YM6F9ExXE=
X-Received: by 2002:a05:690c:2b04:b0:6db:e045:3b07 with SMTP id
 00721157ae682-6e7f0df59f8mr3076117b3.17.1729629886874; Tue, 22 Oct 2024
 13:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a10efe9d-2b00-41dc-96bc-af02e7581f0c@molgen.mpg.de>
In-Reply-To: <a10efe9d-2b00-41dc-96bc-af02e7581f0c@molgen.mpg.de>
From: Rhys Perry <rhysperry111@gmail.com>
Date: Tue, 22 Oct 2024 21:44:20 +0100
Message-ID: <CAGTBY+uAGOoq5wWc6LVcLd3tB=a95R6Ox86Kfs_-t1nfEur-Aw@mail.gmail.com>
Subject: Re: After switching to iwd WLAN device *wlan0* not renamed to
 *wlp58s0* anymore
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hey Paul,

I believe the behaviour you're seeing can be described here[1]. tl;dr:
is iwd disables predicable udev device naming by default and you can
fix it by masking the unit file that does that:

```
 ln -s /dev/null /etc/systemd/network/80-iwd.link
```

Kind regards,
Rhys

[1] https://wiki.archlinux.org/title/Iwd#Wireless_device_is_not_renamed_by_udev

On Tue, 22 Oct 2024 at 21:31, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Linux folks,
>
>
> I am using Debian sid/unstable with *iwd* 2.22-1.
>
> Before switch from wpa_supplicant to iwd, my WLAN device was renamed
> from `wlan0` to `wlp58s0`.
>
>      kernel: ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0
>
> Since switch to iwd, the device name stays `wlan0` and the message is
> not there anymore. Strangely the behavior remains the same, when
> disabling iwd again, and switching back to wpa_supplicant. Does somebody
> know what I need to do to revert to the old behavior of the device
> renaming to `wlp58s0`?
>
>
> Kind regards,
>
> Paul
>
