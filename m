Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB23CCF2
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ04UtJG"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a8ee23f043so51700437b3.3
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698186424; x=1698791224; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib7tFC9yKUMJX4F4TDTzgrtRp2do2w/UbsnjZsw7BUU=;
        b=TZ04UtJGgOxJYB8ql0MxdaY9djtPrqoKc/XqGCOXOvpBbbiOqwn291Vjxsk3caadxg
         fdL1Soj0rzypj8dGyvcFKVNRCNLAIUymX9x4+IAR25XWm9MF5fmNkZ80kJlBJOpbHXqn
         ZUfhNlWgG7hPY0kBzR8cLKsNKsHhsZ4g2JZ9Cm4P7KrNiCvDw8cqJbnb7Q509WMaGCTA
         1PUoyqXNum0ElsGZ/X2TNN8dirf/CLnEmAJhJtrCmFUBWhW0LEYQYNLyWkCY2tYpfRdy
         q3b+btN3xFbic/wP/xCkfBwLcX4B6FNdkp0V42lVfNx/iN6Tx1jLypM96/NCcT6bFF6P
         W7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186424; x=1698791224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ib7tFC9yKUMJX4F4TDTzgrtRp2do2w/UbsnjZsw7BUU=;
        b=Z0kRCRXgkP9U6bq9HYLLV8WFtbnomI2cpBIDP4jcaa+cl994OO8dmu1GT2hms1Hmkj
         Q0HAVKTLnaKcESKfXXG0ys1D7dZvkNbDasntrAnuxDA0mTGxNcERtqOaS4TMGiQUUmxM
         XEWad5heuPuDECmt2ODDWV6mcLwj5U00vJ/IoGWBPtOXfpXZ8vIDDc7AVtLyQ3n1x00n
         3jNcXA+/WG8t1sAjTh61oa4uFZ2ZEcktG+W8wnKDia3zuyHLEK/62nLY2mDFXf8GDrbf
         LLTsqLQc/3glagPJYW/kFW84sGHIRh6sBL09amYSHQBwfX3rjPgrHzgjiOwl5dE/Hse0
         4WGw==
X-Gm-Message-State: AOJu0YwII2IlA7Q4VG4tW0vGb3n487qf+JbRJKN2ZY5zV/h9AaN4vKHd
	2pUcoBBUIgWwJ7XnMD5my3ppctMuwzt1cclhxpk=
X-Google-Smtp-Source: AGHT+IFHS8sI8s14y/SVFoxFs3YcYT39J/zquaM3ePVPY07JVt7dwXh69FAn4SawmFwfKosJJUwgEu/jpPmqRT4BP+o=
X-Received: by 2002:a0d:e291:0:b0:5a7:fbd5:8c1 with SMTP id
 l139-20020a0de291000000b005a7fbd508c1mr13964726ywe.17.1698186424632; Tue, 24
 Oct 2023 15:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231014235445.167620-1-dimitri.ledkov@canonical.com>
 <075d94c6-4ce3-4945-b765-71ad6285dd67@gmail.com> <CADWks+bdeDgAZKUs6wbdi3KjDHeONO7LkmjX_-9wT15m91PvPQ@mail.gmail.com>
 <c29ea330-c84a-41a7-b5e0-ef44993736e2@gmail.com> <CADWks+au-HzFjSopfHYnpz3kUW1uOR7aEFTe_m0qHfVvJPcfFA@mail.gmail.com>
In-Reply-To: <CADWks+au-HzFjSopfHYnpz3kUW1uOR7aEFTe_m0qHfVvJPcfFA@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 24 Oct 2023 23:26:53 +0100
Message-ID: <CACvgo51cspY9BgZoKmPDKuOqJXmMZxfh1K2Wsvr4Kxs_ua2-Mw@mail.gmail.com>
Subject: Re: [PATCH] eap-mschapv2: allow using on kernels without CRYPTO_MD4,
 and deprecate
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello Dmitry, all,

On Sat, 21 Oct 2023 at 01:34, Dimitri John Ledkov
<dimitri.ledkov@canonical.com> wrote:>
> On Thu, 19 Oct 2023 at 03:54, Denis Kenzior <denkenz@gmail.com> wrote:

> > Wasn't Ubuntu going to switch to iwd at some point?
>

Was interested in the same question, only to see the somewhat familiar
struggles. Namely, we've battled similar dragons with the SteamDeck so
I thought I'd share the tricks we used.

>... most notably seemingly failing to configure and use
> eap-mschapv2 via NetworkManager GUI,

My debugging over one years ago, indicated that NM was correctly
creating the iwd profile for enterprisy networks, then attempting a
connection _only_ if iwd would advertise it as KnownNetwork.

Which in itself is inherently racy with NM running multiple threads
and communicating with iwd via d-bus. For use I removed that code, so
that NM would issue a connect and if iwd fails with
AlreadyProvisioned, it would then retry to connect with
the-flag-I-do-no-remember-the-name-of flipped.

There was an upstream NM merge request for that, although the
maintainer added additional checking, which only increased the
(re)connection delay without improving the success rate in our tests.

> ... or keep existing configuration
> working after the switch.

The problematic cases we've observed had extra tokens from the
wpa-supplicant based connection profiles. So you can try removing the
following:
mac-address interface-name permissions bssid

In addition, we pruned all files in /var/lib/NetworkManager/

HTH
Emil
