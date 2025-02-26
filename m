Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715816F288
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593573; cv=none; b=Hs7ULmQ3wnFvVWItIlE29TD4zKFQaGESPzrt0Ts4N43iQ6xbEswKvnJInXuGNkLOlKIP9JeIst/k1XecNaNYVPLof9104iBjcC0AWynBiSo0AhAzeotkuAtNViHYNnIWO1epxHASASr2639E1NyuyQVJRrxaZ6JEyAe2MhZoAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593573; c=relaxed/simple;
	bh=Q8KiemVQQJrcYsH3z7FdM3ECmOT3cW47fHRnP5neQ1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4Bu9zNAnuKzfIWpqnzW3SZ89nyka505fuvtWmp4G1mHYs1NWyEoNhc4s0BYsV5fbhQPXXP7xYbxxDT+C1YJVKj+bDohi7CYc0YZ+uHLPR3i32gBhP5CDa4EeC67BLeXxYEA/FNQ80eDE6CHsEabRVzKy7IwPtOTsPF2rZnpXyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fb95249855so1060037b3.2
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 10:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593571; x=1741198371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWOsRkjYI952wTZZcvR3ph45QBHU1OAqkQcdKv1l2S8=;
        b=IYch38XxFbMJkIHtd+lg2hyswADRtu0uvzPrHmg7J2B7U5CIiPaxM3aBM7J8xuorqi
         45CLTXm8B2wsAFUv2nX7aT7jhdB6xC36KroJZp+q7n+PUqmxzSni/jSsXIWL5FC12IDU
         o5YadPrk+lIGqGHc4wD3XNLI4xv1gHevexw0EieT1BztdG9osx5sl5z5P1vGEJVISLto
         dS4LM809LEaKG0YTvFhYXOgpEdRoaj6UnTKk0cfa2gngy104bYdw1x7VKKlezzF7cD7V
         1VCnwUWWaSYxNMNoiIa0DG1x3R4Acrg7HAno4WSDemvQ+W60MS5RSB1uAPP4gOoQq/qs
         yNCg==
X-Gm-Message-State: AOJu0Yw2unMJFY4rlOxyQMRDyGLB8aFWawT4xwTGLkzYl+JM6tAKcTcl
	z7H6WPz60AlJY6z4oiyoHXjH8wzW6MK7kGKxaxh0EiLWxGbss4b0ySagsA==
X-Gm-Gg: ASbGnct3SdSkgznK3JUn4gn+mEPPA67Nn7HjApzp1AmxIZhCFyIxvxUntxSEg1yZZwO
	WvC0z+at+j9D0yiNm+R1x7jfZOVFqmpRInEh8Qryre9hXiY/vk/wRPZhGq9Dc3w6A0mnibmIuLY
	qBR6I3XDxofIo3SWpuWJo8LFq4+DzPDpNOgkogQRniAP6mALtWpTA5SUl/rsT4JQ6K4gBRuC9wC
	8kM7WOEyRlkCy9AgyyGadR8VR7UiP8vGmVbq+oRM5cbkKa6yT6fV9/L7nH+10rlrwf8FZi7uzjb
	oRUyvhILlyrXKShgglH3xDIm46upYqs+I/ardvHd8wAepgl2xaY87koM6lUKrNAfjhaUhw==
X-Google-Smtp-Source: AGHT+IE8tzdDyh5JLDNjCNcKg376oa8IPOH+94bu2GV0ninwk2LT3Cb6MVDE1wWPahI5xTDxE0w+Sw==
X-Received: by 2002:a05:690c:380a:b0:6ef:5fee:1ca3 with SMTP id 00721157ae682-6fd109ece37mr82379077b3.10.1740593570809;
        Wed, 26 Feb 2025 10:12:50 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd1d9cc005sm7326607b3.116.2025.02.26.10.12.50
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 10:12:50 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e53c9035003so21180276.2
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 10:12:50 -0800 (PST)
X-Received: by 2002:a05:6902:188f:b0:e5d:d9e4:5341 with SMTP id
 3f1490d57ef6-e607a4fb9a7mr7344252276.24.1740593570187; Wed, 26 Feb 2025
 10:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADXxVSKD-YKOxt+=b919QWFHnU7QcSWnEwfb8xU-JGn=xVrbbg@mail.gmail.com>
 <4ec69c46-bbc1-4a05-9d7a-18c1d4d249d1@gmail.com>
In-Reply-To: <4ec69c46-bbc1-4a05-9d7a-18c1d4d249d1@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Wed, 26 Feb 2025 11:12:38 -0700
X-Gmail-Original-Message-ID: <CADXxVS+xAeGUiwGTe7L0Rr+OtxqRdvZ2AwwhfgpegB8h-dA9TQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrACbzmKkXAsNcUzVOUq_Gd3euLRhMXmhgEUCd2HlDabjym-NAZpeET18c
Message-ID: <CADXxVS+xAeGUiwGTe7L0Rr+OtxqRdvZ2AwwhfgpegB8h-dA9TQ@mail.gmail.com>
Subject: Re: Does a AP get blacklisted if it fails auth too many times?
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 11:00=E2=80=AFAM James Prestwood <prestwoj@gmail.co=
m> wrote:
>
> Hi Bryce,
>
> On 2/26/25 8:13 AM, Bryce Johnson wrote:
> > I have an embedded linux device with silabs wf200 chipset with IWD
> > 3.2.  I got logs remotely after the fact so I didn't get to debug this
> > one in person.
> >
> > Every now and then wifi will drop off and usually reconnected.  On
> > this particular one it disconnected, tried to reconnect, failed, and
> > then never tried again.
> >
> > <snip>
> >
> >
> > Is there some blacklist that occurs with enough failures?  This device
> > ended up sitting like this for a couple hours before it got restarted
> > - after the restart IWD immediately reconnected to the AP.
>
> In IWD we have a few special status/reason codes that won't cause an AP
> to be blacklisted, but an auth timeout will blacklist an AP. You will
> generally see this log [1] if there were APs seen but they were all
> blacklisted.
>
> The original reason for the blacklisting was a use case where a specific
> AP is "broken" and repeatedly fails to allow a connection. We wanted to
> exponentially increase the blacklist time for every failure so a client
> would avoid connection disruptions. It really depends on your use case,
> but I also work with headless devices and we control the networks. When
> there is some failure that would normally trigger a blacklist, I'm
> fairly confident this is a transient issue and isn't a "broken" AP (this
> obviously isn't a guarantee though). So in my configuration I've
> actually lowered the maximum blacklist timeout to something like 2-5
> seconds to prevent repeated failures from blacklisting the AP for
> extended periods of time.
>
> [1]
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/station.=
c#n286

Thanks James!  I'll check that out.  For also headless device use
case, we are never moving and only provisioned to one AP.  So we'd
like to try as hard as possible to stay connected to the AP.


>
> >
> > <snip>
> >
> > Thanks
> > Bryce
> >
