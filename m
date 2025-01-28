Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283C7485
	for <iwd@lists.linux.dev>; Tue, 28 Jan 2025 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738039635; cv=none; b=Pbpmc8O0qFE4FS3kx+rf5C3b1iFCwunM7wxVGtvxgpS3Q70lVTL4Hly+YuKxTDhYothxb19+BIWg0YdBI5EIFbeYK0uE3mBzZxtavOMrKOsLn+NY6YYywsnDFXpB9mxttgfBpwSx2egym+tYSTJcn8qbmfxoRouN/JxUsdn1jlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738039635; c=relaxed/simple;
	bh=ezsFvt86JyQt9l4PjAAGoLgAVkc6gkJyYg24KYXbae8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVC/0x3Arzb88ePjkf8qAMe3efv13Ad2G6Jz2LUetUO83Tj0FCxjV+mO2HDcRnxS9mfEq7E3iFlkBHV7ZcvTlxOEJ4jIVU72TPBvLn7G1X/tQ+iywCFkOpsCsyipvBEgZ9Mz6DiSKnUuK4iC8FUzitI7NxNm2Dvs8J2Rakt78aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrF6o8in; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrF6o8in"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21675fd60feso115812375ad.2
        for <iwd@lists.linux.dev>; Mon, 27 Jan 2025 20:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738039633; x=1738644433; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS+niDj6V9CjxA/cBprKJ89jUJ78xMsFgZ9jYRpywyM=;
        b=QrF6o8inzQx0zPRgDNjS9yNHz1gcfC9G0NqI5+PGnOFpt+jYaO+uuzXsqHLC+hqogf
         B5HBot666j2hMrZY87R5F2t4dr77vkZ456fGEwqf/yAQerSoXokwBaTP80CBqcbAiqMe
         hF2YnwbW4rF8NYNAbgP19AGCt+Rt3qWtXNost/EaUIsKgugJ3sV375gelSt7GgJjl6Bo
         nOeL5Ahw1LEjuWbsQwJAjoEqWGDCEzf69agsDXciGmC+Z/zJ9S/s3FFxGSdPextHhGXL
         gvvwdHshZF4rqm3QN5d7E3IBsZLcKjUTP17FNvapdHT91pWTzR19SeWHw36QWdQJo2/W
         Zx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738039633; x=1738644433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS+niDj6V9CjxA/cBprKJ89jUJ78xMsFgZ9jYRpywyM=;
        b=fMKPqb2+ZTLzMndgNyi5WM2qNBHYqogW3g4jAlh32zkBDSHQW3BWLXFKk9kmCKqask
         pOniNfhLEUJiT4GMh8VEfiW/HEVWcIYdzSQuRBb2eBONvkAgQCN0D6olTisNeFU/JtCD
         +mYgopulbVNP/AbILbLlSunlfKvHkIcxHJK6qYGpuAjDpctY0uwvAPQOQDuoTvT64UGo
         pqXk3YTcHwD0izwE1INHGVHWiqjQmHuDHcBpOYtTXr96rHkNN2GvhU+3KkXj2g9T7rMY
         rbRG+u/X99ijymmlScD7GoCAzyr8kqJNKnIySHkqmhEEP0mesYdfKXs/fNs7r/4+p9xt
         TdDg==
X-Forwarded-Encrypted: i=1; AJvYcCWuIMv9L2h0EamXNYvzV0eTEBV1onDL+c420dr2CS0PAG3HrUKo54Rf52A4t6+IHLC94Ws=@lists.linux.dev
X-Gm-Message-State: AOJu0YyZcD3oUZqoUzEvJoqiIC8RbDH7zGttGfdhUmqO0XLL4v6DgBaF
	WwrMt9A1QCOJjtvPU1g6TcpR3Dqkjo3tOolTJMxlgQ6HagJH+/WEmKHvS0ao29VYL7o4LeLyHyx
	iWsbiJi6hUR01ur/+zU59E+XTiP8=
X-Gm-Gg: ASbGncsqPJ3LnzsryW651YElGQHDlT3Io8N7rfYV26JQ44rDkrlghghtturIOzCzfJs
	9Ka1p0xo42SqhCwtbhpvOdkype7BImwaK3oteT/4kO35HNjN0F9r19eGbJwPcExCrKBY69vjTXI
	2wi+QsAUA=
