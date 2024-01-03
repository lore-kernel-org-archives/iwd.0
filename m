Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316B1A708
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8Ttj+dv"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cda3e35b26so2806172a12.1
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 06:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704293891; x=1704898691; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlxcllhtS8jsprqX2Sf4gnbjZ/WqbxMB0mYSxf2AnIU=;
        b=F8Ttj+dvni2soeXyu0BbF1A+JcQ8USat57Act5N3AXCwoXuftCdSVpXzRtqhf29cOy
         WBvCltCOuj3ya/byAbbPjyu3kS5641rW0SI4zbnPwI9bR0FmThBb9VSsjNigk3XKhxfM
         Eu4Aj5ANi3Y6eHmnDPJwgZzAhzOD1W+p0SSFslsdRJkcEE0ZpyPk82EeyXtyITfiDHEa
         O6hAJKtGNg93YHEaUt01QU5QMWNq57UjUPlyRa5sWuBfJiVWXx8ykvby2cyrcsNvHQ5j
         nHkDHcRy4F/BxKMo7z/hWB8aRVN+1VN8Svz1Q8KJBoS74Yj/xlcqAobX2BDi6yuaUsnm
         Hf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293891; x=1704898691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlxcllhtS8jsprqX2Sf4gnbjZ/WqbxMB0mYSxf2AnIU=;
        b=o7+5Iqa9IkkMoFhDsBCSsFq5BiWYeRNGByOzmS7u+e2y9CzOrpl7HQuIDow7LfCM2S
         4n3LYMCuWDa3mEnrFM2JPCFYRhK3A4qpn5rf27bTNW6x6ZRYs5ZUTvAUEYvGH6lf3AP8
         r+CZbcC+dDbX61qnnQoVYR2MLWo6MPHJz1qRFMhJAFJpw7mF1w4/4jrYWPGyUQ1xJltH
         5gFyOvoRnW+ZA1GkM0bCsM5g7Ewu/4r46j8zwKkpmRhiuQSrgqznCuX9egZe4zycTIDy
         CErJ1SJgVtNwdLdmkmKfq2JA7SYjAOmsHQe6KPwaW+1FfQUFRSGsdsmlHL/GQOWBy/ZW
         eY8A==
X-Gm-Message-State: AOJu0YyH0d1+/nSCA1NCgML8sZoDiwBo9bVkrNmMrQz/Sj+c9rudzJMF
	JRupy/I29N0pXxrE4rzjcgAzoEF9qqe+ga3xoNRsnZiBqwo=
X-Google-Smtp-Source: AGHT+IFTQb+R3qwMtmS9DhbiFgJQrsMRduAnedjS6PtjPTOJxR3SPcObCYYoCPjuRrCH6fWedy9hUG7tD6UBCxyKA+w=
X-Received: by 2002:a17:90a:c4f:b0:28c:5a10:f32d with SMTP id
 u15-20020a17090a0c4f00b0028c5a10f32dmr5538347pje.76.1704293890734; Wed, 03
 Jan 2024 06:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240103125638.243820-1-prestwoj@gmail.com> <271dfdff-903d-4ff4-abe7-34526aec3580@gmail.com>
In-Reply-To: <271dfdff-903d-4ff4-abe7-34526aec3580@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 3 Jan 2024 08:57:59 -0600
Message-ID: <CAG17S_Pf2YeN8WMj8K6i5RfZTdFXy7S4Ry_zcqPYFdQQ57v52g@mail.gmail.com>
Subject: Re: [PATCH] scan: limit COLOCATED_6GHZ flag to 6ghz devices
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 6:58=E2=80=AFAM James Prestwood <prestwoj@gmail.com>=
 wrote:
>
> Hi Keith,
>
> On 1/3/24 4:56 AM, James Prestwood wrote:
> > It was seen that this flag seems to cause issues when in AP mode on
> > brcmfmac devices (e.g. the raspberry Pi 3). When in AP mode an a
> > scan is issued clients will disconnect. After testing this behavior
> > was isolated to the use of the COLOCATED_6GHZ flag.
> >
> > Besides working around the problem on this specific hardware the
> > patch itself makes sense as a non-6GHz capable device shouldn't use
> > this flag anyways.
> >
> > As stated in the patch comment, this isn't really a catch all
> > workaround since the flag is still used for devices supporting 6GHz.
> > If additional hardware exhibits this behavior we may need additional
> > changes like a hardware blacklist or an explicit option to disable
> > the flag.
> >
> > Reported-By: Keith G <ys3al35l@gmail.com>
>
> Could you double check it still fixes the issue you were seeing on brcmfm=
ac?
>
> Thanks,
>
> James
>
> > ---
> >   src/scan.c | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/scan.c b/src/scan.c
> > index f48ffdef..8c6fdc08 100644
> > --- a/src/scan.c
> > +++ b/src/scan.c
> > @@ -394,7 +394,20 @@ static struct l_genl_msg *scan_build_cmd(struct sc=
an_context *sc,
> >       if (params->ap_scan)
> >               flags |=3D NL80211_SCAN_FLAG_AP;
> >
> > -     flags |=3D NL80211_SCAN_FLAG_COLOCATED_6GHZ;
> > +     /*
> > +      * TODO: This flag appears to cause some undesired behavior on br=
cmfmac
> > +      *       when the device is in AP mode, or has a secondary AP int=
erface
> > +      *       running, causing clients to disconnect when a scan is is=
sued.
> > +      *
> > +      *       Only using this flag for 6GHz capable devices will limit=
 this
> > +      *       behavior to only 6GHz devices and in reality makes sense
> > +      *       because a non-6GHz device shouldn't use this flag anyway=
s. If
> > +      *       more issues still are seen related to this we may need a=
n
> > +      *       explicit workaround, either brcmfmac-specific or a disab=
le
> > +      *       option.
> > +      */
> > +     if (wiphy_band_is_disabled(sc->wiphy, BAND_FREQ_6_GHZ) !=3D -ENOT=
SUP)
> > +             flags |=3D NL80211_SCAN_FLAG_COLOCATED_6GHZ;
> >
> >       if (flags)
> >               l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &=
flags);
James,

I will do this tonight. I was playing a lot with iwd that I had
patched with your suggestion last night. I was trying to resolve a
related problem and I did note that it was significantly more stable
with this patch, but I was still getting disconnected periodically. I
do not yet know if those disconnects were due to me or iwd and am
still investigating. I will continue this investigation with this new
patch applied. SHould this patch be against HEAD or can I safely patch
2.12?

Keith
