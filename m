Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F01DE3D1
	for <iwd@lists.linux.dev>; Sat, 12 Apr 2025 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744491558; cv=none; b=NrL3MHe/nJHFGaN2vY+kjmI8ZAO1tCY5Onwm7maxLUoWvQ40aVmUhGUneEJZaXzyTXbMF3TsmONSICTrYbFSwzKgod/t5E2MCFaD5yOxJuAfpKKu1w/Ytq9x3C9iOhWG7YQ8hIDwTvz7ZwEo/ssOhrM8ZDXhgTQnimzTQDI3UW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744491558; c=relaxed/simple;
	bh=EmIx6lzC5C7jsIU0OSjy574x+VAvnC3YiaJ8okMVtgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4KCrTFVeM9D4y143YHJBEyIX6zFJ78ejWu5ZRXyMseT3HYRbiM+K4tJo7HnXSFMbYm/3DTRSjV3RBJoWW1LPKWGfq8WVmGM/1aSUKDMsbpN8knNFdYn0G6sDTjV/EP8APBycix5yWLyfl63lo5F5E9p2Up1dRSWYPB7KfQgQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ1fIerQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ1fIerQ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so3368424a91.0
        for <iwd@lists.linux.dev>; Sat, 12 Apr 2025 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744491556; x=1745096356; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyG/QZYpCdIo8As1Sz9H0CtHaBbC4D7aQh68P1C9aB0=;
        b=kZ1fIerQC9+WjYwC9spYDp4Z9AcloPCqiaLtYJPsRhQfTIIPau0rBE3Ik2xCURGTGk
         YTrwuP/ue4yi1DbRlDgkDsi1+djT9Gyujo8g0v+AT1b3KbytgKXum4Rv0pWn6nB4HXbD
         VTAOkceCBQxfX3yJkxoEQnt90gc57rjf4qbHw4c50sMh5Vtjtpu/LSY1FTxx57+RwzR4
         eNCJf2Q3lYi0ZwVvsDbcjxVbcvMLoLlzwFN+2bHZgIGD2sPjQ84mjWAkoG8j2ADLNIzD
         6nItV7y0UChsidiH5b2OH8Lt1V9in8uW5K83stmljeAha7W9kpn5mGYTe8j0mlDYsp0r
         LwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744491556; x=1745096356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyG/QZYpCdIo8As1Sz9H0CtHaBbC4D7aQh68P1C9aB0=;
        b=Je6prouWDKfZE60ym/K5s4fQhNKwzdSGtcZAJx1/SUonCxv3B7vdaK1o/I/ii+1w7f
         wJ6fONBi5zPp02+L6BhiHSKh7cNSFWCAk5ODgYOXPKmLqDoYi1LdDyk8DVDDuYkaYADi
         sy2BUtqMpEuxg64JO5E7sGYWmLRFIfRIQa0a7cQSbjjwdO5kpF45usUcQMBkoHb+0MO8
         iHFHie0pxCKjqdkZiEusNmFKOTF7/vq6YzwxDPQet2cnqNMTGTk+L6mZuf1rnMJbdbI2
         q/FF8ADUHCq2qGlemNVvgXT9GSjcLkIWcuX45QbFtmzI/w+W6BWFdBraoP2zJFr0pM02
         pAVw==
X-Gm-Message-State: AOJu0YxtlDwNFyUU1z6qgkVmytBRz2tlObudDv/S6Oab+337aCuuwa+t
	cddGIzsG7puMWsL38bNZx2v4BpcyI/86h0rcu+/UhG8UWTjIFLe72CnBCIoFyTmLAAIUkqk4b1h
	4BdAs4Fy3AlS62yA29CAWYlmNz8A=
X-Gm-Gg: ASbGncvwByzJfGpMuc/Fq03YhIGDRxvlqq5pYrNipilqpelsZiEIzDow7lSysau22oC
	NHB6PYTqye8TxRX/AxSrvkr1quBBHdkQzuDb/GdQxVspnj0egBo78DkGMV8S4Ofgf8uv9kdmzQa
	kRg2d2ajr4ui0zXMzZFiUM7fjY7PRNhC65J1s=
X-Google-Smtp-Source: AGHT+IFIFA55BpUsUJZtl4mRG3pF2szecM+Nrmg/7PWc9Ry28k0aT3yGrCBLugJZkABP2L2eirJCEBoiT3ySLxi7PNo=
X-Received: by 2002:a17:90b:4b8f:b0:2ee:f687:6acb with SMTP id
 98e67ed59e1d1-30823646af9mr11040011a91.13.1744491555514; Sat, 12 Apr 2025
 13:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_NCdQ39dBaKtNdiF5yWcX=sgpppPxqhifM+Oik4o=s==A@mail.gmail.com>
 <da603744-b1de-42fb-bdd6-61472a684d85@gmail.com>
In-Reply-To: <da603744-b1de-42fb-bdd6-61472a684d85@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 12 Apr 2025 15:59:04 -0500
X-Gm-Features: ATxdqUGqlEwetPtVyiMmSUHT-mzpka4E6j9Ncigx_rwMq4ewJLFyrZRNZGJXrmE
Message-ID: <CAG17S_MPOSsmVoPaLNoOvANLEukG5THJsx9gVaP0xHpXYGnwFA@mail.gmail.com>
Subject: Re: how to get scanned network strength over dbus
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Denis,

Thanks for the help, but I figured it out. The script in the directory
'list-devices' illustrated how to do it.

aside:
Our UI is dependent on some of the output and format of some of the
connmanctl commands.
We wanted to remove that component and I was able to construct a
python script that mimics
'connmanctl services' and 'connmanctl services <service>'

This was able to get us going. I noted that the Pi boots significantly
faster without connman. We now use
systemd-networkd and iwd and have a python script working to start an
ap0 if the wlan0 disconnects
and then shuts it down if iwd reconnects to a known network.

Keith

On Sat, Apr 12, 2025 at 3:23=E2=80=AFPM Denis Kenzior <denkenz@gmail.com> w=
rote:
>
> Hi Keith,
>
> On 4/12/25 1:48 PM, KeithG wrote:
> > I am trying to get a listing of ssid Dbm values for my UI. I an trying
> > to write a python script to do that and ran across the ones in the iwd
> > directrory
> > https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/test
> > I copied get-diagnostics and ran it and it works for the conneced
>
> diagnostics is for the connected BSS (not network per se, there may be mu=
ltiple
> BSSes in a network).
>
> > network. How do I get the dBm values for all scanned networks?
> > # python3 get-diagnostics.py /net/connman/iwd/0/3
> > ConnectedBss : a6:2e:48:fd:9e:73
> > RSSI : -57 dBm
> > TxBitrate : 292500 Kbps
> > RxBitrate : 292500 Kbps
> >
> > but I want this for all the scanned networks... Is this possible
> > across the dBus?
>
> If you don't need to know the signal strength of individual BSSes, then
>                  array(on) GetOrderedNetworks()
>
> is what you want.  See doc/station-api.txt
>
>
> Regards,
> -Denis
