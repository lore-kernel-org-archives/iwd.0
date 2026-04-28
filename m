Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781EC3B19DA
	for <iwd@lists.linux.dev>; Tue, 28 Apr 2026 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376798; cv=pass; b=gCxrArsuX5xN7dT7xloyqKuf/5/QML57rS5AgNuEHBTMqeT7flPLwplo83L16uKT1F1eesJLv0Qh8e3SR7YDYKZZHewpa8Ldz2NHRxex0OFcHIoR1hTk3Jmo20qQDWoPJj2Hocp2+MKVRnrOLOF1SbO4RN77mQG1LH0sHXSXbKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376798; c=relaxed/simple;
	bh=E4mW059ALnj/0B2XGJ7uhsMQWgxZUX/djvra3j9BGDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ISjO4LI0IDcQF4UhoboQM77VrUm7nLl9UC4DK8/MDiw9BRFpyPUbWHsdwuPWqdnOraZ+tFifQ8mytZB1hfaj0otw2X7TRwrhwGOFkK9uuU49Swc2aVvVhA5NTcPFX7itNmkwgkXcigIyqXDbadKsW9bmmV0PkdkRBUFEO+4XWM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=mtoCaSAo; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="mtoCaSAo"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7b186dfc1d0so159543497b3.1
        for <iwd@lists.linux.dev>; Tue, 28 Apr 2026 04:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777376795; cv=none;
        d=google.com; s=arc-20240605;
        b=NWwRCHjhvwX/McvgF5cskNysNCKddV9FayZTgc/7vWc2Gunx44GDmxXj3xHgvu2+0l
         hwKQesoNFdW1v3gMDael/X5si468PAUOMimTucgouxc44yIeUtpG0ZKjlorgyou9f+qb
         NylIYX84LJoLkVKZjTBOsZKPgMIPSVRdInvqPtj6prZaNhZiKJPNaGL7vfVpzshiLGux
         VH1r6QkIxKtIVgZ3+tR1+kUKiUlCQcaRobXJfc/ZHcyyPrjzf1Cnp6qok9Ks9I4dStKw
         a9YumIPQaKYO8D9z1JWOPK7GhY2MmKdEysstBD05Ksmp7/VLrxGiOjX+7AFLJA/7dAzj
         ndIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=E4mW059ALnj/0B2XGJ7uhsMQWgxZUX/djvra3j9BGDI=;
        fh=LVwSdJJT2poHpWJpvI73c3fFqaJVA08Td3ZAiex6+kI=;
        b=Ysi+WJ0Q4RUZ8S9SbWHsSX6NTQn3xgRwJcm2ZOOYS+Og6ZOUanfovTdx6I0oxiK1B+
         /8+40idz3V+Tv5I8g25OeGcg4HpTKJRpWoZW9TJO/4n8p4v5OXNsb6VZiULfQ/1I3C6P
         04teAKjrRLYltk2iBSHxY8GAo1AlAsArhUJJ9cBkd9evFZ2ZRGA/ydDsiFTAC0peX+/H
         t2K8C4ol1fgBwCSCgfQWQevx19QDGZ5GjjZi8WpPWtkUOgIHS66cGjr+5uq6NhqVg3GX
         MNoJ5s0Lv5koTCxoKgrkVy8tZM555LYfGFarBHZBHu6AmsxmZcBt9GIBnyCDkvV+8Uba
         fxEA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1777376795; x=1777981595; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E4mW059ALnj/0B2XGJ7uhsMQWgxZUX/djvra3j9BGDI=;
        b=mtoCaSAohDJSw4lijtuLz1xr9F7EWeAPdn7aj0vBC7tZ9sxLk85GuaNYQEw3LJpsxF
         SB0w2Dp3R1acxTIQpywLlNzyzt3ZjcwxDchxrrSLRAy5aVEyaIjye99YLKphx3Zd1B5K
         A8RUeKgRFa5LuwRC5hVv5XzsJbbERyG1WcmhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376795; x=1777981595;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4mW059ALnj/0B2XGJ7uhsMQWgxZUX/djvra3j9BGDI=;
        b=nFxvZjJz5oLPTw0XkDCLIq0Qy0ntNwJRnlFid47voeOuupWnxqofaxRTcaBtXstWR8
         8u9d2bXMoMHaVeeTpRqKpqeCi1dsQRZwPKREk1rnrgrLqVIKDhoWPY1jtEWcksZqEBmn
         RvJ1v2LXOdxqBNk0W/yOElx2tUNv22g7RfaJGf8wGm4cOAqFCaaD8pMiRTxxYsfyOb8U
         HVpVueA70ZJj1oKyJy+1G5GGIWCabkFAcNShcS2C6Rk/yThxTKNmD5HN7tMzUw7FzXTM
         fTABZibUKilL+2NaKsuicA894ma4badqMs9DXwAqSpOyRJJEVPKizUUwPTbh+AbMacBY
         r/1Q==
