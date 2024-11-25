Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236091AF0CE
	for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732562755; cv=none; b=ervxH8C4ACFkg6XnYl+qST18iqpfOuk7wh1bjfWC23jHHAnXR+kar+EOwn6tlBm3WR4he+QrGPAU80Xkf+5t0og76EW4UFK6t1PXbMvGxsF4CmbBoTowlhZFpJpXWtL1nT4L13TZ7OdYnNeG3mfakkylxJ5oTVti8NXaf6txY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732562755; c=relaxed/simple;
	bh=vxhHE4eM3bW9DS/aF6ppYac+trBfbdmVf9UW9xEV7vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr2uhG5SZ2TxEgNU3fVX1hizsoF/WgLzxqLoKXgJmsmo1jwpSzA/rUJjUueWees7SMf6m+0dVBuM2tG6hNFjCLpg24UZEeFwTjM260d2fyH5W5eQ/jXyIJDr+6WWz93lCw321Vq3DxLtwmw/l9rtml7XoZhRrIkZeoWM8cKcsqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ee805c96dbso43163617b3.2
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 11:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732562753; x=1733167553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8geiLWezccOO1wQ3VBxHL+DEbTLu2TDla4HDFCN9Qs=;
        b=k2h7tsVfrpFI1Uu6cuqkFBGaahrijRr1HN/YcxL7nAgV/teYqJoJ5f/Bqles+Wc4mZ
         OEiOGg95E6cLUYLS6thUT/iB+spbpjwKqtIEcYEeuMegCvmQx2BHQgpoCeqBnSbZ+ofv
         xw5TflUchYPIjBq7JceyrocAw5zOvODk5OzaQG7tYyZmASy4rOOEBjRT97cIRthPF8MI
         GpnBaMaReIRXRFnKHkACA4j1Td3DJoBV04EzRuECiYeSwQsyVe8EOAQa6TJyiEJUZYpT
         YiMW8+m2PNpWC5i7/BeVsGnR37Sn9y5oGw/47z4GiHnAX7O60b2/3vU/Wf2rwFlRIcdK
         vP2A==
X-Forwarded-Encrypted: i=1; AJvYcCXmP9rd1z2QNoKCOTcXZNYQkyHFTQTcBgrHIBILAWrMJnlGuxhEotZSwYAk8/HNiEG0GMU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3F3ypX6UO9DFf5Xt8ncw7DjszVmNZM7IcBiZU7bk8nF+2CHin
	wyjRRUjGIqw2hjc0yvNiqvKpnmc7q4wjgpnbXIl5lL3hRkPvbLxmT/VV9w==
X-Gm-Gg: ASbGncu61LjPxini6i1Sps1PdDqPDctr1HkczPpSBOhPdP7qKL/h3CugxVLaBV4eKCR
	GknT+3M8k+Q0+oWElD6Yxl45FKW8RfMRVbvBKkJdb5GD1k5LLfmlFsCrUUTpw8bkp1fwncX/DmH
	ezUAG0JJNWNssA90yNL65oxHPIjGGy1rvwxHgeA5ra+JWo5TLEsHLjAu/OibWpQ7yrCB5IkDWxQ
	8ThuauPCqk4zeAEJyB2sb3gje1Zd0rN4MnozkSgcVfIJR+FO0KnLvxkSaQfi6p+OTt1l0aICMfV
	4acg+S33k7RhUmABZA==
