Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753BB126C18;
	Mon, 27 Jan 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990571; cv=none; b=IveWhIl+RLr5FF/httAsSTF99iPseV7zn/NpzhOFkuJpT5oGz/WoJ1HEjsInecR43XSNjqj12ZRaUn77+sm+lSDHflReKXpEn/C18J8W/JZPVISvJVT6elPPxZqbP7mP73zVRJCYUOyRsjv25zk4gVQKB9+Ph/bplBcgwCBkspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990571; c=relaxed/simple;
	bh=EwcaXFgV0xCS4nriJgeU5GOhkTW/UCHC43bQna+e1WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kwcsj/DxkeUQmiVeoJpdOBXHai0DSfURjgJSa/SA0+c5ZWKmhq61x7GTYl19ZwzLDsu0OD3+RoEaI0eZs4Sja3850XyCkzwmyIpmjNld3KMsjHfufKckQwofxK849/dcY4tzemvKkYOom5v5kpqJJoD1TjaQ0R86hP0TyU04a58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVqCc4nh; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVqCc4nh"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso6965256a91.1;
        Mon, 27 Jan 2025 07:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990570; x=1738595370; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u6EzzWcIGnS4+MejkE3jWALM1FF33F7pQoXeXph8FU=;
        b=MVqCc4nhw9zkSKEnYyH0uapWmhCTAONAJ0/Al+O4dGQIUOSw2KxfgbtvvmtZ6Seipn
         lP59Q5Fy+1JeLE6zZs9Rj5p+Blqz4tAiCxtodh3854dOM1O4mcXYiICgapXEkHBg2YoM
         lB/WMhq1YZkhxPUCe6+ajfx+nLr2QUnxs+FNcwPuMeR+95/bBAM4dWlSkwT9Z3zOdbcm
         u7DR6US+lbYdlX3ek3s1cFOVqw6myifNggjFdvSvzn1SNBT9smrhr6vQOPFSAp/mF3OQ
         9/iUQVHzT8Kq3aN0z5M1fIjY8WXHIpDkVAhNrDu70KC+koROShjdTdnMhreN3X1vFgMg
         4qVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990570; x=1738595370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+u6EzzWcIGnS4+MejkE3jWALM1FF33F7pQoXeXph8FU=;
        b=nTgs+T6qTAlzykZhOdxxe4WgrMwiNHonI4g2SvGF8T4t4ZOfq0cTOW8faIZocsxdxy
         o1IjJ9giiXkCHycbBp0lyKjtmXtSCW6nZLun39OJmrq3cSumleZejnDR5mVLhyzpBXQf
         Jlrue2UXYz9uqc3oIplyWRI9R1mH+hVUI1fxnnP150rpBmIgJqQMn080F+/AOBDTRzLL
         m0CshngxYR+p08COq6i0Bm/Uq5I8q/M9QdhwGBzfHZ1P6Kct30fwWTT0kC+nyqcQsS28
         H0XQTcneH3mmsgJBuYRURJQL91nVy7ndtHQBTbogScPe6HdCMvw9/J0c08ZVYXQ85aAy
         1uAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2m93+ux7oqe1Zb4a8RjmNgz+aVbtmIfKvKQLS3DO3siTNW4myS5uEvogDCATdyGxtgHie@lists.linux.dev, AJvYcCVJRk1DiONZsp1E1c3pcYseRddiX8+pcZD4EKStc9WcYyZSn20fy0HM1zTTCXdIBEmD4ZwlX8PjVK0=@lists.linux.dev, AJvYcCXZEltZAQyx0TaxAXFOmcWP8qxxQxG77RZ1LSJAapq+I1oiF6nkCCcedg9a9yukgkHsCoEkR1auEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpIx3Ae8QoF9h3FKqQAcuQy9habWdPnNih2/k1RWmhJlkVDG3G
	otDITl/YVoLIpZt8Nohr9OV5J5FJpA8PSbLD72dokr4jlto9lK/NfXgbNeWuCZR2sZlBYBWqAA6
	3pUCBnPDx+m6WYKO4j8Y4vbnIerc=
