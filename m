Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58B91E879
	for <iwd@lists.linux.dev>; Thu, 21 Mar 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032284; cv=none; b=nnet/d9wxi3XkzvfyDaqkbcYnr9X2udiaIg10snyRge/lHA1gVItw1XiPkCwuihRGKR39RHeIrrJI0ZQe3mZfgakjt0NuzAEcahkkz6IGDP7zvBmhwMKC5GWAmJOQsQ6cuABqsZGrHzcxm+JFOeNQ3e/P9hDU1EjBMtaFJ+RSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032284; c=relaxed/simple;
	bh=GHV19E+IBElV1HjhsoN0rUYno6v+PERuBg5m8iwesa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvsV3tuAh6rvKLU9VqdvNEBugCa5i3rrDs5bmoWZktg1YlBqq0Fi+8FTH6aJ+wjq1ItAjzAqkwWl9HELEiHPwFzc7P6en8ISzlDBi76Vxhj6oeo5sloLxnzP2buoK3gW+m9DHEGP0iRF2KvSN9261mwUiI+xowomD2ewE48ubNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UPSvZHPB; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UPSvZHPB"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6a1ad08b8so11116781fa.1
        for <iwd@lists.linux.dev>; Thu, 21 Mar 2024 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711032281; x=1711637081; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b8VpfnYNXxRvaolQUnhnA+r2PHKQUq2ZHCH8gy6DqyQ=;
        b=UPSvZHPBBNHusw7idCa1IqGUlT+bC48L8P9Lz3JT1jkDtmloECN3eKVEbxs8XILsOs
         kEYngVwrSzy4bXNIDs6f20D+PcFa9rPMxJdFxaLP2mcxaxpPo16boWAh4JJ8IeRn6kNE
         Pz5tBVnVlOgU/T6L0oXSbUhy84KA5TIf4IsJcuOMdPUrONZvqjpsEa0TAVsIw6uCgwvu
         aSbdPW1lWwztZFh7Fxav/9Aw3mdArbFPxECrQbNZ1LjhxjuGgyx7KPMEfwSzw6ixQ4b4
         d/E/FcC4fT+wSIjagedJ4cygq06g5qTNA9OfV2I1CJFrViBVGP67+b4lpjLkLApzpKZL
         lIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032281; x=1711637081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8VpfnYNXxRvaolQUnhnA+r2PHKQUq2ZHCH8gy6DqyQ=;
        b=ViMLJvKzD3pH9XIkfxUWmXYGvctgZ5Dd8mGo8fNNIKHs9fQovfh/USoL/EIFswl3CO
         p5NYgBsD25OB1gBeCTywp1bkTu8pdFeOKwESZ+8tgd2Q22+m9ZWW7h42/qk2kAlKZ+pa
         FuA/fxY+fOfAfZcpgA6BWhTEnEgO+fE73XtDpP9X/lRRQKbjZaTnNQBrdxjxfH2LIkiq
         9xVokkzTGNN0PD/ZU1AjAjLKcDrplnJIN1n7BeWwXaO2midu0Y1iZjT7D6SYvezapCUD
         Y+qbYryShsuwKIq/3qQdJoUhp3TD5iqXuQPk25Pq/cOevx7yYzfTqaevkX814bdSiFUt
         aCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYpAUClMEj4WcsAdDuaq4+i2hnbdpK3IDt2FtwqcvphvxCDCpYuOSCWy8KweaGt0tsRKVSFoN19T/lFMaCgpU1Pobz
X-Gm-Message-State: AOJu0YxuIM8/DzqvvdaZbWpLF3A8os7cZ3JMl7jD7EEoLmmqzlS0UdWD
	sHk2pvyIxPNytPWiSzwGmjBafnnDE/oz55ty0GkkjQeFSfgNkO2MWs9JiISm1tn57sOpL3PXmwS
	BUiZcMd1LfrYSnIwrEegA7qxsqwg=
X-Google-Smtp-Source: AGHT+IGr1ms4JR4kYjpeJV3wIcwJsEiCRzYihEA1mukdW2EGaSm7U9CLw3TEXhqJsiavO3Z/lPGBgFwwkyrqLk1Q6Qw=
X-Received: by 2002:a2e:a0d2:0:b0:2d6:90e4:1ced with SMTP id
 f18-20020a2ea0d2000000b002d690e41cedmr3750172ljm.22.1711032280632; Thu, 21
 Mar 2024 07:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240313233227.56391-1-ebiggers@kernel.org> <CZXWE5J2QMIN.1L4QKQU7C7UMN@kernel.org>
 <20240321041015.GB2387@sol.localdomain>
In-Reply-To: <20240321041015.GB2387@sol.localdomain>
From: Andrew Zaborowski <balrogg@googlemail.com>
Date: Thu, 21 Mar 2024 15:44:28 +0100
Message-ID: <CAOq732+nyLtnafARgfx_dByRNxdw9E0hE8zWvKrPayUrx+MNgg@mail.gmail.com>
Subject: Re: [PATCH] Revert "crypto: pkcs7 - remove sha1 support"
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-crypto@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, 
	linux-wireless@vger.kernel.org, iwd@lists.linux.dev, 
	James Prestwood <prestwoj@gmail.com>, Dimitri John Ledkov <dimitri.ledkov@canonical.com>, 
	Karel Balej <balejk@matfyz.cz>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 05:10, Eric Biggers <ebiggers@kernel.org> wrote:
> On Tue, Mar 19, 2024 at 07:20:54PM +0200, Jarkko Sakkinen wrote:
> > I'd like to think that there is common will to eventually get rid of
> > all of SHA-1, and thus in cases where it is not yet possible it would
> > make sense to guide what to needs to be done to make it happen, right?
> >
> > BR, Jarkko
>
> This is supposed to just be a revert, so it's best not to mess around with
> adding additional stuff that wasn't in the original commit.  The sha1 signatures
> are also not unique; iwd is also forcing the kernel to keep supporting MD4, RC4,
> KEYCTL_DH_COMPUTE, KEYCTL_PKEY_{QUERY,ENCRYPT,DECRYPT,SIGN,VERIFY}, etc.
> Probably more than I don't know about.  I guess all of this should be documented
> in the code in appropriate places.  Probably the iwd folks should step in to do
> this, as they know best what they're using and they got a lot of this added to
> the kernel in the first place.

As far as I know none of these were added specifically for iwd but I
could be wrong.  RC4 is not in the kernel anymore.

With regards to SHA1 it is used by iwd directly through an API but
more importantly it's a dependency for x509 support in practice.
Outside of module signing most x509 certificates in the wild use SHA1:
wifi, https.  This thread originally talked about the removal of SHA1
access through some API, not SHA1 in general.

Regarding the use of the kernel crypto in iwd, IIRC some of the motivation was:

* to avoid duplication.  On a small system it's hard to justify having
the same algorithms in the kernel and in userspace.  openssl is
probably larger than all of ell+iwd.

* (various arguments can be made about how duplication doesn't help
security, but an argument can be made the other way as well)

* there is (was?) a plan to use the kernel keys API to abstract
passing keys/keyrings between processes to greatly reduce the presence
of the actual key contents in memory/filesystem.  Network Manager
could load a key from file or a PKCS11 device and pass its kernel
handle to iwd or other userspace instead of file paths, with the files
necessarily being readable by multiple processes and loaded multiple
times into memory.  The keys could also be loaded once on boot.  Or
the keys could be in TPM and never be seen in main memory, only their
API handles.

Best regards
