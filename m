Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958F37F8AF
	for <iwd@lists.linux.dev>; Tue, 23 Jun 2026 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241960; cv=pass; b=NQ12BGY2NVBscOPH/axWgGnu1lYLYFprRbYWAjRRK9VxNd0L93qUzK6FHnCekhcFFSBqc6fkcQWs5mrkMboN3BvBaKBhyunmrGaw4/LaH3fZnrISuAh1n1A7yY9kZmC3DHDBUGH77iK7v8iW9z2wgXxktoFIiVo5XgsrOeCUEdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241960; c=relaxed/simple;
	bh=ii6MvtTjLi70cljzH6vlCK19qdEyYEgO4Rik7cd/sMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBpfWXp00AZ7NTBbW1tp/dEHdrA0HN8XpkFtlXZ/KB42GEW6E9V/rq0g32PctXQ1BzGVkZ+9DoYwiyZJudt+cpbd9tQ4IVpiEV8Nqiysd9jn59iZ5it5L4VwrIf8ZqPERUSVwsZA9AedDNcGVI9L6cCg20KaVfRA9zeVQvzA89E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=BvL9MZWd; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="BvL9MZWd"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ad68b30252so213564e87.2
        for <iwd@lists.linux.dev>; Tue, 23 Jun 2026 12:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782241957; cv=none;
        d=google.com; s=arc-20240605;
        b=GYKvPaBOOkKw1EEIO5CNT5qLcCrDVVokowHYrFmlF6mfeQEkWSqG1K25Yejpw6Tk0y
         lDbMEKCm60Z/1LKFj8IN28Og0kEKT+XAWCU5fka2IpMwy4zrUepQSCkYWUjqvshTnoB5
         WgNm3K8pGPQcjpBTjv80pbS8exijipyUdNEvaEkv+Z5JGALNoqFeRVFH2AL1Dzw39nkW
         /7o3iDvzrAPCRE5OHtEt7/toFOgU+jvMd0KagpGbVP2SYr7OivkmEvHaVsmj9S+Xjx5t
         U8/tYT5ie84eOyt6TXaM80tVIQbBfdZNsPyZ05qnLAZUJGWjCoIqaBdJTZ6cEXE3mACp
         jmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/vvDwAJenwF6coS01e9xCYrLEyTAVwYfnUT70JedLS0=;
        fh=4SVNv0zs0lTNre91FiqKKmxW9BB213JxEl0ifCga+Yc=;
        b=Xz81Ydbj4pSfkP851j9R/htp0/6pHqmij8W+sI1xSne0UrV4mwg0HEtZy0ViEKTYg2
         DNEskbtrBDOMIDYhRtnUS74IFypuarDF2JHPRdYtfNdjzSywBtmmlCATBclNEZhVO7Cl
         La/yfgFedHzQsUnC1UMrivB5IJyid0DFGBON5129rSX2F13xl8MYoXUVM4Wkv9bl4fIO
         q7sCgpqc7qZwLQOBXMfwIsnwVowAXzjQxaihsJOqaFldPq0v6jjj+yhMtrD8lnVWqvI+
         tdR2R5oboXP+9lfusqIlGf0f3FqsR3sHutOJWgdL2UDrgR6I2bTqO51MCpbuq/I7cKD5
         PhFg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1782241957; x=1782846757; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vvDwAJenwF6coS01e9xCYrLEyTAVwYfnUT70JedLS0=;
        b=BvL9MZWdS9HDH1oSluq/2vg6KaFox8npkP8xthUmOPlhkLlUqvhzgxEsAevgu6w9kE
         yB2Tt0rxaeuVwG6DMSlGXO+lnIjsC0ZC5w6j654dCCPrRNymPuGn1YCYsa/F+F8jtjTG
         nDWHX31DQ8l/zTFOhWFVoATX8TyDtyDY20rwSWfs35PhgkVbXPtbMr4k2o+YHl44bvoc
         MUaVNFBzNSbXpuDgbRq+VLOCrh4dE6QVSRbQ2UhtVYMbyLO7q+VXePkcIlaOu5GWA31Q
         MBo4RAvaldseamC2wNBD//JLRAmmZfP1RTiOYNk4gUGdDUWE46Vzdqf10jD29df2eZmr
         fJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782241957; x=1782846757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vvDwAJenwF6coS01e9xCYrLEyTAVwYfnUT70JedLS0=;
        b=SYcBoqZlk7rb3/UpbttxAFgTRy0DWAvwaiMrueaLrwvL8LLWkaZ5zwhBKmhye4rt3A
         DOC/uGUo4aioZWUX736likMvv4+lUUu3YyYJPpZ7AqXC1Ap09Q5oOdDoObIWRDmggYdN
         d6qvM8TC2d/QcWf1nOSDfEj2B4qSIps7mCedJgRWw0X3z9FIp11crCK7zySyWtFRjcPI
         haBfZBtMjf79FsH/ct/RBgjVX60aqoh/Uyx2MuJdyKc/EwYaTK/RLpAYgx86nEFlljB8
         3Qx97936+PM9qKnMOGrkzWRaVpT9ACycyU4vl95rmE4yZrAMxh4qeiSTwekEn1Qejx7m
         q8Pg==
