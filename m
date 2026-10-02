Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7E37DEB6
	for <iwd@lists.linux.dev>; Fri,  2 Oct 2026 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790966041; cv=pass; b=LamHvShtv7GJenW/INDvuhPXfr6wQTnQbr+7GQ7+WjL9kve+BeN+AifhuRWN+X04Mxe+W2jTRSitZcXfJa8ODS9aKvoPkR9jChiu4DySjKXtQ4rxS0NDRmHY1xr8zEny0wUbzLrJ5QsrizGXFvQ8jKKUSoAVgnT2PcVc9alq8q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790966041; c=relaxed/simple;
	bh=bnNKJMZzi7mdwLx3mJcaEz4L7MsG0H5r3pXkWYBQrEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZhjTabZd+32S5x/gBmCinNhXiAngIqs26vHiFJb2szDI5wqfybsW6mRG/+khA94P43JFh5CrkJgPCpp14ltmZDaJ2OWMeSDikkXCdojj/SXVX8GzMoVxk0Qwg9o8ZkiMlaiOSNjt9KaIV8oLVULvtiriNjvvx1dhva+HjZNoFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jeremyblum.com; spf=pass smtp.mailfrom=jeremyblum.com; dkim=pass (2048-bit key) header.d=jeremyblum.com header.i=@jeremyblum.com header.b=VUKoQABX; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jeremyblum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jeremyblum.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jeremyblum.com header.i=@jeremyblum.com header.b="VUKoQABX"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4f512029e45so138134b6e.1
        for <iwd@lists.linux.dev>; Fri, 02 Oct 2026 11:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790966039; cv=none;
        d=google.com; s=arc-20260327;
        b=iFq2D4/I4/eRHb8R+/pJAenD0vj5URvSem1/EgbB5mm+aRKZWQukrrTGQjTc0Oc+Nb
         Rb13bus72L73yPJxfWnHXXSMpVHayBwagGK8e32ypJbVitIHuBrJWO2LxgUyXWS8FuyF
         MaIId3394x1+jKftnkfd+tnOxO0PyFCIJQMTqxFPXxZHEp8zWtBAMMyalEvajJ1c9Nb5
         KIBNXKJoxsx0As9wbMZh4sknMNw57tu8se1jss93hHyA2I9xc4nUT+avZkG7gPtTbmNn
         9Rf64lq4OfpvuKtY8zE+4p/PUrgTCh4rUWFt7/Viay/yowLdtwB0fyVPWk1HMlnOkW8v
         5Z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xqiy2KkRA5LLGGheq+Ns2OsroQXT4+oN6qUnX9hC20E=;
        fh=+JfVobsgae1OV1bnDzrXKcQvymWPSOc/iw3ohTVAI6g=;
        b=m9N7CvHm8XptA21wN7L41Zkw228VfjeJdCLapziQrEv69StSJK1OU8EQffDExT3xgx
         Xh78PkNq8421QvebMiJyyA3FLN9+wAqwz2epoYvzsh1IbKwbNKtKCaFzhtAhQGf4LtcQ
         KwHZRXs9QQOvVDJmwMeqZMlxW4LCvUqIcFXWmnKvzZIMEQjZ9mr3Oz4j79Tbpz03GKAT
         XvKPL1zoXGUvjzb58Rua5c3Yv9pRBp1BnZ7vhOsCgiTLIjlUTy1b+CEOrVbPM9p0PBTc
         r/RaCZsOP3WaHaYMSJPgidOl2RY59faczCAKe8mjiy19cTRxUv6wuYmllb5HR/H68lfn
         Uz1g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeremyblum.com; s=google; t=1790966039; x=1791570839; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xqiy2KkRA5LLGGheq+Ns2OsroQXT4+oN6qUnX9hC20E=;
        b=VUKoQABX8/1j94O6Sq5jjgyM8EFUzv717Rbiud4NW0S3aX9hBezhQBAGRBXKRKn467
         DTcLUZV5ugGgPnk7reD7MjovvdWUUDwQ2hanzZ1gz1sZkJ5NmFK2q/0wy1IBeQuUR1Ad
         NDbg8En/biRiR+X5sodbMRjzqQnLgO5K/t3xqVGtFZCZFRvNGDPd0uU9b52IHs8/JYdi
         t5Kt3mvDtqAQ7W5mrfEaaImqdO8Z9ohp3O12H0JUJrM54ELVJCMBF2ckHv1SUKMdZRVI
         xTtwiZ5d8NIbcsOaZU0v70DE5EjRCvDWbl0+2K7zgKkpOuJl6iRdJNHeSm1+cXGnIu8G
         /Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790966039; x=1791570839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xqiy2KkRA5LLGGheq+Ns2OsroQXT4+oN6qUnX9hC20E=;
        b=lmvo4kk3ffdtcye3DCUFmEw6XjVx/BjveD1/xTt7muIafcWQ0W7i8AJtn6ycevG+4v
         4KT8FivXcCv8X4CLOs7+QA9IhvFlAM2kd7FosKcoUgLyCG4TcEN0NOYW1haIROWgaJ3T
         P5MAxiPe/hKFyRw5a0PL6azoRhCRQLRO3cSZKP+BfZ3Gyl6OO4sBf6COYmjLU0Cu4LKC
         SLwycXDu/cYYzc4A4LBB/9OV+wIV8ZOqkjTZyYn6WkXpqyDKyb6lvg/tQGuombt5J8qb
         LuZ/EHbmO4JiMcwQM690Mw7nCoWg+wOmKg9pb/3vmEAtsUWexF4Uj7U9JJJmymCLIpPU
         6Lig==
