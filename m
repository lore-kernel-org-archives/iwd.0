Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783F87ED
	for <iwd@lists.linux.dev>; Sat, 21 Oct 2023 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EsiAusmB"
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C542F3F18D
	for <iwd@lists.linux.dev>; Sat, 21 Oct 2023 00:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1697848445;
	bh=ZJ84y0hScOEkj1h6JulZq4QlWt3lxMKLPqGXWjMLlyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type;
	b=EsiAusmBOQYCvz0Z91pp2Mtzv4cVjKyniqH7I7IMoJ1SsN9RyvcG/fY916Wsy3Ffc
	 N0cdugURp9gElHN1tz9FuAnW8vg0LIwKD+qf+tn77SKxsy7SWmF7QVSrrIlCUryoCA
	 W7Q6gzs515RdTGN4w/ITTjkHGPGURXQCOzZd5w4+i7B1M7Ipv334RhGMQxj2ZiuLxW
	 xI3k18R1vCy7ICzi1KvmpWJHQWdGpY/eraExQKEI3wEvRb7kJQ/m4nXzbiiYb0UBlS
	 bGYPlKPRT43Aa6zXeWfeBveAYNcvnsGlwjCf2m+rr9HouK5d69mYCiGLZCOX12v2T6
	 b2n1Z7kExOxUQ==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4084e4ce543so8265225e9.3
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 17:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697848445; x=1698453245;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ84y0hScOEkj1h6JulZq4QlWt3lxMKLPqGXWjMLlyE=;
        b=aH5AA4dzp1P7NWIJbWldgZYeWoSlrg/r7hqLsxR0VUkc0A5jX0hs5j9o0e9RlEQiNO
         T6eJW+GU9+RgtXRFwOmM24ndOiHk8nHeN5gdFRKxQw7k+LnwERDHfxMoUytFGk6GDOje
         5QxpIrb4LJ67MQ5LXFRV3+HVd+dbCE3XtmfB1Mdb7c6MHgEG23eKfcdZF8PL6tXiXIAg
         BGcrJ0Y6/9WUxKbepYKs0oCBSPBb270IY1ACCVHb1By0mx6tTunVCKw9Lp+mIqL+mcO8
         dlPfkrw+LZX4SO8ADErMJ0IhagozEHihyAq1N8xC1bCq2WdeafK76zTcMSntenUF1N1l
         l13Q==
X-Gm-Message-State: AOJu0Yx7u/uHayFJKI4aJlN5jqoKaaRTe+uBNkZxxn53Vcz96FUX2wdL
	9pZ3tZ+aCwRTypMnayBDSRYY4TBZntmMvdDmDVM1TLsNoJDnVLpCKVGscXOkSrTzRaTcUoe4nJa
	oMdsloykehNBLfzoTViWnuFveQpkVQAm2ZygFqG7uUPoFifHWZvt7gXu5
X-Received: by 2002:a05:600c:138d:b0:3fe:dcd0:2e32 with SMTP id u13-20020a05600c138d00b003fedcd02e32mr2598075wmf.19.1697848444998;
        Fri, 20 Oct 2023 17:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1tlHk0OPE+ZtxVf1UUIMXP6SiBLpYc5EgM3Mwmnup3LaGEZ3TLtMEErjaw+lDrzK+Z4t7CF5tznmg312bo2U=
X-Received: by 2002:a05:600c:138d:b0:3fe:dcd0:2e32 with SMTP id
 u13-20020a05600c138d00b003fedcd02e32mr2598066wmf.19.1697848444674; Fri, 20
 Oct 2023 17:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231014235445.167620-1-dimitri.ledkov@canonical.com>
 <075d94c6-4ce3-4945-b765-71ad6285dd67@gmail.com> <CADWks+bdeDgAZKUs6wbdi3KjDHeONO7LkmjX_-9wT15m91PvPQ@mail.gmail.com>
 <c29ea330-c84a-41a7-b5e0-ef44993736e2@gmail.com>
