Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1324519CC3A
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 04:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745382852; cv=none; b=RQHIMrMsKblTApRLSVfuo2z0dmB2BpqVRd5LcNcRJbay0T+t3qhXr1IRcus7XGXUtPLIv35mIvE9sVRriF2TVAIM7F1YHDrx5goiGVlGfIxPpP8Z6wkB4pmfrRgv30dG3RXQZ/6gjYuSMKXjdl3hpd6sT3Trc/deI1B+a47Ge1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745382852; c=relaxed/simple;
	bh=UaGCM0GgrAzUeUHu8AdOh0/zRjNowy9pZRyWb8DjCaE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CcOEp7k8N52umQVjrMYUkBXXEspnUjIX7kZmsvtf76APPwuIZ2/xTDS7ZD9gvcWlIaB3rULMu3Sh8cfu+PLb87erchdLkNSRYUInvLRblfHalslvrmBYo/bd9UHWtlToamGRqYGcxkKi9+LgAcGAl3sz2MD8XnYnBrcQF1YeQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jydsEDS8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jydsEDS8"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso1002208566b.0
        for <iwd@lists.linux.dev>; Tue, 22 Apr 2025 21:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745382848; x=1745987648; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cb2xu4zTgO2rNR2JjOHBLXGgc+h7DkAiKOELN2qSMZc=;
        b=jydsEDS8IckUv8tyNo5Agrw0cuMdfobeNXXLJU99D1L9FcgymnkHgkrxo8Jz4tn99D
         4MF3i8DhksTUKiBFSJuJFrNrTMpNfL+qKFLo7DTslBf1NDdoftHZBmMEnpP9vWxtRSbl
         ywpQmdjUMF4WzJUmZvQd2lwVm8LUrGDGXd/KUuUTD0BeIILyoJ1YVt+8W4dxXIV9BdK9
         faHg6W6k1GvohZpih9o2hfB750TBq+hM5k7k7QHM55Ss7faF2xljgnkOER/Ss1opx1Jf
         vYZ6GPlxnANuqC+lGr2beiVGDfp/fN7ZKl0S/o5gc7SVaD4yrD+VrMo/GxJ4se3d6DLo
         2Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745382848; x=1745987648;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cb2xu4zTgO2rNR2JjOHBLXGgc+h7DkAiKOELN2qSMZc=;
        b=tcFvOBXYcm18u02NhRUM/UF6RYQi1dFUYBK6M4/nuNdoOtUQzg3HPV9hHFPaHL5k/T
         d96EoSCm/hvfLpi+K0EeNtzqZYWHZXzw7bMqWAyNPst26+ZqpSHvECyIeUnuKTMLHw0H
         ofHRccHU92h8qfvl+3US303tHWCZigzltZvzDqBFkYd1tGJ8PbcKekEsdEecHanZ/0Xw
         hX99tbpGlJMTqMbFSipuZWiicIP1oozUiPO1WRpU67aogMyj0ru+3plTqcQ0I6ZwxJ9Z
         hCEfFXp0vfTXxN+nXC1K91f4aKEsqy8h5xGbcjTeuz2BQi1J3swMSHVDRf+RulQ1KHSj
         G+qQ==
X-Gm-Message-State: AOJu0Yy3Hr3xqy5RKpf3rUQt/iN82IOK2WAY8gHcUOohCEPJWnqfxaj7
	1wMaMsrAuWpHmsHv5ST7u0xMXw7iWGx6bpyfqeRogO8YlEi+85MNYVla5hJsMypZSopkYVTeCIh
	/s3K2n541Of/subZK52agbW/qOMjb2pYe
X-Gm-Gg: ASbGncs+eDXtI19qvo8jFN2nxb6Zo/q5l4aLfPU4Fp8TUO73//xvQtyiVUtbOvDdSRd
	Lfvth8Ca50KQVnH97ed1HCMJCP0mu17bRlKIh2pW2WU1yucJh+reSEznuD3Z5KCkmw3KEv0ER3v
	/NScaJEqJOgFvCaiWH80nG6V6SH0i2/hu1mj2RAeIo8imW9cWsTSOmikuX
X-Google-Smtp-Source: AGHT+IF2pMJE65FHh7ZeQPTszcrbuY77bw/CtCrL88/4l5a2LojjhIHWBA1PL8D9L4wFOo0A+3shMTxOxbEHwZELIrg=
X-Received: by 2002:a17:907:1c18:b0:aca:c3b6:ffb5 with SMTP id
 a640c23a62f3a-acb74e09dc7mr1620205466b.49.1745382847847; Tue, 22 Apr 2025
 21:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Donald <sirspudd@gmail.com>
Date: Tue, 22 Apr 2025 21:33:56 -0700
X-Gm-Features: ATxdqUEZ5nCAPDDfwwGrXgflHg9lJgdvw_WwNMXOyMJ8glL_vdVxC1HUCtQALik
Message-ID: <CAOVeLGSPJneA66x_3Ov6HRs9YoUcY0bauH7qe+pLDs0qWpBLkg@mail.gmail.com>
Subject: wl18xx: iwd needs to be restarted before (a particular) AP appears
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Top of the morning,

I am seeing a quirk against wl18xx, where the first time iwd is
launched it fails to see certain APs and produces:

Received error during CMD_TRIGGER_SCAN: Invalid argument (22)

on relaunch of iwd, this CMD_TRIGGER_SCAN error does not manifest and
the AP in question is visible. Some APs are visible, but not the one
we happen to be interested in.

I see a bug from the distant past which alludes to this:

https://lore.kernel.org/all/f4d9e6cf-f7e4-49b9-adbf-92dbc006812a@gmail.com/=
T/#m6fd56354e1cdb32233adcce414bd8ff098c011da

and which demonstrates the same error message/symptoms. but adding:

[DriverQuirks]
DefaultInterface=3Dwl18xx

to main.conf does not change the outcome.

I am running:

commit 7d5bcd738bb92cd33756985ffd2c4c67452a7f85 (tag: 3.6,
origin/master, origin/HEAD)
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Wed Apr 2 15:05:43 2025 +0200

    Release 3.6

against:

commit c5e32b0a3c19f6cf40241e323e02dff00810406e (tag: v6.13.5)
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu Feb 27 04:34:22 2025 -0800

    Linux 6.13.5

The only solution I have found which consistently works is to run:

timeout 1 /usr/libexec/iwd &> /dev/null

exec /usr/libexec/iwd

in my systemd service, which consistently works.

It warrants mentioning that:

iwctl station wlan0 scan && iwctl station wlan0 get-networks

does not show the desired AP on first run of the restarted iwd daemon,
but when running this a second time I can see/connect.

So start iwd, restart iwd, scan, scan, get-networks - success

Yours sincerely,
Donald

--=20
-------------------------------
 =C2=B0v=C2=B0  Donald Carr
/(_)\ Chaos Reins
^ ^   http://chaos-reins.com/
