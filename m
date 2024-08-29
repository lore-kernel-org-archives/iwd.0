Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69D1922FA
	for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934563; cv=none; b=b5DY3ouFVz0JUfLpcCnA3J8RENvEHd6+r7ouvo80FfkUEbrMaAzz2Z23KSRGOy15++y8XE+2WN44sfDrio12eylQWJ6Z0qw35sj9OdMcYlPh0/mS+s+AGlJZiEur1sPM5fuOTMgZRRBuN1Loi9rnbx802M9Yy2S5VmHNUUBolmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934563; c=relaxed/simple;
	bh=bfSH81jqlvqO5khMnwJ3OHtcdfFqcSiMD+N3KvEvjqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZix0DIcO8mnd2T/LyjkP2bBGJfjPt6dD9grtA/lCVffAojB7Ayxm96JKw0tQRgwp4gTGWiKAp7sDvVJ8zJ6hQ7XplaicG2kgSHtoyER8opTyQx+HAWUr5t8Qx/OtOXcAq/7+l2NmsoiovAxzjBFa4ZSWyO7gC/dpzx/DEep3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtVViQ6p; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtVViQ6p"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4fce2c0707bso211973e0c.2
        for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724934561; x=1725539361; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfSH81jqlvqO5khMnwJ3OHtcdfFqcSiMD+N3KvEvjqU=;
        b=CtVViQ6pJKHtTZ9ZSXOgxJiFkepdmjacJe5UwYl5JxNr11the5KivULIm834WXwTgd
         c+FSKtbuueJrQVtUa1z8/txb0RxvQfLdzDNANohByytqkcfHwgmrE4MHThmDyT0FYB2y
         O2DpCatceL5Cit34+FXhEwkEyu/lWVK4vmb/LUC67GUH8nYKp9ngWt7uXORu/HqQJARv
         C4SfZqUPsCArWFyMM5k7FM1mGj13iDRwjygiph/HY3dF2ER/rMTACpS5o2NzAcK5dXoZ
         GIopCr4d2+KJympqbt31rAokzkuQmSDOUWayDPoA/RLPqM9Tq9goV3lwrWYzrzQr/deO
         6fOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934561; x=1725539361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfSH81jqlvqO5khMnwJ3OHtcdfFqcSiMD+N3KvEvjqU=;
        b=wOJ0DH6fhFc8gnD+jYsHn3UHaNHpkAC7h0gCu3+PpNQ7qkYfFa222LzUy0CgGH47b9
         Mu84dFAtQPUd0aLxA06hnu1b0zRccon4mw414PlJ0j46Iixx8bxFQUhZMMinRb7AB7oR
         pUBQChOMFzkTqq/noZI+xqEvuD3+SqGkhkshgOVHqthSXsGKFHaJL2Mq9fMOrJkayHgi
         hwfMVlkRqoqa6M3VTTDS7593VT36alhaJ+NyyM4R000vfi7VZvJQPK8KjegXdalxocsO
         wEJWmmPj+QMaAMqaFsr6Zjy/9o9Bel6ScrdKDmKFJHMnmPr18EYQP5joFsWwTDkRIpTW
         strQ==
X-Gm-Message-State: AOJu0YyQbp83ShxcspxRrJCXIlHRmauKNXe1IAm/emM14WGcuw8MtWGs
	a7+jmO/QZ7Oc7yB5cScWwGGMPEPQ2QBUzLqbEYGcSQsadYmLFvbvZkC/VcoDzJJb0lsPSclYdKT
	hSKxqU1XfqyAVkyS0pcApSU02MPErmrrtkUA=
