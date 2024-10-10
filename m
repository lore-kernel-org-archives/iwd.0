Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E3136E23
	for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574701; cv=none; b=NDJMCcJfDrLje8QhJwCVag9qp0wp1gc0F0u8zTSK6xyF76BUvpB314vFGQR9wFB4Jc5+AriGHj95jK3PFmxX9vEuNrrWV+ohTyjAfpirxPraW+PnT1ZSvqKCG0MoTg7NcO/I/OufSpjFX6ZHhe97IpYRKKdqZkn7xus3Btd+nLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574701; c=relaxed/simple;
	bh=Bzn8ghQPvnosu3MOqlTdTgWHQyBMFxvBZSNzloc4sfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lheKPHLiiRBpUFi4UTNz42AAG+ihepBK0CP6wP79AoCb+Wyx6EK92DoChOP0pfiOK8GFM/P/+HBWoJLTREDzhfohlX8MUD6aOKBvpetgS9CEsCRYlSV6Q4Cel7jLSyzIx/A7/2LWTr624Z0ZpQT6KGzcdLSqXj+Hxj+QNzIpXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3WKMBPO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3WKMBPO"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so758587a91.1
        for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728574699; x=1729179499; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alfKCq8gtDrjEWuXUGopQQqUqnGFbqNI1PkfRRufpyc=;
        b=f3WKMBPOVJo+7K1SDHzaEG01fG6FjXxIk5kmzWQhdaYnx4B0Np0WsehDuJkEs7zB9L
         2daG/20Cstr6tvaXtRYys345kUVJPswK7vke4UEaqde3KhZTLVoTxCtfalKMqInMqzqx
         cmDaUA80/NKZ4Jib4qpfnvFYs4tAfIrTD4/kJq5/qmB8DV61gDaNCkVGIlVR3WBrnKpq
         IYPtHWRmBbeD6YjD3aNYYbEMcvTSWabgehdWhCUZBzDARiyKt0TPiLvSsR6Epo7g19V2
         x4i+wo0Pypscjy3/4f9+OBxD+cpZvndFSKkfHc/z+UHQE5m9n0xSZtxPw3Ia9kYjp3al
         1JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728574699; x=1729179499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alfKCq8gtDrjEWuXUGopQQqUqnGFbqNI1PkfRRufpyc=;
        b=E6+gapGR3L9SOpkLTsDnzYYltl/hUVk9rmkSQ0nnLeJzVL6MiCHsMaWxH0S4VHAU54
         bvqaqMF22aGtHbbgU9p4taxthOba0W3DILpiXrFKyD0LPKVDGOexBh5pQX5Hm1J6ucZ4
         w365lMdzgpQprx2bMF1TIff8SfzCJBz/XpPfzSlWQjhpOMukznRWRsYr7i06dcke0A5o
         YmK5f9qksJjyXJqXijK+FQzV/Hwd9e07paNxhHKWCX9BQLkEm5vzDzZTexYKjPKzL7Q1
         3Qq6owZZRvwPI1rWC4MkNrAef6zNieIAW2EVVbkpvM6HM5Tq0ssv030+QPRVv+U9x2vK
         E+6g==
X-Forwarded-Encrypted: i=1; AJvYcCV301XKIP+jf34JB63t+ssO1Y/gRMiVIxyTQ+G8XCxgepbA4DhWv1HzDdQXZLghbYsuYOg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzJQWw2ZASuNdpmyFecx4dLtERYrtuH60m6AbzvAQCYyeW2SwRE
	Vf/mFeSi7VEznn+EuB/NLiwCrKn5/n3So3HufckElGOGIPNsqU5Gg7UF3+gQqJW2JbGieBkMdkH
	BYwyzQQxtfDeVAVmmdy6QhtTqlss=
X-Google-Smtp-Source: AGHT+IE9QnEu/8yQmh9rdCQ8YUZxUClxjQPng8MXtugBeyiOpCE811UjKNF+ec1knDZFhkhbN0qhjwXCotF2GTNBIUs=
X-Received: by 2002:a17:90a:2dcc:b0:2e2:8f4d:45a with SMTP id
 98e67ed59e1d1-2e2c81ba3c8mr5753355a91.13.1728574699404; Thu, 10 Oct 2024
 08:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240823174220.498594-1-denkenz@gmail.com> <20240921185902.170612-1-yshuiv7@gmail.com>
 <ba78a253-de77-4427-85c3-d876ef9fdd8a@gmail.com> <1921859cb98.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_PAm0NsA+oRho5Qt-Y8MowB4nkeOnugzaE==pWLSpGYpg@mail.gmail.com>
 <1921a891f18.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <CAG17S_O1njCdiFaWUSh8N11DhiRBKhvnigCpLiNfkCp+JwuGJA@mail.gmail.com>
