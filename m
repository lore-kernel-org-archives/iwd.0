Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941013570BF
	for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793685; cv=none; b=Yi4yDUb0KMYABnQO/BAeaAFUNC/mZzGJ9CJuzTBaujx+G2O1F7UL+hScQI7nArjJshIeU3RV3l7utS3GNQ0doMalePjxfa9HsEwhV4GQ6Xkx3lSOGvupJ+HwLa+c23/XbCJEew8+/ppRcdk3Mo+oEmP32IOmpKwd3pJARngY3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793685; c=relaxed/simple;
	bh=CEng0TWE0bD63AFOI9aI2e42VUvR7j/xkP/WtBhCyqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxAYbSHQXiMu/xao0HqjO6yCMz8pRhz1fG6lmiD1uwrLfQyI1fSzSB0FmLHISBlImBuqHcaRb499tO1kEfYemGJ6x7GXIjI0dM2IQIW8jDeTjGgYTgm6VI5RtchemO81rqgUVEsOuJkiW7iVawooonxPfwjwSw7t7CE7l4XPJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794911acb04so22776937b3.0
        for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 09:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769793680; x=1770398480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGM24k3MsclIXb6Q/3z59z8NlPQaEQMOOdc3UzPBbFE=;
        b=xOytnCbA2CUX6zmR4s9Bj20tZjU6mRHCEvFOY6SL4Sk/aHKdjv2fcHo1eDwsTvR9lH
         S/49wpWxSqB/jxkfOg+pKYOd+SxuDk41GcuBpyFFArlN3YC7BoEX4yQy0EEMH5WvghST
         y+h5s5jjYQiMX8OMVx56k6arquXPBA0vxBkGJROTbL5EpAAX/r/qJqbrdLzPJ6mteNU9
         ev0R/urszc/fWfBxgEyF0onE4+8gnMS7UCEGKjKnhWWZ4XNuyJkYBLAlAsFUfx89pciZ
         UT+QFnv5FLo1QuE7Owkmj5dI+vaGJyiHv1G28J+j7ZKwmbZHDpSc9/UR3+uJDIL4ISdc
         YNSg==
X-Gm-Message-State: AOJu0Yxo3DSCQipWWU4tgJ9VhEeBIe1TYIheus9LoGyGfC0OQjHEdgEl
	XBdfz56C9EfGVcrh07m+BezNjLMd//YJGa+SK3E0pj4MwY/N6jETV6V5cazziQ==
X-Gm-Gg: AZuq6aJ5F7JRhQottgWcSWNRXX9g+Dzi9CeXRAZH6GhToboKuF1y7QB9HkaOWo4p6lP
	Hftu5omWUnb/jXm+tDDJ0ny6SuPJr9aHd/V6K0ZnlulKvEsYsBg6mzRD+WwmyBxZF3P+0TqOsHL
	bzSx+QZr3QLglR0hCFgfvYHGqTmgewaEqXhh3EfIpWZ52q6VfiIxWeZn959o7aM4Qj/nTXJD/L+
	+6IvxS0CSXusSg4vXvJa/JF1vn/48N/Opk2gJzUv0grXkEkzXoS2fsNb99OcXDq+oLEeGQ2JzKp
	Sb5AB2EgWAsZv7xLlf3aQHJfSdt2yftgXKzaAIcU92bfXzwdsEksfrGYM5hLm6ojbMmbeomvpzZ
	t1rC9e2bRkY08MIXTbgL+sS2L05urEDOhI/6Sr59aQhffFOtZ4C6cuSdW/45PrdKQrUWUNBPDnu
	E1Uxj1IY9vyfEuQLYd1xSFysQMIV4u0laagT9Z5cJdMH+/5C98y5MuHFy6qzbCYi/h
X-Received: by 2002:a05:690c:460e:b0:794:2bd4:fe2 with SMTP id 00721157ae682-7949dfa900dmr23074557b3.32.1769793679885;
        Fri, 30 Jan 2026 09:21:19 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79482763934sm38236977b3.2.2026.01.30.09.21.19
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 09:21:19 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-794911acb04so22776677b3.0
        for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 09:21:19 -0800 (PST)
