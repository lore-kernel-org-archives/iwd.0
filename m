Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C033D39D
	for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jo+NUxdY"
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9A9603FA66
	for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 16:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1697646534;
	bh=ZJKykMJF3gq53c4EIjf8aZLnFe+FRyO9+LJCDFelrm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=jo+NUxdY6yUNklrXhpA8/Vetw9qf8p71vZvUnvpgcuPx09/tUIDTubsVueWedR4a5
	 yPXN7aik+SF4PcrRTJSHNASnLGAS753I3RA8GvZUt8N1xcQ4AKNLfFufpFIpYairM/
	 lR9YuhfAP3m78+tJfUtQ8q8cGVQ38dexk/AmzvmrCgh1EX6wnMhOCqWB/337h3hgXM
	 LTtm8uqal8V6o/nKNmGKuS3qWtI8+3EeKJnTicsBy4tfy0Kykr55hldfwNJWspXFIa
	 BuZiMuNICybASWSo/3e+vRmVa9rxkB/bSSZ9Pv7eIRc7ykS3+KxOAqJRxU2OEnGR+4
	 8912knPOeJ1jw==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c51e44a4dbso38047591fa.3
        for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 09:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646533; x=1698251333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJKykMJF3gq53c4EIjf8aZLnFe+FRyO9+LJCDFelrm4=;
        b=qIOOzwjYCNKtmm6hlvAYvGUhyadNvzNsBmcuz801Sdfh2cPpXkhGaqYLMFimIi5u8w
         bjW4O3yyFyCGkY40O02/VWKTBFdRUVVqy91FHqmZ4vNm1ajbwFu6t9isLSngn7AkjFxY
         A81jIHzCS6Nyi54nmICBeFeeAxFkXhiE1NAganDlwz1GgQZmQ/Mz8KtHafARUMPuS2KR
         u83Yv4kjyq/NB2J0mHLfQuxC3q6cZ3ye6VajyT+nYMcD81krAhP4ArskBg85C03Fx+lM
         XSz73+sljKhOLPMimgBXo6Y063m54ySCTLr8q4cwLUvT1KbDH6gfxENcT7PMFPQuBEb6
         0XsQ==
X-Gm-Message-State: AOJu0YyeaqP+LS9kMEEkcxned5OBsEVBEQJYASGPGyJCO3xx2BrbpC11
	098PfBqJt5InHAm62a34U0ZC4OhjSxAkjc0eTHkkZ07a+HC4Lum8ZsCmZqp7ty48D2YI+d6nMJi
	dMC7i52MDh7eTwY0OJST6SfD1sKahtgGyEI7g7+P4TsH38yVcfpX2WA==
X-Received: by 2002:a2e:a994:0:b0:2c5:2d7:412 with SMTP id x20-20020a2ea994000000b002c502d70412mr4620043ljq.19.1697646533766;
        Wed, 18 Oct 2023 09:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGisi12cAy8lhBT0EpIEOCWkHWz2zgHbQfeMOXlHawHtzzGPp0E2PZNHwvENjUa7Q5035cw3fuPW84WhmSysw4=
X-Received: by 2002:a2e:a994:0:b0:2c5:2d7:412 with SMTP id x20-20020a2ea994000000b002c502d70412mr4620032ljq.19.1697646533329;
 Wed, 18 Oct 2023 09:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231014235445.167620-1-dimitri.ledkov@canonical.com> <075d94c6-4ce3-4945-b765-71ad6285dd67@gmail.com>
In-Reply-To: <075d94c6-4ce3-4945-b765-71ad6285dd67@gmail.com>
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Wed, 18 Oct 2023 17:28:17 +0100
Message-ID: <CADWks+bdeDgAZKUs6wbdi3KjDHeONO7LkmjX_-9wT15m91PvPQ@mail.gmail.com>
Subject: Re: [PATCH] eap-mschapv2: allow using on kernels without CRYPTO_MD4,
 and deprecate
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Oct 2023, 20:46 Denis Kenzior, <denkenz@gmail.com> wrote:
>
> Hi Dimitri,
>
> On 10/14/23 18:54, Dimitri John Ledkov wrote:
> > Currently eap-mschapv2 does kernel MD4 check during init time, even
> > though it is possible to use it with Password-Hash on kernels without
> > MD4.
>
> While this is true, I doubt many users actually use this setting.


Ok. :-(



>
> >
> > Separately, mschapv2 is obsolete, deprecated, and removed even in
> > Windows 11 22H2 [1][2]. Add an error message stating so encouraging
> > migration to PEAP-TLS or EAP-TLS. Separately, warnings like these often
> > don't work, thus likely need to remove this authentication method
> > completely.
>
> Hmm, from this description I think you misunderstand how MSCHAPv2 is used.
> Indeed, just using MSCHAPv2 as the outer authentication protocol in EAP is
> broken.  However, nobody actually uses it this way.  In other words, while
> EAP-MSCHAPv2 does exist, it isn't actually used.
>
> However, EAP-PEAP mandates the use of MSCHAPv2 as the inner authentication
> method inside the outer TLS tunnel. "Migration to PEAP-TLS" already happened,
> but that doesn't mean that MSCHAPv2 isn't used.


Sadness.

But also how does the outer TLS tunnel help all the way? Remote site
people sure, but do people enforce using outer TLS tunnels like
internal inside the office network? As in can employees sniff each
others traffic and still impersonate each other? Meaning this
authentication method is still more or less a fig leaf.

>
> >
> > IWD usage of MD4 was brought up on linux-crypto mailing list [3], upon
> > my attempt to remove CRYPTO_MD4 from the kernel which is no longer used
> > via crypto API by anything else.
> >
> > It worries me that internet searches suggest that EDUROAM (a Wi-FI
> > network spanning 106 territories) seems to still often use
> > mschapv2. Thus dropping this support may leave millions of people
> > without connectivity. Given how broken and isecure this authentication
> > method has been since 2012, I hope that EDUROAM is migrating, or has
> > migrated to P/EAP-TLS.
>
> Yes, exactly.  See above. What this patch accomplishes is breaking EAP-PEAP
> support in iwd :)

Booo!

Ok, I still want to drop md4 from the kernel though. Because the
number of users that need this is small, and I would rather compile in
static MD4 implementation in IWD than to carry a kernel config that
builds and turns it all for all.

It seems in Ubuntu we have never had SRU of IWD yet, and we build
multiple kernels every two weeks, meaning on that basis alone
compiling MD4 in IWD versus kernels will save energy costs.

>
> Regards,
> -Denis
