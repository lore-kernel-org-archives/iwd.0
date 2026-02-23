Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815230F7EA
	for <iwd@lists.linux.dev>; Mon, 23 Feb 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865001; cv=pass; b=o0dSy5Dat9AXlU1nghTKNdkR3lsM+2B7wNFdGfv9AabYlbplIO+4gxoPcJ/bVpihvUQM4m15iEv05QeCCyp4kDI5Y5tNKv+7xRqL45BDBLAZCmPktVacDPGoO+C8g0lU0Ec2nboBRN0t4IZiwuoETx3CqivJMB3vUhASp1AMS6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865001; c=relaxed/simple;
	bh=C6Sdbil/tk9Rpt/yBRwbALrfs480Mf9cjWMB+C3I7nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WfyXMxPdVaUYF26CwW+FprcWocqdt971VVRaZ4pf+dxuIAcN6bBhi8BcLQajT2lq67DSK6l6xUDz+5IRkKYmNbVYRQ/U9N5RssmwSieI7dPlKqqnjqIv+dMXLT3afB7nyhMbUIZql+L+ogQeltQZMG4zcfhQtj2jNMbMjtwq0bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS1Y3M0d; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS1Y3M0d"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so98804fac.0
        for <iwd@lists.linux.dev>; Mon, 23 Feb 2026 08:43:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771864999; cv=none;
        d=google.com; s=arc-20240605;
        b=Itnu0je+gBP0CkUcOGWlEIi8ztQBd0UAz4OdCYw7SttEYGJdI+m9g0xMUOB+sTT31t
         KOdN96+wla7C/k5dAfK3nvg6xHzctouVzDvJ0LNDG6mDEOU66KqjvbCCEYeAKuF5h+r1
         8Nn2nl2UDA90G8aJeVSZZADJ01ZRoAYhxlS2biRC7o+s4bDFosk3Vi0kSVCMn0+ixmBK
         zwYWU55LdiSEycjy46lw9B2MwScyXuklQZzJiFG6HVPAMhM8hdsvl5dOv0EJJ862/nBN
         0mTmP6o/Z0gXebjzizUeU/PCb2dg6Hv89fh4nabzet+ZFega7GByrmmezrgdrRzH66oz
         flHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C6Sdbil/tk9Rpt/yBRwbALrfs480Mf9cjWMB+C3I7nk=;
        fh=LVwSdJJT2poHpWJpvI73c3fFqaJVA08Td3ZAiex6+kI=;
        b=jG0fvIcJuqHTnJDHCTBirrN2Cg4CxEpNdPOPe1ecjlg5b80Ug/A4CHRBUHiCNHhsUT
         wu2KZhXKx7M9DbiE5vBCozojIzY1yz/NB4MgKXj6CHP60LJn/TG4niT6J83kM6I+wtuS
         523moCdzgPVji16d3Lejb/ORr+Mx8DRusdsqBOXNzj64p1SKYfbZVGjOM+gLiTy2ZSx+
         QHueRjWNBvGEbDJhIv2oKwRzEygzxYcxFNLpzldQ5a8lRdHqPIaRtTwzyaAQ9Q34mt1S
         anwpgydouoRWXnpouDgTVwVIeAggPl2M4UG8o7pTcnnmqU/kscTnRNamke9Q6tOQHXkK
         1Amg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771864999; x=1772469799; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6Sdbil/tk9Rpt/yBRwbALrfs480Mf9cjWMB+C3I7nk=;
        b=eS1Y3M0ddJ2SYrCFwvxtgTV4Yf4RkkzEyU/QYBYAPLk5Ride9EcIAL39fYOTT7yK+A
         D8OWiMiII5nQR8Tcz8oPjGmiO2E8v9z+aIps1RAtJh/df6erOZpOt6KlRnVI/pbgplUG
         Wmr7tSWafuwzqa3QGKLz1dIWotT0cHp3MwpcAz9yRd+rOmdZpY9mIBfhRKp3elGERAYJ
         /tlW/2V96xoTxzqH+7Ar8tcKlrIQCzVyrGOoUSbfudv52M1S05UjkzMMVDcBOv/p8tfj
         TOoLlbZDqhvbR2EFlNiNJw2Wp1xCix9pno+CaOWLg+a+L9QscOAzPZYH7H4/Y2sEe3Df
         lrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864999; x=1772469799;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6Sdbil/tk9Rpt/yBRwbALrfs480Mf9cjWMB+C3I7nk=;
        b=E2oHCD4zC/LkLxEJAjSBFX63LxNJWnsE0lxhDIVS9xgty+R5AWf/z9fkX3DoqeAQQF
         pQQPGJIAKagRSQ7hLFIOQ3DI5Os+eFfQfy1n1AApgIxKKtB3xB2hz6RLO+dnTnGhQ/bE
         LY8jZzIp6OY7hogEbGbe8il4uGOa/9suh47WkSsQvAMlIr80OHVp4IUihyOAD2+CyP1s
         pmLlcRqfRl6TzwFCtHFn4jsZQ0cmv2hiRxvfl0VKJax+PIxQ77dmHea60X97/eUKS0IT
         ttTLlh4uOkfyHNRyQPTW7vGcmHCaLG8dgNdkN5d5Kcxd5SAh5mGmI9cZC2TS9GLletED
         bgkg==