X-Received: by 2002:a05:690e:b89:b0:641:f5bc:6950 with SMTP id
 956f58d0204a3-649a8521a3cmr2789400d50.84.1769793678923; Fri, 30 Jan 2026
 09:21:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADXxVSJ5FrxYs_s_tz5y6LeGbVLnCgJP3YO8TQEXTnXs+rFuug@mail.gmail.com>
 <3d09fed3-9728-43e4-840d-13052b5fbf6e@gmail.com> <CADXxVS+_B2r0yAUKKD5X_xJ6GmfkfkngwW_XHQyti=+9cMmzqg@mail.gmail.com>
 <4ab7e9b9-be27-402b-834c-3e71bd58a476@gmail.com>
In-Reply-To: <4ab7e9b9-be27-402b-834c-3e71bd58a476@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Fri, 30 Jan 2026 10:21:08 -0700
X-Gmail-Original-Message-ID: <CADXxVSKsC=gmYoXk9UiPDfHW0a_MbfKpDc2YYH=qprA5bGNfSg@mail.gmail.com>
X-Gm-Features: AZwV_Qi8A0IV7_35xdIXCEC4of7re8fvAXojI7z6ouj_A-Fv8PlKlFaSH92hulE
Message-ID: <CADXxVSKsC=gmYoXk9UiPDfHW0a_MbfKpDc2YYH=qprA5bGNfSg@mail.gmail.com>
Subject: Re: Is there a way to manually force the security protocol with IWD?
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Fri, Jan 30, 2026 at 8:07=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi,
>
> On 1/30/26 7:01 AM, Bryce Johnson wrote:
> > Hi James
> >
> > On Fri, Jan 30, 2026 at 7:48=E2=80=AFAM James Prestwood <prestwoj@gmail=
.com> wrote:
> >> Hi Bryce,
> >>
> >> On 1/30/26 6:43 AM, Bryce Johnson wrote:
> >>> Hi All
> >>> We are working to get our product through wifi certification.  Our
> >>> testing company mentioned there was several negative test cases that
> >>> were failing where IWD was connecting anyways because it would decide
> >>> on the security type based on the AP.  Is there a way to force IWD to
> >>> use a security type that is different than the AP so it would fail th=
e
> >>> connection?  Can we disable WPA1-only connection or force WPA2 only
> >>> connection?
> >> There unfortunately isn't at the moment. We do have a "developer mode"
> >> by specifying "-E" to IWD and this seems like it would fall into that
> >> category, support would need to be added of course.
> >>
> >> But I'm somewhat confused (and maybe this is just poor test cases by
> >> WFA?), why would you need to certify that IWD fails when using a
> >> different security type than the AP? A client should not ever use a
> >> security type the AP doesn't advertise support for... This feels like
> >> its testing the AP, not IWD :)
> >>
> > I'm was requesting what test case fails and if I could get a copy of
> > it.  The only thing I can think of is that they want to disable WPA1
> > for example and show that the device won't connect to a WPA1 only AP.
> > Or maybe for a product you only want to connect WPA3 and fail and not
> > connect or not allow the AP to downgrade the connection.
> Yeah I'd be interested in the test case.
> >
> > Maybe it would make sense to allow a blacklist of protocols you won't
> > allow IWD to use?  For our product we wouldn't allow open or WEP
> > connections for example (but we perform that check outside of IWD).
>
> IWD already won't connect to a WEP network, so we're ok there. You may
> be able to coax out some behavior with the following options:
>
> main.conf
>
> [General].ManagementFrameProtection
>
> network profile:
>
> [Settings].TransitionDisable
>
> [Settings].DisabledTransitionModes
>
> Anyways, lets hope you can get the test case. Shouldn't be too hard to
> add some support for specific test/dev type requirements.

Here were the test cases
For test case 10153_1:  The test bed AP beacons with no security.  The
test case requires the STAUT to connect with WPA2-PSK only.  Because
of the mismatch of security protocols, the connection will fail.

For test case 10165_1: The test bed AP advertises at WPA2-Personal
only.  The test case requires the STAUT to connect with WPA3-Personal.
Because of the mismatch of security protocols, the connection will
also fail.

I got the PDFs of the test cases I can share offlist as well.  10153_1
looks like it would not connect, but apparently hung up on the setting
the STAUT to WPA2-PSK only.  So it looks like I need a way to restrict
IWD from using other security types for these tests.  If you have any
suggestions on a good way to do this, let me know.

Thanks
Bryce
