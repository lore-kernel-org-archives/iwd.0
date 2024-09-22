Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8402CCAA
	for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727031409; cv=none; b=jqQtIP7rqQuvKu+ucelKwN3P+Xx6pAmp1xsS30iHGWbHbajoVqhRT7M33gWoc/DjQT6bem6nqEmctGQnmV1BtZGLALfnjYhp3DOeFQpwMlKd3b1NuiRbTLu/L0hwdaOcjmYog3GxSBdDKJT/W56lx5HwriQOYSg7Uab+/Nk/B+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727031409; c=relaxed/simple;
	bh=2v3DSPe8biM2do2wBQ2PJN/0NjQ38xy9f9idwsvvl94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMQcCFxOXtOJbMBAzZBfDqlTzA0WY9NqtPHTX6vqaPwPbpxiDIV8snRGtOJ/tg2X9JalR2O+CzzJ+a5mlL9z4m20HAeVMlysBqQCJw9kaub9KDHWKcjMyTkTJqfSbegvy98jRSmenXTR3NJ8DsD04gRAgZFAXXQNfHqbKmTp+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4KVAjl1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4KVAjl1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20543fdb7acso28890295ad.1
        for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727031407; x=1727636207; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgChMCHT6Uj5JKnZ8lcczVs9LXWlZ9vpxnpZvsKF8O0=;
        b=H4KVAjl1DMKQzHC4JUy6a152m+J2OetYCGqigYcqAiwARKyq9W3uKfaaR+mBU6pSKY
         Ai9vCFG4WBWGPqm133DTkeia84s2rLFMdqImfhZu1e/0MX1lPnSv2ZcPnDfHr7S8eEAH
         wRzUA8y0wh1gvExGRmRCOagetvNflFStpvMNJ7RdrIYbiE4QdFf0/07adNlhozZ13raK
         laM7EQ04yu/ta2SlJ0QsqRtRTeqL9UV+1iwhL975QHEztg95Mc8EfhPMr7RiPm56S3Se
         YKp9aVKAc6b4kYD8lRD2jGLUm7GDo+3Xg+60AigFV+sILF2gTeujcymejJokCxieCE/H
         YDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727031407; x=1727636207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgChMCHT6Uj5JKnZ8lcczVs9LXWlZ9vpxnpZvsKF8O0=;
        b=VrAD05B/Bvw4cAo3BfkdX1dzC7C5+Nxa8BAU3hsNUs5wIUVeUbQS50bhXfrxhaLrYE
         Mrih2kXqKSOF+Ynwh+2mvY1SlFRYM0PvZB0pq8QOzyto19QRsVNY4TBBFZ6WFRhlOf/x
         iW0qJWNdVuEVrlRmcWCF7FqBbYRkORDd88g2NzEw9nrBOY4UVinPuNsvvUJTnqXvFpeb
         FweHuq7mxGgWh40OEae6soM3aPZmzeNWpetBy0eE17jwwhRfG3UN9BzK7EmXus3QBZRB
         0IBB1hTGaND8l5AUusJ3Z0Kc4910OaZtBvT6GZKlw2Fm102U2GhP4Ir3T9lBJXrD/ULQ
         GGJw==
X-Gm-Message-State: AOJu0YzFpb8VNvlXzfMOpcI0pSxmp4viE91El2x5xNj/6UFiyckcoY+k
	zRIgN4JtLgj0A88AZkxicm5ddg/Pk4VBKP2tlvaupis0Qmh1xnrs2kvSV3jjuXm7diBkdxvvbZT
	M+SQH5xcmqlk6O6KTiKGHdSqhMS+4t87i
X-Google-Smtp-Source: AGHT+IFxujAF6WckbRzolXCAflOlpjC3dH2hFSP2D3+tk0lMN1cV44FlBCVhegWQSCSpbcfA2FYuTXw7BUjjv2prqPw=
X-Received: by 2002:a17:90b:3890:b0:2d3:bd32:fc7d with SMTP id
 98e67ed59e1d1-2dd7f720695mr12609410a91.39.1727031407300; Sun, 22 Sep 2024
 11:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240823174220.498594-1-denkenz@gmail.com>
In-Reply-To: <20240823174220.498594-1-denkenz@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 22 Sep 2024 13:56:36 -0500
Message-ID: <CAG17S_PDy_WnhEqD0+EG1zoo99+Y4+2xEzZg2Q=7nPA9Tb9TTw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It appears that this patch series no longer applies to the current
git. Is it implemented in iwd or does it need to be refactored to
apply to the current repo?

Keith

On Fri, Aug 23, 2024 at 12:42=E2=80=AFPM Denis Kenzior <denkenz@gmail.com> =
wrote:
>
> This series implements External Auth support on Full MAC cards that do
> not support SAE offload.  I have not been able to test this fully since
> the brcmfmac firmware on the RPi 5 does not actually work properly.
> Maybe some enterprising person can test it on a firmware that does work?
>
> Denis Kenzior (2):
>   netdev: external auth support
>   sae: Allow ability to force Group 19 / Hunt and Peck
>
>  src/netdev.c      | 258 +++++++++++++++++++++++++++++++++++++++++-----
>  src/nl80211util.c |   4 +-
>  src/sae.c         |  20 ++++
>  src/sae.h         |   3 +
>  src/wiphy.c       |  19 ++--
>  5 files changed, 263 insertions(+), 41 deletions(-)
>
> --
> 2.45.2
>
>
