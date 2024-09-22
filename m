Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CB173
	for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727022556; cv=none; b=LP9n8q5KEL3MZbjTW9RZN4EarZ7EnCiGmgwZ920pZS2E2B41CqaF3LiOi6rxZXRMFQb1AQzpx1WSVDXX0Q/hkwtOYu0ojZw/65mGoov1/ut5PoUlOp2RfY+42jRJMpNuawaGZ6R7Jzg60+9Mms8Y6khB7BWflrqpN5kgj2f3YGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727022556; c=relaxed/simple;
	bh=McMQNYijdEO3msDa8Vcxae+pkf6fhPdKt0ejAKf9qhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUTn39WGTeoGAZQoXt9G4FH9CiPL/9Ez+sKcFXF8lab8po+YIRhQJLa0YvcpVYp0IhIzD4hHHgZyv1N18/wP64YK/hom8SUhL0c1//D+FYr7pglZFN+ouE+zd4Rk7jDdfUJ3/DyOpN7MtYZWcVZQ3evgqvLZNl4rkPTFUan65VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTAatAer; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTAatAer"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2054feabfc3so31784135ad.1
        for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727022554; x=1727627354; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5Px4zClkwBilGwHdFcDQyJmRuSxgNbH0eh051HMwqA=;
        b=mTAatAerJwhfR7gg+3aah0CYKeiZtgegE6nOjDdG07EMzO4m9LZxQKlNX/s3Yjgzwb
         A424iUbKLWGZrsbwbCRrWGL6gaMOhfH+qbKJurX06LJudIfpBTjivAgUj5xysBUE2JvD
         hUa8KAgD2d0QIWtBCt+bKdqs5EPAa8TIR7KIEJcnYmaMANW4mcoMeSjyt0UzuRqZ4XZr
         RmupVMzsiKLlnOXDWX10HK3E7ww4wDeUJvXjl5OuMABlnWyjZhsaiASSvpsCe5DpziWV
         c4dQrrSKUz0meidVOxZMtWMgAoSqXFs06PJsNClGMhM1+21OdDuCIMzkUhuA88qEmkvG
         HSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727022554; x=1727627354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5Px4zClkwBilGwHdFcDQyJmRuSxgNbH0eh051HMwqA=;
        b=oYJSq5D/SDefRwGzNvH/INi3lXoxhcfVXy2eM/NXAFNG/tWkGASjjIbiGQ5Rlzj8Ll
         QeNMOdxwfmmwukMMPDVZxsZXe8WCBe/Uq6RAPOO101RRKx1gbvkQHkFzxkg1U0SjVqsC
         5QNAR7tisRmiRd9olIrFMraG6KXWIoOGuTi7o9mw9Ui/lWiSY+PhE+1ZnvCzKDCJypBy
         yZh+J+WrQ6CgJqeV698wpEdIxR5vuNL0qPz6bbxMUK5fDinXyluA1lLggeLksjqCsF9T
         bW1bHjry5/pPF/T5/V6KnCP0mGaUED+cOV1HaNQcj08dOTtLCvBhWRb7VJdDe60Byp4f
         AhHw==
X-Forwarded-Encrypted: i=1; AJvYcCVfgM/Q9nlAIrySGOYz8KZeGh1hhfDZG1q+5y/8IFUlDA7TQgX2RU2rgCi1S7Jpg/gBY/Y=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd6j/1OHQzobERNz0tP2ZTqmRhW7n64yxofCq7Gt2++m4jCihZ
	59Q3A3yoHdP6zi602fgl4/p5ublyRvDL6JVqZh4xAcbU/k9Y9tuBo03tYavW56aLXV+XYsziwjh
	pyRqmSPpgrhkuDUCvZq92T90hG7I=
