Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772DB348C42
	for <iwd@lists.linux.dev>; Tue, 23 Jun 2026 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240690; cv=pass; b=GNvHKmgjyWw8RSgBlAFiIZh+rsbw24B5Okol4IWpGsueV/yi2dKexb8gDZsWJZK2Jtx/Smiqta+i4pBbl5nlF7FpFm8vsa/dgB/GF6cYN1PCdEIQjI6ysYBPfhPth91vJuONPTTIz2IKbtSwUgs8XJ9AwXfSxuq9tB0c7tWdNqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240690; c=relaxed/simple;
	bh=Efr1OooVVeTRTisiJfG3vsg/+MXEtgRrVmeiLqYtGck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiqfBY0DFWIPOFwrvcZ+MntQmNIUAZQ2jGHyTM/db8XQYZNTdBYHXBhSn9kMs2losdztaC+aS0BvKNB85l/qJHjLQm8OR/BSX+13fCINANwnQvCL8EtxI2mvCCe8wHKbmosoic3HpZARcnoHTMHbTxUItgaf4bf6CEVTiVj9p+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfOCk0Ye; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfOCk0Ye"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-662e7fed068so102641d50.0
        for <iwd@lists.linux.dev>; Tue, 23 Jun 2026 11:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782240686; cv=none;
        d=google.com; s=arc-20240605;
        b=d0eqEneJxLyyLx2uhuq4Mf/4jCVznjTlgj82UBavsIkFEekIOFMOD78Wz2hcJb6cdc
         MVPXRpscG1cKVS5MD0iB2kMjXFmkYDbdjrAa8BOPHFlujFzTzotI1CeKFEqocsJoeVgi
         dFlNtt8zn0KrtmnCtRcKBiy8+hu/cnhIYPpTEy4Ezxj8S8dEINGey+duKnsvkxmE4VkV
         V0HhU5nNYFlGVr2H/jLmVIly/wkoPrI1mv/vL7WpS55uOr1oSuUx2BJ7Sd8zaNFnyU66
         JMsYK12f5apI1WHNysrxgrtig4hHQCS9rXJDhlwcQG0NGbX5rSp5YBU9kqvtERExgVqu
         uEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QGHdQke52quudoElH5DIY+sbZKk9j5FB05lJCBdajHM=;
        fh=MgsJmFFBMAB1VJKcJrb4/TG5qBxN+sUENH8fGiFR5VM=;
        b=JxrOzHe5DyPhTXeFfR3KUnagsHYHr2vGKdymmGAdUQRlN57qU3e+QZVcsGw4zB8XT+
         KLwgopB4uOGSt/1YN9A2IbevNIZ43k0oXSdznHRZVb4Q/EXFGVGCB248vS/tGFk+d39U
         WQLMFwnB8yCuPRgWo/z4T2z1ThmQTHlmhFQamVmCbeiueNWt4HG9jBzz786yVN3Z8TvE
         G+a6C4ggHT++Mqs/8KLxGXLf5zCIpIxGxFoOU8zjE9zMFWAMMAAaXMhqcSULVD+XUqyd
         iNNNP6ocBXngaF/iC2YqUzWffqEKp3wd8qXw+xwxp++qzEhk1ya8jXlmbdm7CKynkgIM
         pBjw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782240686; x=1782845486; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGHdQke52quudoElH5DIY+sbZKk9j5FB05lJCBdajHM=;
        b=nfOCk0Ye4PwzugqmAYU4BAW+c1E3WLQK+7J5GIlQJFBTE4kxO4V+FqfgRajsGhDunJ
         rcM1wwohmLiJN1Z7TPXRqbAgE+TyHLz1yVp8OqMTjbb+nq6NeI7ECepD48TLH8DjAp3b
         r/auzdoaaOaeobRBJyjxwy79zv2whq7y7r2AnQTYqyEiUhBiLPvJKwzsWjMuVYhD/J0e
         RbfebjuVwc97RcGzTsuOi6L4oOn1rcCDqSuMh0Pr78zJscTMrdrYZ1+kPEuk/RvCx8VX
         pfR6tbdlwHCAo7cN5sjhQMdPdXiK3XzSbyj95hqKr1PAy/C6MfxvIgldWagKD2tC2OzY
         v8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240686; x=1782845486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QGHdQke52quudoElH5DIY+sbZKk9j5FB05lJCBdajHM=;
        b=XtPDxZ9tBePriCevqOxR0zY9IkqKxULubCiYdPof/t8pi+SfNhlay5cHba9COYjJvC
         HIpZ3VEY60YTRFAtbv7Tg6IF7vz3V2W+C0Ggkf0cLI+V3oxY/T+uDyAPC5sMlLcL/N75
         hMwgNbnGQIq3Bz0TKby4bhlgVpjTygM9AV7a/GtaZ687dbhOvvszmk3c0ZBQXBNTJU1L
         t/n3tM+2cFV03C6TDIRcTBFz0hgzUS5WdFKVcsvEr0FoT6ADBT7Mh3wSF2MLsyt8EgIY
         uHJ/iSco495dHi7+XSfHWbrHwW/tAVb0AYrDTAURy5ts6AXkr0ZUQTM8omjYPSxwAydj
         kKvg==