X-Gm-Message-State: AFuF++nphu3c/tqvIG4QKlne+v2N+ImLfBZbjctEsc3TYEYoglH6rwZP
	u0HgixX1UyJctKnlOj14v4NMokingfTsLyCISIJSW9K2sE1pFQbkQRuffo7nOlXm0vjuD+nIWHr
	DDeuhUBXkqoCiygIQwmFKxw3CED5wHEMRMF46D7/uXA==
X-Gm-Gg: AYBFou0YQPSz6IEqWArIa3rapI1xj/ylru9V2n03wQlseVTefrHVFqwJuCipDyYyDRN
	SpE5FycDP+i2prHEntDlMcpA3/htr+KmEfjjgVMit/U2WtZf9+T/OpnFUqwb+G3ftZhQDoyHYde
	l5KVk/naojtMkP2GoCQjGqxCqSPjD4xwZx/F1wf+ndduGTgJf0rHfJzcLfM9k8TS96awu4Wt6+s
	xKLrOX104GHIW2j26EzLxLs04YUUME7PyZ/pAnz8ru6wd1bDLRQV82Ezc2wTEWLq978G29ULh7J
	1VZt3e7n2bonnPeilS9ryqBkO5OYO/O7/jw3uQ4vCyxLnjaDfGQrDQ==
X-Received: by 2002:a05:6808:3c46:b0:4c0:12f3:6007 with SMTP id
 5614622812f47-4f67703d6edmr378099b6e.4.1790966038517; Fri, 02 Oct 2026
 11:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260403175038.4533-1-jeremy@jeremyblum.com> <aq6USbwGZT9CjoKf@camel4.lan>
In-Reply-To: <aq6USbwGZT9CjoKf@camel4.lan>
From: Jeremy Blum <jeremy@jeremyblum.com>
Date: Fri, 2 Oct 2026 11:33:47 -0700
X-Gm-Features: AclHuK8yDY1HY_E5NNfsNLezSI297l86XoKlyK66QUlzPq7IkD3CKTjjPQn6NI8
Message-ID: <CAKqcr=gi-fNFwvCyC1Efgs3Je65zywGUjnKLJjThcofDFWN0Pw@mail.gmail.com>
Subject: Re: [PATCH] netdev: use SAE PWE both for fullmac external auth
To: Matthias Reichl <hias@horus.com>
Cc: iwd@lists.linux.dev, denkenz@gmail.com, prestwoj@gmail.com, 
	marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nice! Thanks for the additional testing. James - can this be merged?