In-Reply-To: <CAG17S_O1njCdiFaWUSh8N11DhiRBKhvnigCpLiNfkCp+JwuGJA@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Thu, 10 Oct 2024 10:38:07 -0500
Message-ID: <CAG17S_MVSrnyz_ctW8CU1HMvkzcU2ZYOzpTjKXzXESaSmzeEAw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, Yuxuan Shui <yshuiv7@gmail.com>, iwd@lists.linux.dev, 
	prestwoj@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Arend,

Is there anything I can help with on this effort to get External Auth
working on a kernel that more of us are using? RPiOS is currently at
6.6.51.

Keith

On Sun, Sep 22, 2024 at 11:29=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrote:
>
> On Sun, Sep 22, 2024 at 11:20=E2=80=AFAM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> >
> > On September 22, 2024 5:36:53 PM KeithG <ys3al35l@gmail.com> wrote:
> >
> > > On Sun, Sep 22, 2024 at 1:09=E2=80=AFAM Arend Van Spriel
> > > <arend.vanspriel@broadcom.com> wrote:
> > >>
> > >> On September 22, 2024 5:35:03 AM Denis Kenzior <denkenz@gmail.com> w=
rote:
> > >>
> > >>> Hi Yuxuan Shui,
> > >>>
> > >>>>
> > >>>> I tested this on an RPi5 too, and indeed I am having the same prob=
lem as KeithG
> > >>>> as well. However I managed to get some debug information from brcm=
fmac when
> > >>>> running wpa_supplicant. Interestingly wpa_supplicant gets the same=
 -52 error as
> > >>>> well, which it reports as an authentication timeout. But if I ask =
it to try
> > >>>> again, it will connect successfully, and there is no external auth=
 related log
> > >>>> the second time around.
> > >>>
> > >>> Yep.  It looks like wpa_s puts the resulting PMKSA into the kernel =
cache even
> > >>> though the initial connection using external auth fails.  I've only=
 seen
> > >>> 2.10 do
> > >>> this, not 2.11.  Either way, it is a bug / lucky coincidence.
> > >>>
> > >>>>
> > >>>> So I suspect this is a firmware bug, but it should be relatively e=
asy to
> > >>>> workaround I think? Basically we also add a timeout and retry.
> > >>>
> > >>> It would be far nicer if the brcmfmac firmware + driver combination=
 worked
> > >>> properly :)
> > >>
> > >> Indeed it would. So what's in the mix? What kernel is used? Upstream=
 or RPi
> > >> kernel? What firmware capabilities are listed in debugfs?
> > >>
> > >> Recently I submitted patches upstream to add external auth support. =
As I
> > >> ported downstream patch the results you see do not make me optimisti=
c that
> > >> my patch is ready. Maybe you could help testing it?
> > >>
> > >> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D8=
91248&state=3D*
> > >>
> > >> Regards,
> > >> Arend
> > > Arend,
> > >
> > > I tried to apply the patch set to kernel 6.6.44-v8 and was unable to =
patch it:
> > >
> > > $ patch -p1 <
> > > RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-fi=
rmware-events.patch
> > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg802=
11.c
> > > Hunk #1 FAILED at 6752.
> > > 1 out of 1 hunk FAILED -- saving rejects to file
> > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
> > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/common=
.c
> > > Hunk #1 succeeded at 524 (offset 33 lines).
> > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> > > Hunk #1 FAILED at 1359.
> > > 1 out of 1 hunk FAILED -- saving rejects to file
> > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
> > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> > > Hunk #1 succeeded at 74 (offset -1 lines).
> > > Hunk #2 succeeded at 336 (offset -70 lines).
> > > patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.=
h
> > > Hunk #1 FAILED at 15.
> > > Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
> > > 1 out of 2 hunks FAILED -- saving rejects to file
> > > drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
> > >
> > > I did not try the other patches as this attempt failed. Do I need to
> > > use a newer kernel? The latest kernel from RPiOS is 6.6.47.
> >
> > I did major rework to support multiple vendors with differing firmware
> > APIs. So I can imagine you would need other patches that were submitted
> > earlier. Easiest would be to use the backports project which allows run=
ning
> > latest driver like wireless-next on older kernels.
> >
> > I can try. Do you have a URL of the RPiOS kernel repo?
> >
> > Regards,
> > Arend
> > > Keith
> >
> >
>
> Arend,
> It is either here as a git clone:
> git clone --depth=3D1 https://github.com/raspberrypi/linux
>
> or here as a gzip:
> https://github.com/raspberrypi/linux/archive/refs/tags/stable_20240529.ta=
r.gz
>
> Keith
