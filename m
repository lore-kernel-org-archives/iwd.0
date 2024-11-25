Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8192B9BF
	for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565925; cv=none; b=jT0vnbTh6MvTHapqDOi0DBusCVKDZkZ/nUnXHncmexvZQwkJRw95oD9k02kYcV8+MjGtHExqkjBFcdW9ruPiw88+bkJVkaaUHDLGBBfoyt3Bop1zWHKhKboArD5wETX383sKwqPlmWnvQpWdDXLW7p7j/DE2PuZC9Ruo254ZqWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565925; c=relaxed/simple;
	bh=nvMnndR1MOtzmNXSy+A1tK2jJSckYahzsClG1Br6A5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIdRV0mVXA56yuWW3kdN1tRuisoDGNi060Z5RLs93GpNxD0gw1odH3kOQdg+G3omG2xpv9XOc3CHX2GYxroxu0+VbIdwLe+UVDZSp+bdR+0ZgE8lLNsAcBJGbZiO2mct5WqgTwbHLeVuZOs7RpcKg673D1Bj7tOZjPJTRINtgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ef0c64d75cso13974407b3.2
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 12:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732565922; x=1733170722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSDXLtcBSqr6RLl1ixii/VTbyIOXOk9aZClE5qfG4a8=;
        b=DeN6avVUdSJrYL+IUZVWxdNkJ8OCg1QxPBBJtVSQi5f99+DM0uiWZm2Ro8hagxZnH7
         wu4tIEeJTvzNMpZI43/OKLpTOxN9YiqKGnOq3iV5oYuyvF/rg6q79JBmOBS/A5hQEOxJ
         qNtHGejwqPTfe2eCkjA2Ex3IhpvdnnC3yRc3c3QyQ9v7PJNwhuWpWb0mxzz/HKvmsBrn
         PO3+PNQpQy4ATSvPgXyyn1TU8u0TJiJPDLqGUooSIxTo4Efqu8nJm/0J/81zSPRyCItb
         uvzXk2fNxHHBGLNFxcLq+ULfIPZODb39waNbWufD7PDzUYQV590QjEYDh1hqV2tqLC9q
         DMFA==
X-Forwarded-Encrypted: i=1; AJvYcCXUbzeCPM9COwBbpoYmHqUMVpXcXgTY91T4iCGtwD93GZaQ0y+WFrT4+EzffvMbc1S1i6g=@lists.linux.dev
X-Gm-Message-State: AOJu0YwttPg1cOavB53cD2jASSlpPXjIyKAZLEWuKuSHvevjZmjFqDB4
	gpxVvWJbb75mZz6PYvtnjQ/SubIYl+5hrelKF2QaM2gArHDx6c3Kp28Sgg==
X-Gm-Gg: ASbGnctvXtIIeKxvu0s2eSb0alKG9C+xF+RQnj43Abv3Z1IcSvcD/6WYXxgVmLP0xXp
	iRjrkuLQyMM/G+9LSV/Q+wYE3VJRlhHlpdVsLrA0C/Kw1uMPNI7MsTVxsAdZwhfkWXCarZxz+o1
	VS1oC6453/kv6AObsGJlJ6+YKfzRodufRn5KsV4yOVq19KLYD2SqY0dxHRMx8E5gNf4CtbU+no/
	hCFbO+HvjmgFNHknPF6sL5oo7Jt5WVgWtJa/37RQDfAHeUtVT7mFVoGZyDmgthugvppbNbpLAlI
	0P+kitiltoc9/hBMjg==
X-Google-Smtp-Source: AGHT+IETVroNPDmISy6Dut+PSJhC5NLolLlOcEaFbZ1zYvvTML4t4LmWhIfsEsg1UNKYbUVDG8ICyQ==
X-Received: by 2002:a05:690c:2e8e:b0:6ef:146a:aab1 with SMTP id 00721157ae682-6ef146aaed3mr27665977b3.5.1732565922206;
        Mon, 25 Nov 2024 12:18:42 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe42061sm19224327b3.54.2024.11.25.12.18.42
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 12:18:42 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e388d8850d3so4758935276.3
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 12:18:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmxzDyKMW/jap8vCFJzpjX2LFUMMlB3WaaPZ5eEBnbGHxjnwloQx7zp7zkBnQ2yQedAkA=@lists.linux.dev
X-Received: by 2002:a05:6902:2d08:b0:e38:c5de:bda4 with SMTP id
 3f1490d57ef6-e38f8af7ff9mr11721864276.11.1732565921819; Mon, 25 Nov 2024
 12:18:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241122151551.286355-1-prestwoj@gmail.com> <20241122151551.286355-10-prestwoj@gmail.com>
 <7fd01a53-53a0-45b5-993f-6bec6ba16a1a@gmail.com> <94bdf4e3-2617-4c3d-a2c3-5c34cf684906@gmail.com>
 <CADXxVSLt1t3TdWConKv2rLBb1HdD0xd3gckaeCYyrjXeA0K4Sw@mail.gmail.com> <8c9f273b-b983-429d-b397-552e05650ace@gmail.com>
In-Reply-To: <8c9f273b-b983-429d-b397-552e05650ace@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Mon, 25 Nov 2024 13:18:30 -0700
X-Gmail-Original-Message-ID: <CADXxVSLktyTmNVRLROvjtbQrKh8BKs9BJKf9GMfJTmYurYSvMA@mail.gmail.com>
Message-ID: <CADXxVSLktyTmNVRLROvjtbQrKh8BKs9BJKf9GMfJTmYurYSvMA@mail.gmail.com>
Subject: Re: [PATCH 09/15] handshake: Add pmksa setter & stealer
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi James,

> >
> > Also annoying the cheaper automatic testing uses wpa_suppliant pretty
> > integrated, hopefully wifi alliance will create a way to do that with
> > IWD in the same way if enough people are using it.
> I'd be interested to see what they are doing with this. If they are
> letting wpa_supplicant act autonomously and triggering things on the AP
> side, or if they are using the CLI to interact with wpa_supplicant
> directly for "force" it to exercise some of the features they're testing.

I looked into it a year or so ago - a bunch of it is hidden behind the
wifi alliance paywall... but they have some examples,
https://github.com/Wi-FiTestSuite/Wi-FiTestSuite-Linux-DUT - looks
like using wpa_cli in some cases.

Also:  Mentioned in the doc/INSTALL for the DUT agent

3. Running the software
   3.1 DUT -- dut/wfa_dut
   a. The current implementation is based on the open source wpa_supplicant
      (hostap.epitest.fi/wpa_supplicant). The DUT must have this installed.

The test lab had to run the tests "manually" when I tried to use IWD
to get it certified before.

Bryce
