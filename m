Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA92222CF
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594902; cv=none; b=IabYUcQXAjkaqBTwy6dnWzjCp5hZQTRTtNMZut0Z+K6ot/UEF2ogZ86MSogT4cCAy80lZH7v1aIitZ/RJ0x216p9WQg/UHD7xUxlDFZwZ5cPqr12fnOYttsapa3jIGddPqwasGEpETC6BOwBeHSP9yqiPaHtWDZNFFky0TxMkaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594902; c=relaxed/simple;
	bh=Qbl/VX1UTk31SYakY3Fui+OTKv9IUSvjcyyeq0UhAdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hat//MZ7nvC6JCPfT0YPtX9ulbTfzF4KgUi3yRf+U79bptvN7MJ731EYTz9fOUjIfzc4JAHJYx85CGb7Wgfy6NRvcaepx13yDTT+3Q9b96qoRRAhXmT0r1mUcFSEA5+hy6WwREX8WQq8+8mXrIk4Gbkpawymf9rHoxYm/4OU7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f679788fd1so1140297b3.2
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 10:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594899; x=1741199699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSTrgUZoP91soMblFUriLwuqf8j/+2I431RUiDo/6tI=;
        b=vpok3uYE/fUpYEr0TueWwbYJOf5NHtLHIjWm1Q+Iq+ZcoWQ1Ub61opUGZ6Fii8qZDK
         704KiPkv3N2sSt5RSunr/gcyxXcYD2nmmQobCtaA9OGNX1pKUQ19So9t8TNzszhbkSKG
         x3kVo/GWrZa1rBzOYENTB8lo9SDQsmgQ8v5EzvYsOYZOgKF7Hy2w7cpQHHvBc84lul0e
         1qn17C64aTWX+iaB48WMaDaWXf9FIHjflvQQWs3BOmevGflAAKratyfM4HleLemrzzJQ
         gfyPumCSGHyVf+wwlWdHiHUUCEKnnS7jXdrqYD6nCt/Y7DnzCUZ46fWtKpBUuK924kwe
         i8LQ==
X-Gm-Message-State: AOJu0YzjdxAT410DM+1jpLaoQomtOb7epTinbKgCjr4AKtMJT64MXwyf
	xq3A2uOTCPoU1PHGCJWHFcbWDN++Bal6rht5rNvjlof0grM8XXqK6pvP2w==
X-Gm-Gg: ASbGncsKmp3fHdBO9DsZ8kXBWMo5ie3I0O1AYVuD5mG44LH2/Bj0BfSpZB+qf6GNq2I
	9AEXNCdLCwCyLtXIdhZ+Nh9evAtigQCoS7eOQAbsQqOZH00Fe6ZKTaE+Un1yLg8bpopY/62EBQG
	irC3D0N3An2GULjqSXuuto2mQDtvSlJSAto+tl3z4fBpmGH86YnLVkpXqm+T5AgFzBeb2vP7SEe
	mE/UqWsmh2Kigl8m2UnnIASJvhKtikQ85kqKQ6ckq0JIB+jtAxUmwYAaVGwDcdChKqbU5dp45lL
	uIpZBcwQwZ+GCXT1nU0nz9fJ5ImIlB1cY2kud308E7u65B1BDWhS7VgKboCf0y+hUWNNww==
X-Google-Smtp-Source: AGHT+IFXaA39eijPc8H+IM9HluMq2nnhKy+WS2HYWXfYYc5D63TOZt4095Am7GACmZMmkhd9g7NTpA==
X-Received: by 2002:a05:690c:6a06:b0:6f6:7b02:2568 with SMTP id 00721157ae682-6fbcc38c9c1mr205564777b3.32.1740594899108;
        Wed, 26 Feb 2025 10:34:59 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd1185d60asm11211747b3.100.2025.02.26.10.34.58
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 10:34:58 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e608e260563so88769276.0
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 10:34:58 -0800 (PST)
X-Received: by 2002:a05:6902:26c9:b0:e5d:aeb7:6e62 with SMTP id
 3f1490d57ef6-e5e245ad516mr14131125276.7.1740594898702; Wed, 26 Feb 2025
 10:34:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADXxVSKD-YKOxt+=b919QWFHnU7QcSWnEwfb8xU-JGn=xVrbbg@mail.gmail.com>
 <4ec69c46-bbc1-4a05-9d7a-18c1d4d249d1@gmail.com> <CADXxVS+xAeGUiwGTe7L0Rr+OtxqRdvZ2AwwhfgpegB8h-dA9TQ@mail.gmail.com>
In-Reply-To: <CADXxVS+xAeGUiwGTe7L0Rr+OtxqRdvZ2AwwhfgpegB8h-dA9TQ@mail.gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Wed, 26 Feb 2025 11:34:47 -0700
X-Gmail-Original-Message-ID: <CADXxVS+iBcBeyj7geJ0jMCrT3wP+YBqXcGJ98oa5KEPUGa7ncg@mail.gmail.com>
X-Gm-Features: AQ5f1Jqc_3gvAUO24Y2NCMLPWM-wr4rfecQKV6YLZ9e1lStfONC3_gqJZmIuxOQ
Message-ID: <CADXxVS+iBcBeyj7geJ0jMCrT3wP+YBqXcGJ98oa5KEPUGa7ncg@mail.gmail.com>
Subject: Re: Does a AP get blacklisted if it fails auth too many times?
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 11:12=E2=80=AFAM Bryce Johnson <bryce@redpinelabs.c=
om> wrote:
>
> On Wed, Feb 26, 2025 at 11:00=E2=80=AFAM James Prestwood <prestwoj@gmail.=
com> wrote:
> >
<snip>
> >
> > [1]
> > https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/statio=
n.c#n286
>
> Thanks James!  I'll check that out.  For also headless device use
> case, we are never moving and only provisioned to one AP.  So we'd
> like to try as hard as possible to stay connected to the AP.
>
>

Looking into the logs a little more I did see the same message:
2025-02-26 00:13:56.071769752
src/station.c:station_autoconnect_next() autoconnect: No suitable
BSSes found

Although it did reconnect automatically after that.  So it seems like
it got around that blacklist eventually once in the log.  The more
serious issue was at 2025-02-26 02:47 where it seems like it
disconnected and never tried again.


I did see after this event:
 2025-02-26 02:47:54.473847839  event: state, old: autoconnect_quick,
new: disconnected

I never saw any autoconnect messages (either trying to connect or
autoconnect: No suitable BSSes found) for the next 2 hours until we
restarted
Here that ssid on was a Processing BSS from a full scan 2 hr later
2025-02-26 04:47:04.262785719  src/station.c:station_print_scan_bss()
Processing BSS '9a:47:32:d9:93:fa' with SSID: revelotest1, freq: 2457,
rank: 591, strength: -3600, data_rate: 72.2, load: 29/255, clients: 12

I can share the full log if that would be useful?

Bryce
