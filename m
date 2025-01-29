Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E31AAA1F
	for <iwd@lists.linux.dev>; Wed, 29 Jan 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167469; cv=none; b=XjaXkB0a6/yzIJkww7ZKSudPdAEFcrFXPRs7eL7Htji2Z7uhTK+af5PakYtH6YmhUSfTj8DmbPQ5HVAanuW2WG/y3bulq3bxOcG6o+WkWuN73o9O0adnzl9Dj0/sO5ptX3L62ZFuZVvwMjtQguGQe7U89fB7h5uzYkRxcfv7jt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167469; c=relaxed/simple;
	bh=7cOqQTPVx07W45zrcQDirTFwD1UzetMc8lbV0MmH4Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maiWkjr0Hm3vNC3QzvDi3Rt+xrXqvCTMEzDz1V0iV2eKHnZAlQfupELvVxDpsmR6nrib3hXjkUMXNVJ/qi3PanajhkGhEZJF0N9/R7YNKG7QpuQGM6MUJCuynPUey+HQF7npQ0OMg5/M0s1fJpYinxPpS7Tf209eZu9+t84R5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNWcEkhr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNWcEkhr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-218c8aca5f1so12425095ad.0
        for <iwd@lists.linux.dev>; Wed, 29 Jan 2025 08:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738167467; x=1738772267; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCrI10XlER+0jv/efdg/Zp60DMmYk7kZQ49csOHKzUA=;
        b=HNWcEkhrKeVkBMgTDdqxOsP1ATClziI2EtsvCe822ca4O/Nz0WLYKez7N/l2qdCa1U
         ThJ7c9YrHImZs5JaNiamTGHwobVzujehxLz1O4qm78f89cs1HxfSS2gw97/Sc0GQ9Kzb
         m55UD+H9j40a77r8+MUxE0dKTAfEe4x+37bpQ/lxGbfXZzAyJ5WpWSwq+c0wxdBbm4R6
         Kl1dP8JqAwucL24hFQNzDy6mmZYhX0PfSVjblQprydOwFALv4VKzlHgosSxoIkQ621nl
         3fym502mCzOcSzdqlBVQ8TIzTuMLU3CjYwYVMm7Xq4iuHbL83W8V9XUmiBTFDJaIA4UF
         9C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738167467; x=1738772267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCrI10XlER+0jv/efdg/Zp60DMmYk7kZQ49csOHKzUA=;
        b=HoA3mjo4sQsn6YTIOWVhb0Xoy93m66kdiShXz8Uv2qjKPCUexR8YaNviYzYifWXVcj
         vBDLIBUgnJxxAh6/18+yCFTem4ftI3I21LHZV571nHVq0Ki6sTFjRU78fVwRb3XQWwRs
         mOMMSwfgecnedD6fZAo0b6jEyBXWMyqVZ6TIlMd395lJn8oOojLImk2GcVtUvJBRkzgF
         NVW8hLRMx8Vo77WKLeOAG8znyVev44hax3gDTaN+fNBI/cKY4Q+VvCWoTCkdVyFOXHbj
         /DZCSimJmObrX/kvvPX+gkxk8gg4a/9/76fylVjFUxIwA3KkOWA2lOgvUIIWGiPHyX8g
         s9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuRQqEqaISrnYX4NE1SER/XRjROYEqa861cj6uVpseoPMKliocD2dbdC/I/y67SKo/JL0=@lists.linux.dev
X-Gm-Message-State: AOJu0YyGkVaGo2mogYK0/azQEYBfvi/QACeFPjM7PT3RnVhIXdBPA51s
	eCi6rlA2QFhvYjM6pgJEsGOpTuLkKblrYjkg/lU0IaXBkmCRpinCExcTxfVWfv1iaA1v3M+EDS7
	MWePTIxXVYszUicJF6AmUrkD4vKc=
X-Gm-Gg: ASbGncvaZytvLG5ZPK0LH5Av3O48YlJXdGT59z4uJRZNY+EzEC/wV1IO8HIF4G2B/8I
	hbdqRpf5IKcsGw5uZ1qH0+msZrrEibGC3bGaSdwCeUpOqpL+wcabaVuK0lQf3rAZ63QymfsPIRJ
	A=
X-Google-Smtp-Source: AGHT+IFMn8oxgmyBrlhhaaiGaq5zfXwzY7iskWaQeisN5CW0bZxaR/mkRc35kA3bDWpahN6JC2WhZ+KGX0Ogzf83O5A=
X-Received: by 2002:a05:6a20:e68f:b0:1e1:a885:3e21 with SMTP id
 adf61e73a8af0-1ed7a47dde5mr6430875637.7.1738167467541; Wed, 29 Jan 2025
 08:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250128180438.65113-1-prestwoj@gmail.com> <e7df49cd-3db1-42c4-bb65-aaca630d685e@tavla.de>
 <65c39ed9-5473-4d8c-a289-77ecb7012dba@gmail.com>
