Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278E4173
	for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727019414; cv=none; b=T3CZlgM52OtCtWEnVkuyKYNYSfr/LwCYhdyhiOLM/2ZjcUwQXTrIyxJwtIqGeRqQVZNV3BsmTsJ2F/V18GzBJaccm8TNkOIXrO7gaYbQcw/ZivN5byDRiPKvP7cDziBpyQF3gZymDAvgKZhtt3C6uXvUXqSFZ+fo5ngRPoJvUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727019414; c=relaxed/simple;
	bh=l4Vp07usz8Qnphqj0YihaR8+P8DG53aXseiDEFQ/qnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJVc/hFV4iRbzyu6bLa96BhWdR0Log6mMcgHVkYF9bpLn7hE6k5hojsP40CIi/8QhZ7hOu3d9df5PXwYjWWLyg0o47uCoKnPilj3/M7+RQb8p3MS9wKsVAuBvkZ7vc/5eJM8CuY8Y6cMKJG/JRIOHhsC2D1IVAtBUwW+a+YfKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3UVbjoJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3UVbjoJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8b679d7f2so2893729a91.1
        for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727019412; x=1727624212; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4Aps3TQj1MowElIR3RCOncwM0RGZ5nPFbWr95Kg8LI=;
        b=M3UVbjoJHLvh4rOGcJJCpoeEwysc10fb4gNqDkFjaZ4V+pXKUQiaHkDd58XO3NvG/m
         TRZwHFsODpiesD2pNkTPBZllDrKImGwVnzFyVjzjHrb95G7a71fCelg2EYUK+ccV0QFN
         U1OpHEXCJlycU1pQP3zZ73TRgNfNBXcY5McFiCqHAaWdTL57RI5pTmpr4dHVu/lMIvKd
         Gtwxc6u9APmqeLRXrdRdyw4185hfZy/6HD9GbiNs86x97yGYOQaxKUu5lxqEFSiHLqiJ
         T4ncLJgBAg5oX8VjpY1Er7EgPaYhFaMimA4h06MDpWUSQ9ySxXJiezh4oFBqMKLuCuzW
         VR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727019412; x=1727624212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4Aps3TQj1MowElIR3RCOncwM0RGZ5nPFbWr95Kg8LI=;
        b=w4/eAxmaom8HM11/TAl5HFKPqbNTmaEAaw21Y2q2S1tLRrbI148w/dgwnO/yikmnRH
         upRMaYWx8xdiT+qt8L2GNKNuVnftasZt1OKWJPGiGgvTQSLK5nKeXUn87GDqkkzpl0Pg
         oVGLjgy0RqBCoRFguWVI4YGH3Ip1shxGOXoBxBg/zK6EEXSTS96+0X1tlCtNK0CgBJvX
         CkD0q4/CYqf99UbGFVvnxHkqigA1f7Xs+V3gND0vYjeq3DEdwxl98e1tcQnRd8VqpOuP
         2guqN6irQxwfExbKwrNdvXltheo7EzDYi4s/ZyZRQRXFvXaa2rvKwM0Z8VBQ48dbTpXB
         +Sbw==
X-Forwarded-Encrypted: i=1; AJvYcCXr8dhMOHNpTVx8fl+mvdlzLM6OQPhPE+uOIo2HcPMRzq5wUR6SQeVq7xRrfgqMfpxWxS4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwlsOMxqnfd7TIjftfUWPwHsWyw+OiqF34VsutWUeMOqJHeiY+c
	RvsrnchspyORPWsuniKN/zeYfbVOlkLCHaXVYCkMPq2tmmL2htbfOXCZxvaTZT0O0jx9g2WpdGU
	hiWkPgZwUR03l7XUdmNH2qdmI9rOwSGF1SEw=
X-Google-Smtp-Source: AGHT+IEsCCXE9gcCm1kF/wobbGqjatzRW9m2dTrQcOrjI7ln2S5HB3FzWPIzOJ0IKISxSl2W3VUGGQ8eHLSRkLKdHLU=
X-Received: by 2002:a17:90b:388f:b0:2d8:97b7:449f with SMTP id
 98e67ed59e1d1-2dd80cf1089mr11571914a91.38.1727019412268; Sun, 22 Sep 2024
 08:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240823174220.498594-1-denkenz@gmail.com> <20240921185902.170612-1-yshuiv7@gmail.com>
 <ba78a253-de77-4427-85c3-d876ef9fdd8a@gmail.com> <1921859cb98.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1921859cb98.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 22 Sep 2024 10:36:41 -0500
Message-ID: <CAG17S_PAm0NsA+oRho5Qt-Y8MowB4nkeOnugzaE==pWLSpGYpg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, Yuxuan Shui <yshuiv7@gmail.com>, iwd@lists.linux.dev, 
	prestwoj@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 1:09=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On September 22, 2024 5:35:03 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> > Hi Yuxuan Shui,
> >
> >>
> >> I tested this on an RPi5 too, and indeed I am having the same problem =
as KeithG
> >> as well. However I managed to get some debug information from brcmfmac=
 when
> >> running wpa_supplicant. Interestingly wpa_supplicant gets the same -52=
 error as
> >> well, which it reports as an authentication timeout. But if I ask it t=
o try
> >> again, it will connect successfully, and there is no external auth rel=
ated log
> >> the second time around.
> >
> > Yep.  It looks like wpa_s puts the resulting PMKSA into the kernel cach=
e even
> > though the initial connection using external auth fails.  I've only see=
n
> > 2.10 do
> > this, not 2.11.  Either way, it is a bug / lucky coincidence.
> >
> >>
> >> So I suspect this is a firmware bug, but it should be relatively easy =
to
> >> workaround I think? Basically we also add a timeout and retry.
> >
> > It would be far nicer if the brcmfmac firmware + driver combination wor=
ked
> > properly :)
>
> Indeed it would. So what's in the mix? What kernel is used? Upstream or R=
Pi
> kernel? What firmware capabilities are listed in debugfs?
>
> Recently I submitted patches upstream to add external auth support. As I
> ported downstream patch the results you see do not make me optimistic tha=
t
> my patch is ready. Maybe you could help testing it?
>
> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D891248=
&state=3D*
>
> Regards,
> Arend
>
>
Arend,

I tried to apply the patch set to kernel 6.6.44-v8 and was unable to patch =
it:

$ patch -p1 < RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callback=
s-and-firmware-events.patch
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
Hunk #1 FAILED at 6752.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
Hunk #1 succeeded at 524 (offset 33 lines).
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
Hunk #1 FAILED at 1359.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
Hunk #1 succeeded at 74 (offset -1 lines).
Hunk #2 succeeded at 336 (offset -70 lines).
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
Hunk #1 FAILED at 15.
Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
1 out of 2 hunks FAILED -- saving rejects to file
drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej

I did not try the other patches as this attempt failed. Do I need to
use a newer kernel? The latest kernel from RPiOS is 6.6.47.

Keith