X-Forwarded-Encrypted: i=1; AHgh+RrolmoAAoYAhrNcn3m4RSmrAIsufSMEt6SjhJBm+JXKUl7Z9aSIGpVd5ufR8sXRBSrfeps=@lists.linux.dev
X-Gm-Message-State: AOJu0YyDXMmkiT8hc6ddibQ/MI8QOS1PEMPw8ckmx2uEPjWaO2ydQKWi
	8sV3azKqdCAmIvbNMj3znXP9k3zQUffRpUV/VkBRalTtO6WThoumPqMMEyS56irIX54qzPEiSAs
	Jze7WgMQaqhqgk95J8HSLr83Cc+OnOoQ=
X-Gm-Gg: AfdE7cmVkjrYvq+4bye4C94YZg0kcITDwVr/hmEDWpecaAK1W+ID5f+35TSESmEfFWl
	pipcEYhKsnSndohJ460GuBxJgbSAddg/7AUf+IZ+pMfVY7Cm+pzfaAvNR+YbMquccdm+p6MHmhr
	mnTmk2Gr3WGOL193WLGHEIwqxAvETNGMg7RsXe5LH2SMIaUWtZhk9IeAe9XeUDp+L37G40886EA
	q0uNvXYbUzwtyOos7ZKnz8OBGcQVj35DngGa+JqIr81Pdma9Mt+F6nVqpjyVeu5/szU/Po5U/c7
	srSjy+PVmIFBqCQ7F/TTMeHBoXg6D4/lfc2TlkjuR+DveEqmNsRo1hgfo5k=
X-Received: by 2002:a05:690e:e87:b0:662:f2d1:f27 with SMTP id
 956f58d0204a3-66359ece524mr3827196d50.27.1782240686326; Tue, 23 Jun 2026
 11:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622234803.6982-1-ebiggers@kernel.org> <CABBYNZ+QLvkYkn_EcBZ4+GopyhKqJLcfCoABYcw1VamavbSvhg@mail.gmail.com>
 <20260623165208.GB1793@sol> <20260623180502.GC1850517@google.com>
In-Reply-To: <20260623180502.GC1850517@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Jun 2026 14:51:13 -0400
X-Gm-Features: AVVi8CfbI5Vx_0h2Ev3jl-1KL9OujVxy8AaPvUK9sScHwsY8ABVyPNIyPnDwcl8
Message-ID: <CABBYNZKdd2-S9C1z0vtUB5yMVTWxLHi+Ta0_aUrahDYAq5rpxg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, Jun 23, 2026 at 2:05=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Tue, Jun 23, 2026 at 09:52:08AM -0700, Eric Biggers wrote:
> > On Tue, Jun 23, 2026 at 11:04:14AM -0400, Luiz Augusto von Dentz wrote:
> > > > +=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +0    AF_ALG is unrestricted.
> > > > +
> > > > +1    AF_ALG is supported with a limited list of algorithms. The li=
st
> > > > +     is designed for compatibility with known users such as iwd an=
d
> > > > +     bluez that haven't yet been fixed to use userspace crypto cod=
e.
> > >
> > > Is the expectation that we go shopping for userspace crypto here?
> >
> > Yes, same as what 99% of userspace already does.  Probably you'll just
> > want to link to OpenSSL, but it could be something else if you want.
> >
> > - Eric
>
> By the way you do know that bluez already has a local implementation of
> ECDH, right?  See src/shared/ecc.c.

It's never been audited; it's only used for hardware emulation, I
didn't even remember we had that thingy. What we really use is
src/shared/crypto.c, and I'm not looking forward to having it changed.
With something like Zephyr, changing crypto libraries every so often
just because one didn't fit on a platform wasn't a great experience,
and that is a much bigger project. In the end it seems they are using
a forked mbedtls:

https://github.com/zephyrproject-rtos/mbedtls

I'm quite sure whatever choice we make will be the wrong choice for
someone. Then someone will have the brilliant idea to add some sort of
backend support to let everyone plug in their preferred crypto
library, possibly adding even more code to audit.

> - Eric



--=20
Luiz Augusto von Dentz