In-Reply-To: <65c39ed9-5473-4d8c-a289-77ecb7012dba@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 29 Jan 2025 10:17:35 -0600
X-Gm-Features: AWEUYZnd6r9F_PPIYo7ksHpBtobBheV5-qywk2EPi7uny5BTZhHN1C3kU-dBmJs
Message-ID: <CAG17S_PQni37Qgbsrqv9FzspCs8D=CVpn+GU3x=iYpJXpkCcFw@mail.gmail.com>
Subject: Re: [RFC] netdev: avoid PMKSA for fullmac drivers
To: James Prestwood <prestwoj@gmail.com>
Cc: Martin Petzold <martin.petzold@tavla.de>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 8:17=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Martin,
>
> On 1/29/25 12:54 AM, Martin Petzold wrote:
> > Dear James,
> >
> > Am 28.01.25 um 19:04 schrieb James Prestwood:
> >> The fullmac drivers need additional support to correctly work with
> >> PMKSA. This can be disabled via main.conf, but to avoid extra user
> >> configuration avoid the use of PMKSA for fullmac drivers
> >> automatically.
> >> ---
> >>   src/netdev.c | 22 +++++++++++++++++++---
> >>   1 file changed, 19 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/src/netdev.c b/src/netdev.c
> >> index 2a6d94fc..7af3c39a 100644
> >> --- a/src/netdev.c
> >> +++ b/src/netdev.c
> >> @@ -1518,7 +1518,8 @@ static void try_handshake_complete(struct
> >> netdev_handshake_state *nhs)
> >>             l_debug("Invoking handshake_event()");
> >>   -        handshake_state_cache_pmksa(&nhs->super);
> >> +        if (nhs->type !=3D CONNECTION_TYPE_FULLMAC)
> >> +            handshake_state_cache_pmksa(&nhs->super);
> >>             if (handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE)=
)
> >>               return;
> >> @@ -2455,6 +2456,19 @@ static void netdev_driver_connected(struct
> >> netdev *netdev)
> >>           eapol_register(netdev->sm);
> >>   }
> >>   +static bool netdev_handshake_can_use_pmksa(struct
> >> netdev_handshake_state *nhs)
> >> +{
> >> +    /*
> >> +     * Do not use PMKSA if this is a fullmac driver as they need
> >> additional
> >> +     * support (SET_PMKSA) in order to function properly. Until this
> >> support
> >> +     * is added fullmac drivers will not utilize PMKSA.
> >> +     */
> >> +    if (nhs->type =3D=3D CONNECTION_TYPE_FULLMAC)
> >> +        return false;
> >> +
> >> +    return nhs->super.have_pmksa;
> >> +}
> >> +
> >>   static struct l_genl_msg *netdev_build_cmd_connect(struct netdev
> >> *netdev,
> >>                           struct handshake_state *hs,
> >>                           const uint8_t *prev_bssid)
> >> @@ -2473,7 +2487,8 @@ static struct l_genl_msg
> >> *netdev_build_cmd_connect(struct netdev *netdev,
> >>        *       0 (open) for FT Initial Mobility Domain Association ove=
r
> >>        *         PMKSA caching
> >>        */
> >> -    uint32_t auth_type =3D IE_AKM_IS_SAE(hs->akm_suite) &&
> >> !hs->have_pmksa ?
> >> +    uint32_t auth_type =3D IE_AKM_IS_SAE(hs->akm_suite) &&
> >> +                    !netdev_handshake_can_use_pmksa(nhs) ?
> >>                       NL80211_AUTHTYPE_SAE :
> >>                       NL80211_AUTHTYPE_OPEN_SYSTEM;
> >>       enum mpdu_management_subtype subtype =3D prev_bssid ?
> >> @@ -4053,7 +4068,8 @@ static void netdev_connect_common(struct netdev
> >> *netdev,
> >>        * If SAE, and we have a valid PMKSA cache we can skip the
> >> entire SAE
> >>        * protocol and authenticate using the cached keys.
> >>        */
> >> -    if (IE_AKM_IS_SAE(hs->akm_suite) && hs->have_pmksa) {
> >> +    if (IE_AKM_IS_SAE(hs->akm_suite) &&
> >> +                    netdev_handshake_can_use_pmksa(nhs)) {
> >>           l_debug("Skipping SAE by using PMKSA cache");
> >>           goto build_cmd_connect;
> >>       }
> >
> > I also still had problems with the brcmfmac driver and IWD. It was not
> > finally resolved. I will try to check again with this patch.
> >
> > I would really appreciate, if you could have 2-3 brcmfmac devices
> > running in your testing environment.
>
> Happy to receive any brcmfmac devices you'd like to send my way ;)
>
> Thanks,
>
> James
>
>
> >
> > Thanks,
> >
> > Martin
> > tea
>
Actually, I'd be happier to not have any brcmfmac devices but here we are.