X-Google-Smtp-Source: AGHT+IHVQ8iGCZ1BT881fu4bR63OwvRITEzW3TrOSdleyT+EAKQ8IEHObTBgIIqXndBolry4wSK2LgQ/GnXlj0ZbsVQ=
X-Received: by 2002:a05:6122:d9e:b0:4fc:e729:f788 with SMTP id
 71dfb90a1353d-4fffe45b990mr2743626e0c.14.1724934560526; Thu, 29 Aug 2024
 05:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzCB-6wXch6yFu-4V9dKgz0sJRopsd7wXchccptT5hNB-A@mail.gmail.com>
 <444d59ad-9a07-4d2c-922b-e6c43b7d8cb0@gmail.com> <CA+iibzAq50zn7=J+XtH28T=XKbk_Ukoms-K4PYoTrRPEi0J1gg@mail.gmail.com>
 <1c8086ac-1d28-4c02-8c21-c7a37148a9f1@gmail.com> <CA+iibzD=UQC5sDwcoOy5_tPm=_58yp-mvV973Sq3dwJrej=89g@mail.gmail.com>
 <314a3582-0103-40e1-a7a3-274897f5950d@gmail.com> <CA+iibzDc=45P+U-xd6gxQBCqrEtb4ENFewFfzof91a9cU8OErA@mail.gmail.com>
 <4bcf6591-168a-446c-b6ff-b8ba5f7efedb@gmail.com> <CA+iibzDAZ0QSH9yXBgNd_CrOA3Z69z3yhbZMaiPjMUE8ZG8u0w@mail.gmail.com>
 <CAPv5Ue71TT7dDpe6TZQSimCztT3iQew30C7i0syZb=5JhiYCOw@mail.gmail.com>
 <CA+iibzB3j__Xe2VtpEr-5BH+kcJRM06UxcxWVmVZxHVyNMWsyg@mail.gmail.com>
 <CAPv5Ue6n1BF5E=c3u_cwcHZd+L++v4X8waqKmpW9sgQNvHVSxQ@mail.gmail.com>
 <CA+iibzCRmWL9H2smcsW31744i6AVc2Y68Juw9dEA2BV8AsKK+Q@mail.gmail.com>
 <6e9698e9-8dfd-4819-99d0-0a75c20c3778@gmail.com> <36c33cc4-9c69-41ea-856d-e47be1dbe486@gmail.com>
In-Reply-To: <36c33cc4-9c69-41ea-856d-e47be1dbe486@gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Thu, 29 Aug 2024 14:29:09 +0200
Message-ID: <CA+iibzCjefoUENuWXXJPfowFXRrZxwD+hYM+KuPvLGv2r2rzOg@mail.gmail.com>
Subject: Re: IWD CMD_SET_CQM failed: Operation not supported
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James

I have installed the patches and the error has gone

during the compilation the installation of the patches is successful

HEAD is now at 1ac39156 Release 2.20
+ patch -Np1 -i /tmp/work/src/npatch1.patch
patching file src/wiphy.c
patching file src/wiphy.h
+ patch -Np1 -i /tmp/work/src/npatch2.patch
patching file src/station.c
+ patch -Np1 -i /tmp/work/src/npatch3.patch
patching file src/netdev.c

and the journalctl gives this

ao=C3=BBt 29 14:22:46 grat-os1 iwd[534]: udev interface=3Dwlan0 ifindex=3D4
ao=C3=BBt 29 14:22:47 grat-os1 iwd[534]: event: state, old: disconnected,
new: autoconnect_quick
ao=C3=BBt 29 14:22:47 grat-os1 iwd[534]: udev interface=3Dwlan0 ifindex=3D5
ao=C3=BBt 29 14:22:47 grat-os1 iwd[534]: event: state, old:
autoconnect_quick, new: autoconnect_full
ao=C3=BBt 29 14:22:47 grat-os1 iwd[534]: event: connect-info, ssid:
Livebox-xxxx, bss; xx xx xx, signal: -49, load: 1/255
ao=C3=BBt 29 14:22:47 grat-os1 iwd[534]: event: state, old:
autoconnect_full, new: connecting
ao=C3=BBt 29 14:22:52 grat-os1 iwd[534]: event: state, old: connecting,
new: connected

Thank you a lot

Best regards

Daniel

Le jeu. 29 ao=C3=BBt 2024 =C3=A0 13:50, James Prestwood <prestwoj@gmail.com=
> a =C3=A9crit :
>
> Hi Daniel,
>
> On 8/28/24 4:56 AM, James Prestwood wrote:
> > Hi Daniel,
> >
> > On 8/28/24 3:41 AM, daniel antoine wrote:
> >> Hi James
> >>
> >> The last commits on netdev have made the patches for the CQM problem
> >> incompatible. I got the errors when I tried to compile with the
> >> patches
> >>
> > Yep looks like those patches never got merged, and I forgot about
> > them. I'll send a rebased v4 update and we can see about getting those
> > upstreamed.
> A new patch set has been sent to the list (actually v3, not v4). I
> verified it works with my mediatek card with the same failure but if you
> could as well that would be appreciated.
> >
> > Thanks,
> >
> > James
> >