X-Google-Smtp-Source: AGHT+IEhksqD4XjOeucrbSXFATTFrJAVBlE0IGAy0bWhqCk6vwAn8hPw2HbEyz8+dPjzNGyITjcnkQ==
X-Received: by 2002:a05:690c:7084:b0:6ac:ce34:9726 with SMTP id 00721157ae682-6eee08cd8afmr135824757b3.18.1732562752785;
        Mon, 25 Nov 2024 11:25:52 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe48593sm18955177b3.56.2024.11.25.11.25.52
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 11:25:52 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso3956666276.1
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 11:25:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWX+/6ANHQnNpbo0OIr3WgIirlpoVmF9n4Hxeh9TM24Tq+/XOz5/eDzhIw7w7S+pjN7wIg=@lists.linux.dev
X-Received: by 2002:a05:6902:1545:b0:e38:c503:226 with SMTP id
 3f1490d57ef6-e38f8ad829dmr12090976276.11.1732562752176; Mon, 25 Nov 2024
 11:25:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241122151551.286355-1-prestwoj@gmail.com> <20241122151551.286355-10-prestwoj@gmail.com>
 <7fd01a53-53a0-45b5-993f-6bec6ba16a1a@gmail.com> <94bdf4e3-2617-4c3d-a2c3-5c34cf684906@gmail.com>
In-Reply-To: <94bdf4e3-2617-4c3d-a2c3-5c34cf684906@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Mon, 25 Nov 2024 12:25:40 -0700
X-Gmail-Original-Message-ID: <CADXxVSLt1t3TdWConKv2rLBb1HdD0xd3gckaeCYyrjXeA0K4Sw@mail.gmail.com>
Message-ID: <CADXxVSLt1t3TdWConKv2rLBb1HdD0xd3gckaeCYyrjXeA0K4Sw@mail.gmail.com>
Subject: Re: [PATCH 09/15] handshake: Add pmksa setter & stealer
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,
Thanks!  We will running another product through wifi certification in
the next 3-6 months with a new chipset from TI (cc3301).  I'll check
with TI to see if there is a pretest so we aren't running into issues
at the lab.  We got our last product certified reverting back to
wpa_supplicant just before the wifi alliance pushed out the latest
changes/requirements.

Also annoying the cheaper automatic testing uses wpa_suppliant pretty
integrated, hopefully wifi alliance will create a way to do that with
IWD in the same way if enough people are using it.

If anyone got a product through certification I would be interested in
any experiences with IWD!


Bryce

On Mon, Nov 25, 2024 at 8:01=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Denis,
>
> On 11/25/24 6:56 AM, Denis Kenzior wrote:
> > Hi James,
> >
> > On 11/22/24 9:15 AM, James Prestwood wrote:
> >> From: Denis Kenzior <denkenz@gmail.com>
> >>
> >> The majority of this patch was authored by Denis Kenzior, but
> >> I have appended setting the PMK inside handshake_state_set_pmksa
> >> as well as checking if the pmkid exists in
> >> handshake_state_steal_pmkid.
> >>
> >> Authored-by: Denis Kenzior <denkenz@gmail.com>
> >> Authored-by: James Prestwood <prestwoj@gmail.com>
> >> ---
> >>   Makefile.am     |  4 +++
> >>   src/handshake.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++=
++
> >>   src/handshake.h | 11 ++++++-
> >>   3 files changed, 91 insertions(+), 1 deletion(-)
> >>
> >
> > <snip>
> >
> >> @@ -141,7 +142,12 @@ struct handshake_state {
> >>       bool supplicant_ocvc : 1;
> >>       bool ext_key_id_capable : 1;
> >>       bool force_default_ecc_group : 1;
> >> -    uint8_t ssid[SSID_MAX_SIZE];
> >> +    bool have_pmksa : 1;
> >> +    union {
> >> +        struct pmksa *pmksa;
> >> +        uint64_t expiration;
> >> +    };
> >> +    uint8_t ssid[32];
> >
> > I changed this back to using SSID_MAX_SIZE instead of the magic number.
> >
> >>       size_t ssid_len;
> >>       char *passphrase;
> >>       char *password_identifier;
> >
> > All 15 patches applied, thanks.
>
> Thanks!
>
> Bryce, I know you were interested in this. It would be good to see if
> this allows IWD to pass certification with the wifi alliance. Let us
> know if you run into any more problems on that front.
>
> Thanks,
>
> James
>
>
