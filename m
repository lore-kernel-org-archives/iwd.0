Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610681D5ACC
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780372; cv=none; b=BR0ZyrcRxSqITWtOalt+KyzIVWaHHl5KBK2XtzGCATgeYVeEGxERqnPUcb/QrEkmEsRLnh+CBYREqHBbUAE7Gumz6o5cnnA3X8ZnbSKvYxDKgxyGpxf1PzuzZ/22xCZMc5XwZMaETU+UlJbSQ3zo9BEoY87yo2Ove3yS2CallIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780372; c=relaxed/simple;
	bh=8p+rWA0ik7FAh+TgqWklXnrtZWnz/NCrIT/8tDjqpVU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lvRSMIjWum3VO2n404OcoyjdrHjR5MPULgfWzgQeM9R36P2ToCLWKOqiJMobZaPJFGIvs0TaaGyarpIJfFdTaiMGfkNX1vTf75hscLCNHdFyiRrtS1bFPwrLUC/K+uox2CYVC0OCbdgLTh6KwTCULHT0HNDVQROE3eckrLQl9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHyOST+M; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHyOST+M"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so11107471fa.2
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729780368; x=1730385168; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOTSfP5agu0Gr55L8ujhBFXd5tWgYRhc+xaJbRbz0zE=;
        b=XHyOST+MqBlze5C3XzP86XcPhNVhhaFupABTybC5zHibiGzm/sSqdfGKycycRiF9ZX
         2UPEs4mDc2uErzoGWzk7YJnWZ4McNWIL14GH1xzUN7Ff8Cvnv98C/tOt8yWjot6BbXmJ
         FXSl84Jrk6j3WTzmqSCj714THmkOfS4A5SiZRr3AZbp/UAPfiS49DqgYZnMk9iva6HNW
         T2EiIkzVC1sYf0ZMrTJXxQc8eEJtqrlpOd7cWiq278YoFs1LsNtqQJZSD09RZGRCbH/s
         k3/u+dplE1cxo9qjC+p1GR8eqHQZ33pYf1v81g6gTfeqZ4lh1UzwHd//qovC1c26xbLi
         dTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780368; x=1730385168;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOTSfP5agu0Gr55L8ujhBFXd5tWgYRhc+xaJbRbz0zE=;
        b=Kvi3/5XNnJZXAWdo6daRCRF4pTpL8C1gdIazM85f5Xg6y2aU7mm4sKNjUGGXIbbom2
         eVTjoGGf691eq2tOZemIonJ//hnRAAdrR2ueuhkLHCNmZqCFlmqGXuiI4q8OJafl3tKq
         45arkoNa6ViU8FDxSACvgav5IWUWg6VF7KbzPOU3zxw3AF5AWXYlQwuK65kDhXQwczNf
         bz43iW90AOUlK6e3H6JziWIISYN8hYqubpF9ZZbczrRn0dRDVibn2j7hFOuBtxDh5Q7F
         8Ah5VEU7flxaHI6p9bYUNvX8rHOMmpX54LoMFZvgsr7W92Frm9STi3NW9PC+QoofBsnF
         5KYA==
X-Gm-Message-State: AOJu0YytHvdMvIdtbYry1a4Eqbsqz6C6nYrqnGi6EPzGuxqwAiXxKC0i
	HNAlE0RmnBEnKWeDNM6Ej0U8cKNFBsli/KZgDDgrHz42rwbiQPsg
X-Google-Smtp-Source: AGHT+IHsd/g1Drb64+Ie6zNCoMc4BiET7jH0NjOk4a29ZFUnXgDnr4VwILscJAot1NdqBGUSFXq87g==
X-Received: by 2002:a2e:4e02:0:b0:2fa:fc41:cf80 with SMTP id 38308e7fff4ca-2fc9d48c2a0mr28008991fa.43.1729780367929;
        Thu, 24 Oct 2024 07:32:47 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b530sm5778660a12.2.2024.10.24.07.32.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:32:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: iwd 2.22 scan fails but... works ok with ConnMan
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <d27c9f76-ee7f-4509-a05e-6e05ee444181@gmail.com>
Date: Thu, 24 Oct 2024 16:32:36 +0200
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <A112F6DF-E1BE-4350-86DD-7A85BA4FC1CA@gmail.com>
References: <CF5A13CE-18AF-4A33-98F9-13FA353657C4@gmail.com>
 <38b1af93-83c8-4cfb-ae63-5e480ac4420b@gmail.com>
 <D6BB0209-39DB-430B-977A-955928ED3701@gmail.com>
 <d27c9f76-ee7f-4509-a05e-6e05ee444181@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Pls see inline

> Wiadomo=C5=9B=C4=87 napisana przez Denis Kenzior <denkenz@gmail.com> w =
dniu 24.10.2024, o godz. 16:00:
>=20
> Hi Piotr,
>=20
>>>=20
>>> What hardware is being used?
>> this is allwinner h618 zero3 sbc with uwe5622 wifi chip.
>> Kernel is 6.11.5 with uwe5622 driver backported from vendor bsp =
(https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.11/=
files/0630-net-wireless-add-uwe5622-support-v20231020.patch)
>=20
> So yet another non-upstream driver, sigh.

Ah - believe me: mine frustration because of this is much bigger :-p=20

>=20
>>>  Can you include iwmon output?

After compiling nlmon now is much better: =
https://gist.github.com/warpme/4b21b51dd1e2c74075498acd9af5082d

>>=20
>=20
> Is this in any way related to the problem reported in this thread?
> =
https://lore.kernel.org/all/CAOCHtYj9OjZGQ=3DG139i=3DKRRcxpFD-1=3DGSvUPmFY=
aqSvFz0NwJg@mail.gmail.com/
>=20

Indeed I saw this thread.
Some time ago I was trying to play with iwd.cfg without success
Maybe I put incorrect settings there?

May you hint me what exactly I need to add in iwd.cfg?

To load wifi kernel module I=E2=80=99m using: modprobe sprdwl_ng

Btw: all was working ok few versions back of iwd/kernel
Unfortunately I can=E2=80=99t say which change: iwd or kernel breaks iwd =
operation on uwe5622 wifi=E2=80=A6.
  =20