X-Gm-Message-State: AOJu0YwP9RJkHVfTpSQRDnPBxy9nHH9WAcCCluFmv2wiAQqXUr3TldLy
	yaA10oKUt22Lx4jRgWwb3I+8JOThMa+Zwz8WhDGzzj6gTu2vRERpLTgmdL7Um4b9//2F9KiuQ4J
	4BgWmW8Umlw3pCQeRDQmZgFEMP6J/A/jFUygizakkKvq05gMO/75IPkI=
X-Gm-Gg: AeBDiesqcsfQkznEk79srX4FEcllqfFlVeJioSi6zm355xRjNxVXJ6rgXIra5qOxH/5
	+78L+XFii0hjtkxmEgswqjx0ivAKto4Lw3lsqBIrv/4s3XEDg7Di7ZtdSLW5xVT7lxQPXk63yWO
	F9DkPyg73tb9STxwyWlWcAAOAbfZQHY6WsB9nJ2qaWjb9i1Dphi0ZKLA6kdBydS/dbdiOq+dgw9
	2qUi6XLZnA92QgxFtTEBEJrvJZsBJgcs6TGpeATOaVIGXQpbZTF2uzz0er5KSi/TW7k7+NqSoXk
	Th9w5o8CNW3OdcmS5rXfgPes0UvcFyLDSM7HR7sIVuhXGSq15iRySFLTWoVnqGtd9+fHgCnK7b5
	t2g1OwxueDvW1VCkU/bWrXXtcUiMcOuXRfotKSp6MkQwaI+KnsjYDUtvvKpQ0hfpQffROAw==
X-Received: by 2002:a05:690c:c4e8:b0:7b4:1394:4104 with SMTP id
 00721157ae682-7bcf2ffd31emr21691167b3.9.1777376795441; Tue, 28 Apr 2026
 04:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260424083209.383093-1-m.kurz@irregular.at> <1b202119-a27b-46b5-8f4c-d8b3fc536b7d@gmail.com>
In-Reply-To: <1b202119-a27b-46b5-8f4c-d8b3fc536b7d@gmail.com>
From: Matthias Kurz <m.kurz@irregular.at>
Date: Tue, 28 Apr 2026 13:46:24 +0200
X-Gm-Features: AVHnY4JzzpyL67VsBcwaPI5BX37En8QNp2dx35cgF5pxBapPYxoaIiE571iXrgo
Message-ID: <CAO=2mx5fmUjU4zeiV-O5HH-=fEG0P=5CRSseKGYMjcmRWUjm6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] agent: add passphrase storage options
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi James,

thanks for taking a look.

> Do you anticipate additional options needing to be passed?

Not immediately.

> I'm not really liking the idea of adding another agent API. Another option
> instead of a new DBus API could be that we have a main.conf option,
> something like:
>
> [General].DisableStorage=true
>
> If NM is always providing the passphrase via the agent API I don't see
> why we'd need to keep an option within the network profiles right?

I understand the concern about adding another Agent D-Bus method only to
carry one storage option. I also agree that if the agent is always able to
provide the passphrase, then iwd should not necessarily have to persist that
passphrase itself.

I am less convinced that a global DisableStorage=true option is the right
model though.

That would apply to the whole iwd daemon, while the ownership question is
really per profile. A system can have profiles that are managed directly by
iwd and should keep the normal iwd behavior, and other profiles that are
mirrored by an external manager such as NetworkManager. For the mirrored
profiles, the external manager is the source of truth for the file contents
and for the secret storage policy. For native iwd profiles, iwd should still
be free to update them as it does today.

A global option would also make deployment awkward, because enabling it for
NetworkManager would affect existing hand-written or iwd-managed profiles on
the same machine. Conversely, leaving it disabled means externally managed
profiles can still be rewritten by iwd.

I came up with a different approach that avoids adding a new Agent API:
a per-profile [Settings].ExternallyManaged=true flag.

With that flag, iwd still reads the profile and can use it for connection
setup, but it does not update the file as a side effect of normal network
operation. This makes sense independently of NetworkManager: if someone
handcrafts an iwd profile and marks it externally managed, iwd should treat
the file as externally owned (and treat it as read-only). If NetworkManager
mirrors a profile into /var/lib/iwd, it can add the same flag and keep owning
the contents.

I will send a small patch series for this shortly.

Thanks,
Matthias
