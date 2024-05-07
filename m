Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6271B3B
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715119960; cv=none; b=BzwFhu1c8k7uTwSvWzgbOc1ou1aTP2hd31bFw26OwHR1+yG/tVlwxcR+q0N7Q+7/ge4reu0FbxJTd5EPry1RfzE3VaIAlpH0Ube3lE4uNbe9JfpFyx50pJeJakjvjciOVsW8q+0LJW1Clsagx32tTtkmjbsAPtzxj2BsWOZ8IBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715119960; c=relaxed/simple;
	bh=X/f+80APzy8/IFndpYahvvOHsVnSPkEZJRb+Fi9MPvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+h9Jvdu2SBk7teLzVJqw47xk6D/4fR526C8QsDDwnk+p7bAIrV0wRizhDmbE/w8UpoTAQrjBHjmu0dxWLNHyFDS8H5HJBVn872zvz1PxBEQH9ZNlRnX8p0YX46XAorjYA7PuubQWr6QKG/2Y7cKqKjvK49+eKrmZMvVC0IhxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrCBvMJ7; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrCBvMJ7"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43d18a7c1deso2066671cf.0
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715119958; x=1715724758; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V8SaW3GDYCQ8TACdNsYB8df5i/F9RP0TXnXcqOyNm8=;
        b=RrCBvMJ7RehoNvTShyyofKxjjv/u5gv6Kvg6a2ycAjNVF3Ou9MecHkWL6KoedCJDB4
         YJzRHQXYmB6uzI7b7g3YbEIph0E8+eJdqohFSVfDgR0SsduHHNBg1aDU5aWrVHvX3Ocm
         DbJPo5EpO3HkGbr74AJsai8Hgag6/qJrHP/JUKV5y46Pxz5GZQBfzcykVAJL2cmd5KZg
         E50gRzacuMDfRNagZAuL4ji2Qzx1THgo2AQ/UKohcraEj//Yc0/m8WsQa3IMlIP01G50
         gSvGIJQeCBS16HOVcyvqoUSqeuZcgxG7iKJO//KaL/S7JU9w+JzMKYe3etxk5/V8f2z8
         b7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715119958; x=1715724758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2V8SaW3GDYCQ8TACdNsYB8df5i/F9RP0TXnXcqOyNm8=;
        b=Avd9i/siEsvMy18D+QBAUbSfBeNZlJjD9L9BqV5JWI6HjRCPL3Sp8vvGGeQu1n1Q0H
         LeMWTBk4eZj26tMW3gHbVSL5XnmiYXKEgjgrOWTvPIKyUZXzSIlJ5AbT2jJCZw+hB8sR
         +efUfBh9AFKFkiqL+r3mryD+RX9grnO9gvGMVtZUZi0ITFdYX2hmoin3hAeiOnyoWbCJ
         ThCi6oe97SMyvWQpEqUTmWxum6Gi53SsuGS9XHSVs9UipgCpVYOdhj88Wbr2y5B8cQ9n
         EjD6Ej16TdsRwbSTVpSFJm6cYnhGTAl6Nq2GlHcLIclrIBaxcahONlXugDITdaZ9sY5m
         DBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX42ZWnrCCAdQQUy9G/8t7xTlN/23wyy32mcymGMc3pud4Xlnw2wk13NS+GpotanBznNcUpIQrO3I8dF+fLFcjYFBgn
X-Gm-Message-State: AOJu0Ywap3vtwuBbeDT7ITJnCPHhpDfKc1InixPbk2S5SSwscy5cdCJx
	60wgJQu6ZaP/3OZW8fg5Y+vB49mmDFSlE298N98rTBadEvAdLhPjh+hh4IBLgyB0H61K5YXryWa
	3bxUCs0Z83DT0V4YUPWbNInC1Tek=
X-Google-Smtp-Source: AGHT+IE5YrhTGV01skb6wuFRG7y+FVnFB8tGIFRbBvhztEVSDBRHkeuQ0/hd8uafUSneCVwxe3/g1AkwiDm6wvkDMsM=
X-Received: by 2002:a05:622a:d2:b0:437:b582:cbc9 with SMTP id
 d75a77b69052e-43d8f5b9d82mr67931001cf.24.1715119958198; Tue, 07 May 2024
 15:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADvTj4qmJm_Lyk5bR_WZE8TioVa5f0MHdtDghJdRX=9ZhivzjA@mail.gmail.com>
 <7fd93025-1bb2-46a9-aefc-3e74942164b9@gmail.com> <CADvTj4pHyYewHzSUF+546JPO6Y0Co+QfFcBbJEctNWQBNJmb=A@mail.gmail.com>
 <73d7295e-44e1-42ff-9d45-9effa65a0698@gmail.com> <CADvTj4oH4PjcD=0QXYT6BTEpQhtONr6QsT1mp+nmcG4Uc10c+g@mail.gmail.com>
 <3e5c8d35-b08c-4906-ae06-7a5d511d518a@gmail.com> <CADvTj4qvEniwLnox8dZeqsDRbrBZfiqbKoCPxgRRNVu8sDBWBA@mail.gmail.com>
 <82696cf2-9bad-4cc6-a302-f3797efc6d1e@gmail.com> <CADvTj4rOr3p80nTg3ACqQMzse6HFWfijFQYwKj+eonyCLz_V2Q@mail.gmail.com>
 <8b2156c0-7b98-4bc8-ab1a-5009389e5e83@gmail.com> <CADvTj4pYPBbvEDBoTnEZacE-Ah7S7wgCBYkJoonUMfac1o64ag@mail.gmail.com>
 <d1e641d8-5a7b-45f3-9505-164a92997b7b@gmail.com>
In-Reply-To: <d1e641d8-5a7b-45f3-9505-164a92997b7b@gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 7 May 2024 16:12:26 -0600
Message-ID: <CADvTj4pZ4JV8Ji2YrnRFs2fxar2wF-xRdhLTFLndKd0i8D1x1Q@mail.gmail.com>
Subject: Re: NetworkManager connection gets stuck in pending state when
 bringing up AP mode connection with IWD backend
To: Denis Kenzior <denkenz@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:40=E2=80=AFPM Denis Kenzior <denkenz@gmail.com> wr=
ote:
>
> Hi James,
>
> >>
> >> Should only be using the Start(ssid, psk) method. Its really that simp=
le
> >> so I don't see how it could really get anything wrong as far as being
> >> notified. But again, I'm not too familiar with NM.
> >
> > Looking into this that doesn't appear to be entirely accurate, that met=
hod
> > seems to be working fine but is not the only API NM uses to interface w=
ith
> > IWD.
> >
> > It looks like NM is also using this for interface configuration:
> > https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/agent-=
api.txt
>
> That is only relevant for Station interfaces (i.e. client mode) if you're
> running iwd with EnableNetworkConfiguration=3Dtrue.  The Access Point mod=
e is not
> setup to report network configuration details via this infrastructure.

The docs indicate that RegisterNetworkConfigurationAgent is relevant for:
station-mode, AP-mode or P2P connection

If AP mode doesn't support this interface then how should the network
configuration details be reported to NM when running in AP mode?

>
> Regards,
> -Denis
