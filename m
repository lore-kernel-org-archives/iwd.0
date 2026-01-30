Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51751256C8D
	for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769785337; cv=none; b=bMOPlHEKv8sMksEa8AXi5kVqWFIcAtTO6KAr5bKMcEpKAmmB24RdgJoOuEtKW3oBDxkECLCFfrLDR6l0pYfmQwb/Qs6hxQPUZ2vrHdDgWbHgZTa+rjr19aMgqqbQ3kNJaQiAH2gykg/bIQt/LoAO0rKOxPJh5Zk3oDhg7d2PDdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769785337; c=relaxed/simple;
	bh=4tv7cYo56DH1vCRjyRX2YX9t0dA77zDIzSsSNGNq44o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0/tX+4oQkBVzCOaQlNZINvBVuDehZzfvMxvVKs30E+5vd4Sv25ZCJ4l+SdAu1SKo/eWA5VQRueMgkG2L9vMOMqSI3pd5UjCRjZUR+KOcuHDfq+75yQ+A50OQqcCoo8qD2OdiNjeHZzZq4j7bPMTVUjbDpgnP0XipbB89HIi0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7944693b824so22561727b3.3
        for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 07:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769785335; x=1770390135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+uQ7NKq1h7scvh9VO7rwffUO0CZ1Vprj8iqeZ0h9eEA=;
        b=eU6ir829lR7e0Aqdgp7E4OykgfMMNQxIZmuTo9NHQZP9u1o1w0MXA/Wg47z8TyjUmF
         hdNq199ZKEsSaCjvbYSnuYlRwwa63Bg2stKWj2j4UBXKnOK3vZj2HIt0gsCz4pxx7qkP
         OPDdUxztDT1OqxzSOMyuOZRBBJexJypwe964yxEJKgP9tZEAQNfQGsdKOtbrLcg2Us5j
         AxOll+dOAUJKelikqQg2esRhpd1QMipg1T96yXKeDk0SyREEUJYyiFM0ziW8QYAtulUi
         KxX8iNNxopytMPAOXMGkuoCz/SJM/KSiv4pHHe7jwUO4z51Gu/Cv2quZsmGHP+oe/NuZ
         7DdA==
X-Gm-Message-State: AOJu0YwWJV9CHiaIRAi52TZj5hbe069X5+hfUMYT0DFjVKLBPXb/v2qZ
	WkmKrMWEyTIgbTUfUwEszssu+ZVqrrVBP4j7b4VcVasEHFoJnc4tEx4yq11hbw==
X-Gm-Gg: AZuq6aKFMJFpBNRXyCG5z5/UWCLO2MkjYBr3SrwLH/FkPKttiAr4uUWJdwo49VTi5eM
	ai9dDtbK6SVN85CDGy4h+NF2uSV65HUyve8dzaBoOQIL7Wig+0w1D0HnQ/N1Bro+8JmYgunOQbY
	I2xP2RJIum8rRgEdo+OkeFfFqMKVjCQfeSyUddsvvJXG2G/IpGbhz1/CfTLOpATwJK5XYTtFauC
	kR2IZZRnvXDsenoVzGP3qTLVqUOBAmRaW9mtJRqb/+BoDJeXsKbMgwkqKczhq3Os1d5P6XOu1gP
	u0UsleP1561AXlgckOC7LWk3h5Kd/imjH6K6i5CHc07D+QFww4DW0gpGQoSPdFJSrXjd0uwtezX
	NEKsDuTg0V54/tj8TzXWYyBZEMdym32/wItO14b9vdT8T/mapJITVXtk6pHJgqSrsQacl0uR/ZC
	pamoFGUqTT47RDDu2CO/CD4o7gYOHpoILsLaok23EI7qfVp8bZXw==
X-Received: by 2002:a05:690c:6d84:b0:794:6fed:95a7 with SMTP id 00721157ae682-7949dfa9191mr28905407b3.37.1769785333236;
        Fri, 30 Jan 2026 07:02:13 -0800 (PST)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com. [74.125.224.50])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79482767fb2sm37506567b3.6.2026.01.30.07.02.12
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 07:02:12 -0800 (PST)
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-649655f14d7so2205181d50.1
        for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 07:02:12 -0800 (PST)
X-Received: by 2002:a05:690e:4183:b0:644:535a:67cc with SMTP id
 956f58d0204a3-649a84fbf82mr2011688d50.69.1769785331664; Fri, 30 Jan 2026
 07:02:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADXxVSJ5FrxYs_s_tz5y6LeGbVLnCgJP3YO8TQEXTnXs+rFuug@mail.gmail.com>
 <3d09fed3-9728-43e4-840d-13052b5fbf6e@gmail.com>
In-Reply-To: <3d09fed3-9728-43e4-840d-13052b5fbf6e@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Fri, 30 Jan 2026 08:01:59 -0700
X-Gmail-Original-Message-ID: <CADXxVS+_B2r0yAUKKD5X_xJ6GmfkfkngwW_XHQyti=+9cMmzqg@mail.gmail.com>
X-Gm-Features: AZwV_QioEwkMWUHis-za-QYAAhduzZlrXQ7by1_FyjzirHWhaBbuTmvtoZgmGBk
Message-ID: <CADXxVS+_B2r0yAUKKD5X_xJ6GmfkfkngwW_XHQyti=+9cMmzqg@mail.gmail.com>
Subject: Re: Is there a way to manually force the security protocol with IWD?
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James

On Fri, Jan 30, 2026 at 7:48=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Bryce,
>
> On 1/30/26 6:43 AM, Bryce Johnson wrote:
> > Hi All
> > We are working to get our product through wifi certification.  Our
> > testing company mentioned there was several negative test cases that
> > were failing where IWD was connecting anyways because it would decide
> > on the security type based on the AP.  Is there a way to force IWD to
> > use a security type that is different than the AP so it would fail the
> > connection?  Can we disable WPA1-only connection or force WPA2 only
> > connection?
>
> There unfortunately isn't at the moment. We do have a "developer mode"
> by specifying "-E" to IWD and this seems like it would fall into that
> category, support would need to be added of course.
>
> But I'm somewhat confused (and maybe this is just poor test cases by
> WFA?), why would you need to certify that IWD fails when using a
> different security type than the AP? A client should not ever use a
> security type the AP doesn't advertise support for... This feels like
> its testing the AP, not IWD :)
>

I'm was requesting what test case fails and if I could get a copy of
it.  The only thing I can think of is that they want to disable WPA1
for example and show that the device won't connect to a WPA1 only AP.
Or maybe for a product you only want to connect WPA3 and fail and not
connect or not allow the AP to downgrade the connection.

Maybe it would make sense to allow a blacklist of protocols you won't
allow IWD to use?  For our product we wouldn't allow open or WEP
connections for example (but we perform that check outside of IWD).

> >
> > Thanks
> > Bryce
> >
