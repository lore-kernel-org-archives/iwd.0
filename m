Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B923161
	for <iwd@lists.linux.dev>; Sat, 24 Aug 2024 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724459944; cv=none; b=kDrDgLG/CBPATGokm6XctgrXkMJ6EGXqR+2DN6aZzucM2rkKTAYKaErjykS34UAoAi8lhNAMBiK0SG7MVgluQw5gs4BtU9NnVl8QyK7EWZNGdUkYhEc63umYzhImRw08I85hLPYBQK33nrbMgCzwriLDOzxAMOc4OGjSU4KS7Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724459944; c=relaxed/simple;
	bh=1pA/4Qvk+rPmt50nccwgK5B0jTiJ0gzFCBQ9cCyHmgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9lWWBcN6y/ru3PKOoJu8e/xFFLsaR9hRM/bhw/HRyWwsemVgmx+LmXGu6RPLOJnPsb7A2uzPHPTY0Dy4lXNpsCJxoC8FbEppvbka/wjNhlzc1rUdXAejoGezqoVfRGwg/kcBBy7K631J1uoehw6vsqo57NaKwYWeRPqoGCLSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JduP9p1r; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JduP9p1r"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd895682fcso1037407a12.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 17:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724459942; x=1725064742; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZRioy5vmROrbI42J4/dMWyDU9xLDCEp4z8dEMEnCLw=;
        b=JduP9p1rMAF6KPvsU4UU5NTs6uOutKdcSCnZqbfDdpZw3IbkVMD3FCG4QNAT+FY6VM
         0AIU74rWrH9ieVsOqcA7JmD6s2gi3LjglzG7R2aKVAUw1c/MxPyO9It8MbGnwalzDarn
         g99n7OaAffpof8c435saL/zNvQDS1dxbHtlfOy/aBsakE6+YR87nUzyr1RoivNvc6wCX
         22wujzn9fsvOIv+IC7L8KVNnHJH0cmafLduziQ0HogjE5l9MQ08q20ZMTjnUc/LgS5xI
         XVuDwfK75yjdCtoUyWvKzN2ninT60nKdWzrsIdAnaUJTKyA9+3dIXbwLehp0It71Imf/
         MHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724459942; x=1725064742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZRioy5vmROrbI42J4/dMWyDU9xLDCEp4z8dEMEnCLw=;
        b=R28HRsqhKjkEfIK+9Tu5diYZ0rybTK1DPcA/kX+CMnxIbbVIxZdKzAhdTGAZ8mHAQY
         cGOC+vGRnF9e3jV3qYHZJJkxreG5kR5GafvmfqnoFTu0bHEEhsBqz/WFRKRszlSb6Pre
         qcX7Mf/1iEbnDGyOuFogqAQXEWYtNCGG0ohJDtbGv3wd3pfZS1Bxa4LKFuDr7dD9tebF
         TNxfCl1YPI/FTSPhu8Y25LMiNqRYst9uzcn6FSR6WcNkAb+avOmaTJ/1exR7LRFx7pUy
         WKEvIn8Lcj/frJprBnDYgbHTsdFVaQ4EeXqk93gyhvahV8aP+kJR3MaZNIXTwG8xnICO
         ra/g==
X-Gm-Message-State: AOJu0YxsTSzcLT56296J1H/PGKxRP9/Yrty6jc+PrnTLIsMogwIq/MD6
	KaR7wz020mE2DOam7CqNcIoy9Z5gysw2pVi/o7i0wzUlsr5zikODr7t3Bs+34BeP+b24wnR3DYs
	aYNkCRj1lLDm0JKhx06OI/HHZsrw=
X-Google-Smtp-Source: AGHT+IHzNp9eZHtNo5erIV+BOFphz7jtNXPpzlAb6k3T2KqDlHrfyAE1gJ0Jvc+4oc9ggQC9bfqWTU3qF3RSKXKxpv4=
X-Received: by 2002:a05:6a20:d98:b0:1bd:2a8d:e25d with SMTP id
 adf61e73a8af0-1cc8b5c6c65mr4327734637.47.1724459941927; Fri, 23 Aug 2024
 17:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240823174220.498594-1-denkenz@gmail.com>
In-Reply-To: <20240823174220.498594-1-denkenz@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 23 Aug 2024 19:38:50 -0500
Message-ID: <CAG17S_NjMwU4=qn_jJzUJwPEOTT1H-SPVb7Re0P4fyPNUg=WqA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Denis,


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
I was watching for this. I built iwd from git and tried it on my Pi5.
As you said, it did not work:

Aug 23 19:24:29 pi5 iwd[16297]: SAE unsupported: brcmfmac needs
CMD_EXTERNAL_AUTH for SAE
Aug 23 19:24:29 pi5 iwd[16297]: src/wiphy.c:wiphy_select_akm() Can't
use SAE, trying WPA2
Aug 23 19:24:32 pi5 iwd[16297]: src/agent.c:agent_disconnect() agent
:1.471 disconnected
Aug 23 19:24:32 pi5 iwd[16297]: src/agent.c:agent_free() agent free
0x5555946ddaf0

I believe this is the latest firmware from Infineon for the RPi fmac cards:
Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265
(28bca26 CY) FWID 01-b677b91b
Firmware: BCM43430/1 wl0: Jun 14 2023 07:27:45 version 7.45.96.s1
(gf031a129) FWID 01-70bd2af7 es7

I know there are a number of fmac cards. Does the firmware on these
work differently to other brcmfmac cards? Do all of them use
CMD_EXTERNAL_AUTH?

Keith