X-Google-Smtp-Source: AGHT+IEmQCLtHAINpiTo17fUOOptNIE2dyX1BeBnz7COv7RP2Da9Ts6q2Hy445esQHWbsUZKwC5b/CoXKxcJzE1iP34=
X-Received: by 2002:a05:6a20:8429:b0:1e1:e2d9:7f0a with SMTP id
 adf61e73a8af0-1eb2156f917mr83336910637.34.1738039633119; Mon, 27 Jan 2025
 20:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
 <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com> <CAG17S_MfQ+FjWQJoiNs30rt4u1O9Z_FXFB7BiS6RAQsG9ReNkA@mail.gmail.com>
 <CAG17S_OigLj3j=tS2BKYpoKOWKVs=XOBS-YFn26SzF9r+ZpLzA@mail.gmail.com>
 <CAG17S_Pj6UaA-yaGDUCwr8+M+L760PU0NvB1sAzGGNCp4xKatg@mail.gmail.com>
 <8c36a8c0-0246-4009-b79b-890e1f0a7aaa@gmail.com> <CAG17S_NNtyU0eXzsWgrjJEjcqDHPLrbSkvnEboSg-fZebdV3dg@mail.gmail.com>
 <76b2f0b5-641d-43e6-9c6d-4073fbc61dd8@gmail.com>
In-Reply-To: <76b2f0b5-641d-43e6-9c6d-4073fbc61dd8@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 27 Jan 2025 22:47:01 -0600
X-Gm-Features: AWEUYZly5KPu83tPeQ4KY0pK9TvqDJjTRG9y8IaS6Ap-42NsYzqrv8LjPawF9_g
Message-ID: <CAG17S_MxYjoYBGmNDPPuVUTBfRmksfiJ4X==SAPF+6Hz3j8eKg@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

James,

I patched the latest iwd-git. First time after reboot, it will
connect. If I remove the config in connman:
connmanctl
config wifi_blah_blah --remove
then try again:
connect wifi_blah_blah
it will not connect and I get the error:

Jan 27 22:24:01 Pi4 kernel: ieee80211 phy0:
brcmf_cfg80211_external_auth: External authentication failed: status=3D1

It will not get a DHCP address.

When I add the directive in the main.conf, even with this patch, it
seems to connect every time.
DisablePMKSA=3Dtrue

Keith

On Mon, Jan 27, 2025 at 10:21=E2=80=AFAM James Prestwood <prestwoj@gmail.co=
m> wrote:
>
> Hi Keith,
>
> On 1/27/25 7:09 AM, KeithG wrote:
> > I just tried this and it connected 2x once from a saved key and a
> > second time from a new key.
> > Will continue testing and let you know, but this may be it!
> > Thanks so much for all the support.
>
> Would you mind testing the latest RFC patch I put on the mailing list?
> Please remove the DisablePMKSA option in main.conf with that patch. I'd
> like to see if PMKSA will actually function with brcmfmac without
> external auth, or if we're stuck disabling it entirely.
>
> Thanks,
>
> James
>
> >
> > On Mon, Jan 27, 2025 at 8:29=E2=80=AFAM James Prestwood <prestwoj@gmail=
.com> wrote:
> >> Hi Keith,
> >>
> >> On 1/25/25 8:37 AM, KeithG wrote:
> >>
> >> <snip>
> >>>> With wpa_supplincant, before the AP sends the 'PAE:', we get this
> >>>> which is not in any of the iwmon logs with iwd:
> >>>> < Request: Set PMKSA (0x34) len 92 [ack]                            =
  14.561627
> >>>>       Interface Index: 3 (0x00000003)
> >>>>       PMKID: len 16
> >>>>           05 cb 9d 0d 9a c6 7c 42 77 b5 d2 23 f0 62 f7 4d  ......|Bw=
..#.b.M
> >>>>       MAC Address D8:3A:DD:60:A3:0C
> >>>>       Unknown: 287 len 4
> >>>>           c0 a8 00 00                                      ....
> >>>>       Unknown: 288 len 1
> >>>>           46                                               F
> >>>>       PMK: 254 len 32
> >>>>           35 28 07 cb 94 de 82 e7 0a 5c 73 d3 e4 1f 88 ae  5(.......=
\s.....
> >>>>           74 84 82 66 86 8d b5 aa 79 cb 75 d9 75 8d da 3a  t..f....y=
.u.u..:
> >>>>> Response: Set PMKSA (0x34) len 4 [0x100]                           =
 14.562171
> >>>>       Status: Success (0)
> >>>>
> >>>> Is there any more info or help I can provide?
> >> Looks like the only difference between IWD working and not working is
> >> when it includes the PMKID. This is due to the new PMKSA feature which
> >> looks like it requires some extra work on brcmfmac (using SET_PMKSA).
> >> Try disabling PMKSA in main.conf with:
> >>
> >> [General].DisablePMKSA=3Dtrue
> >>
> >> This should hopefully get IWD reliably connecting.
> >>
> >> Thanks,
> >>
> >> James
> >>