X-Gm-Message-State: AOJu0Yw2LfRL4wcVed3kR/dpdZF++/tyveVrab1gPWyEHYfzOAkHwtdR
	WAp4dgghf6FY+SL2hPmU99ID6Ix+eLDyWq9TD1ZZdNY7ejSaPKvR+j8IB1pCGJg2yB9qq+Q5EI3
	B2pBCiugdxVeDG2bhpb1V2T1wFZTMI9X43cZDw28=
X-Gm-Gg: ATEYQzxfb82uuc1Zbn5+Q9V8Buh5FaL/gZNd6ZyCHpB8+4/imHxJLDeKNfRLlvYOTO5
	Ie0mUMcE/NSoavzzdJYXH/ruCOdMELR7oztrnrymGc2LNzCvTUldvKSmpWvx1HW+gt49jURR49W
	TMYDT/+cgLNo79t9Xy9oIzY6ai+k3sCplY3cO6jtnHHiwz3Bpm9hUwRkvXjduFRG7h9IcN/2Fxd
	JoAp3cz3WRwDl6RNURX8riH7/FQr7W5VZ++bICAXAXqLQm2hNpT8rtbuf8AgB4ONAwMFCB/scno
	7YVoe005Ug==
X-Received: by 2002:a05:6870:9a1b:b0:404:3cff:5158 with SMTP id
 586e51a60fabf-4157ac29ec1mr4723495fac.16.1771864999135; Mon, 23 Feb 2026
 08:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANZiGuEaFwDLHD8jGk4-POxfnJAWeER1ss7COtur8b0ohEi3Fw@mail.gmail.com>
 <72a14187-ae0c-4de1-898c-c416de541e7f@gmail.com>
In-Reply-To: <72a14187-ae0c-4de1-898c-c416de541e7f@gmail.com>
From: =?UTF-8?B?Um9tYW4gxb1pbGth?= <roman.zilka@gmail.com>
Date: Mon, 23 Feb 2026 17:43:08 +0100
X-Gm-Features: AaiRm52sCKpO8SD70AkBHqFIFcZnDMTB7ljGHnwgk_d6yrv_P3YbuwlktliIHGE
Message-ID: <CANZiGuHAzX4GDQvEKHDRoWF-CMdaR26pVarEzr1PSG6HLyrj3A@mail.gmail.com>
Subject: Re: systemd-networkd MAC address randomization stops working when iwd restarts
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

James,

On Mon, Feb 23, 2026 at 2:36=E2=80=AFPM James Prestwood <prestwoj@gmail.com=
> wrote:
> Looks like the issue is in the configuration. IWD removes/creates a new
> fresh interface on startup, which conflicts with how you want to use
> randomization with systemd. If you want systemd to manage the interface
> you need to tell IWD to use the interface systemd/udev creates by using
> this option in main.conf:
>
> [DriverQuirks]
> DefaultInterface=3D<driver>

thank you, that fixed it. It has no bad side effects, does it?

I have to say, the situation still looks like a bug. Having systemd
manage the interface and using iwd for 802.11 is a supported
configuration, I assume, so iwd shouldn't collide with systemd
components then. Also, I would never think of looking at
DefaultInterface: there is no driver quirk, the name sounds unrelated
to the issue and I actually don't understand the terse description
(what is a default interface?).

Cheers,
Roman