X-Gm-Gg: ASbGncs2PDC66k89bj9gZak9AT4S4AbDVf6Vx1Ck9zWtN/1jxjBUOdVJygv6GuEJxSt
	+YxXlmJwk6NHwi5r6X8A9k64JmqueL+3cJpizFAHp7Hsw5+OnlxGJqNfjTB0HiYLV
X-Google-Smtp-Source: AGHT+IGVgD8wsBNO9HaP0Y2FD3bARVApgGsYc5Hfaqtt+CPaXyCl+Z6Hd0vZn50lxsxGf7Gn51yhNhbjGGxK+QmLndY=
X-Received: by 2002:a17:90b:2dc1:b0:2ef:e063:b3f8 with SMTP id
 98e67ed59e1d1-2f7ff2ba81bmr20793345a91.7.1737990569495; Mon, 27 Jan 2025
 07:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
 <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
 <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com> <CAG17S_MfQ+FjWQJoiNs30rt4u1O9Z_FXFB7BiS6RAQsG9ReNkA@mail.gmail.com>
 <CAG17S_OigLj3j=tS2BKYpoKOWKVs=XOBS-YFn26SzF9r+ZpLzA@mail.gmail.com>
 <CAG17S_Pj6UaA-yaGDUCwr8+M+L760PU0NvB1sAzGGNCp4xKatg@mail.gmail.com> <8c36a8c0-0246-4009-b79b-890e1f0a7aaa@gmail.com>
In-Reply-To: <8c36a8c0-0246-4009-b79b-890e1f0a7aaa@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 27 Jan 2025 09:09:18 -0600
X-Gm-Features: AWEUYZmW3L6Yj0HRbpi8kaLlsRPs_B9BYnc6HUz_q5W0EyA3nWjtVXw77rADv4I
Message-ID: <CAG17S_NNtyU0eXzsWgrjJEjcqDHPLrbSkvnEboSg-fZebdV3dg@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, Arend Van Spriel <arend.vanspriel@broadcom.com>, 
	connman@lists.linux.dev, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just tried this and it connected 2x once from a saved key and a
second time from a new key.
Will continue testing and let you know, but this may be it!
Thanks so much for all the support.

On Mon, Jan 27, 2025 at 8:29=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Keith,
>
> On 1/25/25 8:37 AM, KeithG wrote:
>
> <snip>
> >> With wpa_supplincant, before the AP sends the 'PAE:', we get this
> >> which is not in any of the iwmon logs with iwd:
> >> < Request: Set PMKSA (0x34) len 92 [ack]                              =
14.561627
> >>      Interface Index: 3 (0x00000003)
> >>      PMKID: len 16
> >>          05 cb 9d 0d 9a c6 7c 42 77 b5 d2 23 f0 62 f7 4d  ......|Bw..#=
.b.M
> >>      MAC Address D8:3A:DD:60:A3:0C
> >>      Unknown: 287 len 4
> >>          c0 a8 00 00                                      ....
> >>      Unknown: 288 len 1
> >>          46                                               F
> >>      PMK: 254 len 32
> >>          35 28 07 cb 94 de 82 e7 0a 5c 73 d3 e4 1f 88 ae  5(.......\s.=
....
> >>          74 84 82 66 86 8d b5 aa 79 cb 75 d9 75 8d da 3a  t..f....y.u.=
u..:
> >>> Response: Set PMKSA (0x34) len 4 [0x100]                            1=
4.562171
> >>      Status: Success (0)
> >>
> >> Is there any more info or help I can provide?
>
> Looks like the only difference between IWD working and not working is
> when it includes the PMKID. This is due to the new PMKSA feature which
> looks like it requires some extra work on brcmfmac (using SET_PMKSA).
> Try disabling PMKSA in main.conf with:
>
> [General].DisablePMKSA=3Dtrue
>
> This should hopefully get IWD reliably connecting.
>
> Thanks,
>
> James
>