X-Google-Smtp-Source: AGHT+IEOcW2ue3OM/xocdbtPLvGwDoapmzo9es4fiFo9oYaF88cw1tzLd+gBJ365tyjtlxHiBAYQ4KmtIW0pKo2+88c=
X-Received: by 2002:a17:902:eccc:b0:206:a162:e19e with SMTP id
 d9443c01a7336-208d986a74dmr128921035ad.37.1727022553636; Sun, 22 Sep 2024
 09:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240823174220.498594-1-denkenz@gmail.com> <20240921185902.170612-1-yshuiv7@gmail.com>
 <ba78a253-de77-4427-85c3-d876ef9fdd8a@gmail.com> <1921859cb98.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_PAm0NsA+oRho5Qt-Y8MowB4nkeOnugzaE==pWLSpGYpg@mail.gmail.com> <1921a891f18.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1921a891f18.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 22 Sep 2024 11:29:02 -0500
Message-ID: <CAG17S_O1njCdiFaWUSh8N11DhiRBKhvnigCpLiNfkCp+JwuGJA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, Yuxuan Shui <yshuiv7@gmail.com>, iwd@lists.linux.dev, 
	prestwoj@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 11:20=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On September 22, 2024 5:36:53 PM KeithG <ys3al35l@gmail.com> wrote:
>
> > On Sun, Sep 22, 2024 at 1:09=E2=80=AFAM Arend Van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On September 22, 2024 5:35:03 AM Denis Kenzior <denkenz@gmail.com> wro=
te:
> >>
> >>> Hi Yuxuan Shui,
> >>>
> >>>>
> >>>> I tested this on an RPi5 too, and indeed I am having the same proble=
m as KeithG
> >>>> as well. However I managed to get some debug information from brcmfm=
ac when
> >>>> running wpa_supplicant. Interestingly wpa_supplicant gets the same -=
52 error as
> >>>> well, which it reports as an authentication timeout. But if I ask it=
 to try
> >>>> again, it will connect successfully, and there is no external auth r=
elated log
> >>>> the second time around.
> >>>
> >>> Yep.  It looks like wpa_s puts the resulting PMKSA into the kernel ca=
che even
> >>> though the initial connection using external auth fails.  I've only s=
een
> >>> 2.10 do
> >>> this, not 2.11.  Either way, it is a bug / lucky coincidence.
> >>>
> >>>>
> >>>> So I suspect this is a firmware bug, but it should be relatively eas=
y to
> >>>> workaround I think? Basically we also add a timeout and retry.
> >>>
> >>> It would be far nicer if the brcmfmac firmware + driver combination w=
orked
> >>> properly :)
> >>
> >> Indeed it would. So what's in the mix? What kernel is used? Upstream o=
r RPi
> >> kernel? What firmware capabilities are listed in debugfs?
> >>
> >> Recently I submitted patches upstream to add external auth support. As=
 I
> >> ported downstream patch the results you see do not make me optimistic =
that
> >> my patch is ready. Maybe you could help testing it?
> >>
> >> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D891=
248&state=3D*
> >>
> >> Regards,
> >> Arend
> > Arend,
> >
> > I tried to apply the patch set to kernel 6.6.44-v8 and was unable to pa=
tch it:
> >
> > $ patch -p1 <
> > RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firm=
ware-events.patch
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211=
.c
> > Hunk #1 FAILED at 6752.
> > 1 out of 1 hunk FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> > Hunk #1 succeeded at 524 (offset 33 lines).
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> > Hunk #1 FAILED at 1359.
> > 1 out of 1 hunk FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> > Hunk #1 succeeded at 74 (offset -1 lines).
> > Hunk #2 succeeded at 336 (offset -70 lines).
> > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
> > Hunk #1 FAILED at 15.
> > Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
> > 1 out of 2 hunks FAILED -- saving rejects to file
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
> >
> > I did not try the other patches as this attempt failed. Do I need to
> > use a newer kernel? The latest kernel from RPiOS is 6.6.47.
>
> I did major rework to support multiple vendors with differing firmware
> APIs. So I can imagine you would need other patches that were submitted
> earlier. Easiest would be to use the backports project which allows runni=
ng
> latest driver like wireless-next on older kernels.
>
> I can try. Do you have a URL of the RPiOS kernel repo?
>
> Regards,
> Arend
> > Keith
>
>

Arend,
It is either here as a git clone:
git clone --depth=3D1 https://github.com/raspberrypi/linux

or here as a gzip:
https://github.com/raspberrypi/linux/archive/refs/tags/stable_20240529.tar.=
gz

Keith