X-Forwarded-Encrypted: i=1; AFNElJ8o62YZba5w7WdiayxHnx32RAe+033xn9HbYeQBbNrFXKIhq1Iidhccb2MzOPlrgdbTA6s=@lists.linux.dev
X-Gm-Message-State: AOJu0YzZiSi5FuOh0SV4nmMBrqVuD5siXi2ezSsuB5HaRfQdsdzWYxac
	cmzAYdFFCJ3mHl27G/+AFwY3+HKQSSTvanQ5fT5ILXJw5L4+D7WMNPwIanLpIHUy7H/rDcU6OyQ
	EICNon/DdCFANzuTiMY7KGYi5Y/KHWvoz/Q/n8ADf
X-Gm-Gg: AfdE7cmelcEYo0ek0OjifzUbsafh92PgKWN3IT6fGwBfSyC0p/RAo5WtrnBd18STiYK
	PQ8swENyo3AXquNAL64IDbBAQDa9F5k3lYxb7hW4OrC3If0CUpxgGPSxy6S+v2/RBdExh6ZKm+E
	BqV8mtzjy8qs4ULx1N7kCFNhDgRHp+2eJ6A2Ly8Dla/gjRvhJx8g47bi0VgmYLhGm105dTjWyBH
	Wg9rHMATWcPtWoHHJTEVSaS8PKlxEog5GfHSN4uUQZAYYTFzbhM8Dqtvk725IrqIcCaGuW+
X-Received: by 2002:ac2:44d4:0:b0:5aa:8822:b874 with SMTP id
 2adb3069b0e04-5ad5771ec41mr4233175e87.46.1782241957214; Tue, 23 Jun 2026
 12:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622234803.6982-1-ebiggers@kernel.org>
In-Reply-To: <20260622234803.6982-1-ebiggers@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 23 Jun 2026 12:12:24 -0700
X-Gm-Features: AVVi8CdurCE0Z4nmJzTanxEgxUT-VwvR4nCHq2kkCJY0BXv2CrDitgelAGd8YoA
Message-ID: <CALCETrXPj0u=FZ=aFcZAHk3fFZa7rCuPEjx6cOMXmT3sdkC7SA@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 4:49=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> AF_ALG is a frequent source of vulnerabilities and a maintenance
> nightmare.  It exposes far more functionality to userspace than ever
> should have been exposed, especially to unprivileged processes.  Recent
> exploits have targeted kernel internal implementation details like
> "authencesn" that have zero use case for userspace access.
>
> Fortunately, AF_ALG is rarely used in practice, as userspace crypto
> libraries exist.  And when it is used, only some functionality is known
> to be used, and many users are known to hold capabilities already.
> iwd for example requires CAP_NET_ADMIN and has a known algorithm list
> (https://lore.kernel.org/linux-crypto/bcbbef00-5881-421b-8892-7be6c04b832=
d@gmail.com/).
>
> Thus, let's restrict the set of allowed algorithms by default, depending
> on the capabilities held.
>
> Add a sysctl /proc/sys/crypto/af_alg_restrict with meaning:
>
>     0: unrestricted
>     1: limited functionality
>     2: completely disabled
>
> Set the default value to 1, which enables an algorithm allowlist for
> unprivileged processes and a slightly longer allowlist for privileged
> processes.

In our brave new world of containers, this is a bit awkward.  The
admin is sort of asking two separate questions:

1. Is the actual running distro and its privileged components capable
of working without AF_ALG or with only the parts marked as being
unprivileged?

2. Is the system running contains that need the unprivileged parts?
(Which is maybe just sha1 for ip?  I really don't know.)

Should there maybe be two separate options so that all options are
available?  Or maybe something between 2 and 3 that means "limited
functionality and privileged modes are completely disabled"?