In-Reply-To: <c29ea330-c84a-41a7-b5e0-ef44993736e2@gmail.com>
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Sat, 21 Oct 2023 01:33:28 +0100
Message-ID: <CADWks+au-HzFjSopfHYnpz3kUW1uOR7aEFTe_m0qHfVvJPcfFA@mail.gmail.com>
Subject: Re: [PATCH] eap-mschapv2: allow using on kernels without CRYPTO_MD4,
 and deprecate
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 03:54, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Dimitri,
>
> >
> > But also how does the outer TLS tunnel help all the way? Remote site
> > people sure, but do people enforce using outer TLS tunnels like
> > internal inside the office network? As in can employees sniff each
> > others traffic and still impersonate each other? Meaning this
> > authentication method is still more or less a fig leaf.
>
> The outer TLS tunnel is mandatory for PEAP/TTLS and is very secure, assuming a
> well configured system.  This means that the station (client) side has a CA
> Certificate it can use to validate the AP.  If public CAs are being used, then
> security can be further enhanced by using ServerDomainMask setting.
>
> Think of EAP-PEAP or EAP-TTLS as username/password authentication within HTTPS.
> Its just that EAP-PEAP uses MSCHAPv2(MD4) or EAP-MD5 and EAP-TTLS uses
> MSCHAP(DES)/ MSCHAPv2(MD4), CHAP(MD5), PAP(cleartext).
>
> How the network is configured at the AP is not really our problem.  There are
> ways to separate all clients on the AP from each other via vlans, etc.
>

Ack.

> >>
> >> Yes, exactly.  See above. What this patch accomplishes is breaking EAP-PEAP
> >> support in iwd :)
> >
> > Booo!
> >
> > Ok, I still want to drop md4 from the kernel though. Because the
> > number of users that need this is small, and I would rather compile in
> > static MD4 implementation in IWD than to carry a kernel config that
> > builds and turns it all for all.
>
> Well, you're going to keep coming back and making this argument for DES, MD4,
> MD5, etc.

YES! iwd is right to use crypto code that is in use and provided by
the kernel. But it may not hold up removal of unused dead-code from
the kernel. This is true for any API / Drivers that the kernel has.
Even stuff like network-manager/wpa_supplicant is at the mercy of
openssl legacy providers to be installed and/or enabled on the systems
to get access to those things on regular systems.

And all of these things are optional in the kernel, so IWD already
cannot do this authentication method on any kernels that disable MD4.
Which I will propose for the Ubuntu kernel to disable.

 > I don't think it makes sense for iwd to go down that path.  While
> these crypto functions are old and insecure by themselves, they're still being
> used in a secure way.

The way IWD does it, potentially so, without verifying (or ability to
verify) that the network is setup that way. And the exposure risk is
high and different. Having md4 available in the crypto API allows for
md4 to trivially be used in insecure ways.

The number of IWD users is far less than the total number of kernel
installations. And even among IWD users / a number of networks out
there, this authentication method is popular but with a limited number
of users that is diminishing.

>
> >
> > It seems in Ubuntu we have never had SRU of IWD yet, and we build
> > multiple kernels every two weeks, meaning on that basis alone
> > compiling MD4 in IWD versus kernels will save energy costs.
>
> Wasn't Ubuntu going to switch to iwd at some point?

We did userstudy during peak covid pandemic to consider changing
NetworkManager backend from wpa_supplicant to iwd, whilst keeping
UX/UI/GUI/Configuration via NetworkManager and/or netplan.io

The results and comments over here
https://discourse.ubuntu.com/t/call-for-testing-improved-wifi-via-iwd/17795
and also https://bugs.launchpad.net/ubuntu/+source/iwd

There were improvements for many, but also connectivity regressions
for some - most notably seemingly failing to configure and use
eap-mschapv2 via NetworkManager GUI, or keep existing configuration
working after the switch. I personally do not have eduroam access,
thus cannot retest if this is now working on more recent releases of
Ubuntu / NetworkManager / IWD or not.

-- 
okurrr,

Dimitri
