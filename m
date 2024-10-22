Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7D1BC085
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615112; cv=none; b=IbKyVaSdmBmGmjGvnr1lr/autdghjkSpZUtYuUta9L/sw3Va01JyXSmewP71/45KKmfTb8d32/4BZTvQttxMqAzrb0vWJMl/Jznn/zWSmNuvXfdaLcY+ytpfMapAAuT67IecuMcnamKvVNzCoUNxgpxDk3Qdcm8AciiBBlbeRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615112; c=relaxed/simple;
	bh=l0NpfJIPeocdbprcMbw7LSa3qAwEBqQ7k0hSbHqe/0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0AqazPw8y73l3r5mdjF2Ky6FncnIbhCDAkmre0QsBuyWnVZ2l210rG992d/Ohuuh2sh8n3rgnHGw5Z4BNyu4erilSNJ5kO0M+9AuEJua4Rktb03IK7HlBFn5OYIJ9YJu3DfcADN7l9UhgqnAouoRWfzyeK6KbaWYod9s5pFGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shapertools.com; spf=pass smtp.mailfrom=shapertools.com; dkim=pass (2048-bit key) header.d=shapertools.com header.i=@shapertools.com header.b=SRWW6+QI; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shapertools.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shapertools.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shapertools.com header.i=@shapertools.com header.b="SRWW6+QI"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb599aac99so58367401fa.1
        for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shapertools.com; s=google; t=1729615108; x=1730219908; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaavQWq01qVxfk1T4m2KpHiKp0fCj8OVyQCo+FLazfI=;
        b=SRWW6+QIT0cEU3ZmkBc8teM8WEUz5le9ZK6QVJALJ+jhaZ2q7rdi0UopgJ2Mx5In9Q
         hrgW/Bhf1/uuKnpLY1gU/6ktgUA4duW5ZZLVfJJaHr1zp1nL0PsX9i3kHkJDUo85QsAz
         17BRZ97qf2mpNcS1VRRsE+h74CEAEu2J2svULN+FlgyPLIsS0yYR0xmTh0mqMeTqXcHe
         1YoQ58hcVJmylG6IUtgJ9Wii4iGsLVV+esqDPHamUr7ogVGkuZegj9PmtPMfyY9lyHKS
         Pz+eLZfpeXCYWhVqwzxFYLNQLdo+NlLFN+xMcaHQuXjXEZ1QSGy6noc4Yn1P1D6eX3LT
         9y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615108; x=1730219908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaavQWq01qVxfk1T4m2KpHiKp0fCj8OVyQCo+FLazfI=;
        b=W8MAQ/wfudJDuA0N9wldvfuGQaxAMo2713n2YCDfCoJZl+uH8h8C9r8r6pWHM2/yc0
         9NDrCamskmyW5iihSi1Nyn6dRdVpHv6VF3iGifvHbFJHhHw4xCgBR+yR/7l0aeDqFq6i
         FX2ebL0DttVDQhxEd29D63UItBwHUmNI97Ag3vBBHaCbwgveouXoVsmxWiMp1yVlS/uM
         P4UzWXorQ0bPGKE9b6F0x0QcLDuptaDjI1Q80vTNhEk9l160fpP6tNFRddK/sE/v/jm2
         52WBBj2IGDwSfm+frg3rYsXn/bEYwbPeQr0bb83VZYa6BLrJzHB+r+fxH0KE/pflT62x
         ahGg==
X-Forwarded-Encrypted: i=1; AJvYcCVrwQ4hNNiUPHXAP4Lx2CCtl/xJLij4Ht0bhx9rpAdE26QTxrcIjUiMT4lly3jXV85fH6A=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3zG0aS6r7ohfqQhzZqcjOKLdLOH9W8anYp1tgT3OK7NrLOH3L
	Dbc8CmjQX8HHvGKJUZ1gEkdw8TiEq42VK/iRbU1zom351pjAv2bBdPLik3mZaTLGUSGXVI81i4S
	vFst3RJCmVwom4D9uhAiQAB8Rolg8UTyCw66cVQ==
X-Google-Smtp-Source: AGHT+IH5ZbGy4T4qYlV/oRF8xgNOmNCYR6G7iC9a8y2VH/pApFPWr1RihC+NOJj77co8TgywU9IfgcCTOrEfD2krPIA=
X-Received: by 2002:a05:6512:10c4:b0:536:55cf:3148 with SMTP id
 2adb3069b0e04-53b1921fe54mr92974e87.31.1729615108448; Tue, 22 Oct 2024
 09:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a99e0ef1-8f97-4c1d-9aa5-5a07c87782a5@tavla.de>
 <d91f33df-e9d7-430a-b1ca-13cd1dee973a@gmail.com> <c5e790a5-2854-47a6-9431-e02a0f9e6676@tavla.de>
 <5efc11fc-9c21-44a0-b282-5d41bfb96a8c@gmail.com> <f496ad63-e2a6-46cb-b7d6-1a084523c7d9@broadcom.com>
 <1761198e-9f41-4e5a-b2b9-a1652732346d@gmail.com> <6898cd84-c7b9-4fa0-aeb5-c7a90d81b58b@tavla.de>
 <b0afc4f1-6496-48a4-a11c-789ee08368e4@tavla.de> <5a128900-432f-439e-9008-3b303ee72eb1@gmail.com>
 <2dacc589-9927-40f7-85ed-5f6b2afbbd41@tavla.de> <192af85f1e0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <2ab8601e-1601-4d4f-b58d-e9f23877650f@gmail.com> <192b00cf460.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <54a62c50-5c9b-47c6-b8ab-f7369381fdf9@gmail.com> <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
 <db8b9660-3e68-4223-aa3e-e3d6a7d18906@gmail.com> <CAE+F7TGrbFG3A2KK1TZkwfiV6mi5p78_THi0w0nTC5OT0Q9Edw@mail.gmail.com>
 <e5f30105-bf69-46f3-99aa-498d3f579c06@gmail.com>
In-Reply-To: <e5f30105-bf69-46f3-99aa-498d3f579c06@gmail.com>
From: Jeremy Blum <jeremy@shapertools.com>
Date: Tue, 22 Oct 2024 09:38:10 -0700
Message-ID: <CAE+F7TEyN5mYDU9KydfdYrfcU_Cn=o2Lh_gLMjzp2ccX=F5Vgw@mail.gmail.com>
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Denis Kenzior <denkenz@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, James Prestwood <prestwoj@gmail.com>, 
	Martin Petzold <martin.petzold@tavla.de>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mmmm, guess not: https://github.com/SolidRun/linux-stable/tree/linux-5.4.y-=
imx8
Looks like it is based on the NXP BSP. Same would go for the NXP or
Variscite eval platforms.  To my knowledge, the i.MX8M series is not
yet fully supported in a vanilla upstream kernel.

At least for the Murata 1MW module (CYW43455 chipset), I believe its
largest use has been with the i.MX8M Mini/Nano, and on the Raspberry
Pi boards, all of which are going to have customized BSPs.


On Tue, Oct 22, 2024 at 8:26=E2=80=AFAM Denis Kenzior <denkenz@gmail.com> w=
rote:
>
> H Jeremy,
>
> On 10/21/24 2:08 PM, Jeremy Blum wrote:
> > Could try the SolidRun i.MX8M Mini SOM + Eval kit. It uses a 1MW
> > module (same as the Pi, and based on the CYW43455)
> > https://www.solid-run.com/embedded-industrial-iot/nxp-i-mx8-family/imx8=
m-mini-som/#evaluation-kits
> >
>
> And this runs an upstream kernel?
>
> Regards,
> -Denis
>
