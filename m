Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665FB4A1B
	for <iwd@lists.linux.dev>; Sat, 27 Jul 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722102521; cv=none; b=mzzwK0b+JxXhjsNNRRe6VUAWFKUS9cDGTfgaPOjVggZN2aq8778F/X8B2H6cvHOb7L0PIcWWDQaPajmTgXRYoDRveA5Nak5R8XoBtwEPEvkITGAS73pDg/RzuweA/VqvgH4numG6AFcA2FCeaRfNUfz7I5K/vKwwLS02mfRbdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722102521; c=relaxed/simple;
	bh=gacXU/PVwEaR36hnr1b0QTEscSFvPc3ccUGBDcQXqfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxrvPISiJYema5ifUrIWcRoSKZimJJ6Druy3vPAVDp3C1WHbZm1xFsmfJGBcfvWbtJIcJM/dUeeOxrgZ4r4JHkP7xOIph04CXfoMPUmfn70r0pOFtWRpWg01KXjQLR2fRObK3kPWcNP1SOCsvqVK7CpNZSK6NedN4JbbSju1E+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDTCnU8d; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDTCnU8d"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-48ffdfae096so41632137.0
        for <iwd@lists.linux.dev>; Sat, 27 Jul 2024 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722102519; x=1722707319; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5spR2vYHpK1WQOZdbBEuhADJQoLeVFurxjeuAvbVkVg=;
        b=QDTCnU8d/Z+3kV3m00ODnCCn2pG3DV60d2lNpYRVK6AsPB5KQCLjfz9IM8tzJu/M+e
         /Vjr9rVMzB08QFZa1+QEoOSbZQqUbAwF83Wz73/WytQVr9tIOUPiUjnPHltGDLzYbZKG
         BLf5khRsLVEVeg1/xHGOHj2MYsZrbLdJ5fypX151YBmo70oRR59AL+o3M9uLT68lqgoy
         Uf0XRO72aUdc4dZTKOwvdtV6vd0tf7lh872T897Tfy5UUlDOyf8Wm1ZzwUmQxmhxRXtn
         5/7nafBpfxR/fmYKs7yYH2TBFunpEuPaBHabzrZkUUzwvmGi+KHDFiX71HnanlV0WupJ
         CDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722102519; x=1722707319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5spR2vYHpK1WQOZdbBEuhADJQoLeVFurxjeuAvbVkVg=;
        b=xH9qYhNMO2rPxFI4L7Ig0B6GOKtgGAsk8/aBzLGBXKplT5Y+7XJU5xE5W8UByFf1tx
         RZSvP1hBPlpOTG5vZYoqx5UjkYYD3RTM+lOwCZoJTvOadrXAxfX0mWIWljJBGkuvo7ft
         8MqCAPbeGNy4Dfti+Pofi2plthK8ZSrRt1hsYHSS4rTsvs2FXxd5xCVAR73vh5VotBKG
         gEHuVB2bATc03LAzT22Dz9B6VIDNUzse43kBNDxfHFvipJM/s7tPmLbGyr7zwdojl9Ho
         NfiOGBXy7WQ/r/PVo//1n+zfV2ATZUcRFxARY1zi1fTZk+0deyGZ2KB61q6c6PmNuFb9
         Vt0g==
X-Gm-Message-State: AOJu0Yx7PGkTV/YksKWZoQQ+094A3Z/neigiu+KrhwWk998LX+ep92FE
	LuA97YVRyYcaQec8e3A4R78NzOVtUGnuYYf4Rk9TF1A55KIchz0Z0vVtmUbsb7WxZaNIiT31mx3
	2YcOrPLv7YSdqFcoxT9GhWIWMIA4=
X-Google-Smtp-Source: AGHT+IHGbJR+l20EOCXfyNGnLq00O9docPzK+T82bpmOvrPv5U1xdLykfyvrTNcqvb99cnHKcgTNL4F709jR4XjXCLs=
X-Received: by 2002:a05:6102:b11:b0:492:aa19:dcf9 with SMTP id
 ada2fe7eead31-493fa62358dmr2514381137.6.1722102519153; Sat, 27 Jul 2024
 10:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzC0yNsPu3chJj-aRA6=7Yyur_sspoKtO_SpjqA4xPsgGQ@mail.gmail.com>
 <5ecaa615-2aa5-4594-bb67-a400a7e957b7@gmail.com>
In-Reply-To: <5ecaa615-2aa5-4594-bb67-a400a7e957b7@gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Sat, 27 Jul 2024 19:48:28 +0200
Message-ID: <CA+iibzAhCHfT_OjV+DdVwaMMG5Z6=xoYhjdD+6=FLELmLF5ZNg@mail.gmail.com>
Subject: Re: compilation error in iwd with ell commint 883bc6a90b4a9c654fdf2540f02447a7ca567e04
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Denis

I have installed the three patches and the compilation is OK and it work's

Thanks a lot

Best regards

Daniel


Le sam. 27 juil. 2024 =C3=A0 17:47, Denis Kenzior <denkenz@gmail.com> a =C3=
=A9crit :
>
> Hi Daniel,
>
> On 7/27/24 7:25 AM, daniel antoine wrote:
> > Hi James Hi Denis
> >
> > I compile iwd with ell include in the same Pkgfile
> >
>
> Applying the following patchset should fix it:
>
> https://patchwork.kernel.org/project/iwd/list/?series=3D874190
>
> I should have held off the ell push until Monday.  Oh well.
>
> Regards,
> -Denis