On Sat, Sep 19, 2026 at 6:55=E2=80=AFAM Matthias Reichl <hias@horus.com> wr=
ote:
>
> On Fri, Apr 03, 2026 at 10:50:38AM -0700, Jeremy Blum wrote:
> > For fullmac external SAE, iwd currently forces Hunt-and-Peck and does
> > not include NL80211_ATTR_SAE_PWE in the connect request.
> >
> > This prevents successful association with H2E-capable APs on at least
> > some fullmac drivers, since userspace is effectively constraining SAE
> > to Hunt-and-Peck while not advertising the intended SAE PWE policy to
> > nl80211.
> >
> > For fullmac SAE connections without PMKSA reuse, request
> > NL80211_SAE_PWE_BOTH and stop forcing Hunt-and-Peck on the SAE state
> > machine. This keeps the fullmac external-auth path aligned with the
> > actual SAE policy instead of hard-wiring HnP.
> >
> > Tested on a CYW43455/brcmfmac fullmac device using firmware 7.45.286,
> > where this change fixes WPA3 association and traffic on H2E-capable APs=
.
> >
> > Signed-off-by: Jeremy Blum <jeremy@jeremyblum.com>
>
> Tested-by: Matthias Reichl <hias@horus.com>
>
> Thanks for the patch, it works fine on a Raspberry Pi 5 using a 43455
> with firmware 7.45.265, the downstream RPi 6.18.52 kernel and iwd 3.12
> plus this patch.
>
> Without it hostapd on my Asus AX4200 router running OpenWRT 25.12.5
> would reject association with a "SAE: xx:xx:xx:xx:xx:xx indicates
> support for SAE H2E, but did not use it" message.
>
> With this patch iwd connected fine both to a WPA3 SAE only network
> and a mixed WPA2/WPA3 PSK/SAE network.
>
> so long,
>
> Hias
>
> > ---
> >  src/netdev.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/netdev.c b/src/netdev.c
> > index e639a1f8..94520b5c 100644
> > --- a/src/netdev.c
> > +++ b/src/netdev.c
> > @@ -2600,6 +2600,11 @@ static struct l_genl_msg *netdev_build_cmd_conne=
ct(struct netdev *netdev,
> >       uint32_t auth_type =3D IE_AKM_IS_SAE(hs->akm_suite) && !hs->have_=
pmksa ?
> >                                       NL80211_AUTHTYPE_SAE :
> >                                       NL80211_AUTHTYPE_OPEN_SYSTEM;
> > +     uint8_t sae_pwe =3D nhs->type =3D=3D CONNECTION_TYPE_FULLMAC &&
> > +                             IE_AKM_IS_SAE(hs->akm_suite) &&
> > +                             !hs->have_pmksa ?
> > +                             NL80211_SAE_PWE_BOTH :
> > +                             NL80211_SAE_PWE_UNSPECIFIED;
> >       enum mpdu_management_subtype subtype =3D prev_bssid ?
> >                               MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_REQ=
UEST :
> >                               MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_REQUE=
ST;
> > @@ -2618,6 +2623,8 @@ static struct l_genl_msg *netdev_build_cmd_connec=
t(struct netdev *netdev,
> >       l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
> >       l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->=
ssid);
> >       l_genl_msg_append_attr(msg, NL80211_ATTR_AUTH_TYPE, 4, &auth_type=
);
> > +     if (sae_pwe !=3D NL80211_SAE_PWE_UNSPECIFIED)
> > +             l_genl_msg_append_attr(msg, NL80211_ATTR_SAE_PWE, 1, &sae=
_pwe);
> >
> >       switch (nhs->type) {
> >       case CONNECTION_TYPE_SOFTMAC:
> > @@ -4218,7 +4225,6 @@ static void netdev_connect_common(struct netdev *=
netdev,
> >                                       netdev_external_auth_sae_tx_assoc=
iate,
> >                                       netdev);
> >               sae_sm_force_default_group(netdev->ap);
> > -             sae_sm_force_hunt_and_peck(netdev->ap);
> >       }
> >
> >       if (sae_sm_is_h2e(netdev->ap)) {
> >
> > base-commit: d003d0e593323b3de427f01284ede81ba61e9dcc
> > --
> > 2.50.1 (Apple Git-155)
> >
