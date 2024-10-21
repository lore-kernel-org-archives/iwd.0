Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00392209B
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537705; cv=none; b=VbwXSnfp2m54h/GLl5VawSvpDJbvUIvK7UQD49uBstAsJ9kn+SJ1u3l6m/i88JA5DaBcBSEczv+LwY7t791lLTMgQzBWVc8TGIDcfktflpn7Ut6kFunpd838FyuUy6qKKBnSPbOKMhC1/DD15VhFJWYwVgkBhoAA35JuZ4Pdafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537705; c=relaxed/simple;
	bh=Jm5IOSS5cAmPyAVvIuDOnAFjXVPvJigLFnTIyZ9DjgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOlkMvfhy8vR2Uk72a796kuPzyPJVfLyh2UPINb5dE7dUzfcFU1bxAGjqQeM4y9qrEpE3a8JiN1eKqGrGgBSP/mMok+x+VI4H2FCohZrUEy/9JJlPIwbiLdW/PCZ59Bc5pdrfcwWLAJ8+rKNcUxBj7QZBKWdOBUvtPqsXF4pOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shapertools.com; spf=pass smtp.mailfrom=shapertools.com; dkim=pass (2048-bit key) header.d=shapertools.com header.i=@shapertools.com header.b=VwV2+trh; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shapertools.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shapertools.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shapertools.com header.i=@shapertools.com header.b="VwV2+trh"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so4951128e87.0
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shapertools.com; s=google; t=1729537702; x=1730142502; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCY7CC5uqtWN2xKx/+j+AHnNJ5kqUQBiKRDyFgU/u1Q=;
        b=VwV2+trhIUyCoHCJb2QPI8uLAlMPQJX3dFTWsnenTa4M6/eH8e9j0pmi5Ivh30gcPf
         rlaalcnrzxA+8wFhrBdfKUs5T6qQpLg074a8tPY5CRui+EuC7fjmcRh5ckUfGl7l132p
         w04dFBg5x7Ti6oeO3Kx9c5vDANdr/xlgQ0D0sVH6mUVOOqtwqn6rFwae6KSCtIzFG4PK
         5fxuN2vCaXbZeD9ivCTXpOCDGI4IQvHdximPhOOewWQo/XdumPp9tb0BcqIiq1yOxboK
         r4gM8301IFC92epIyLoVqVyc7xrbT4tvPy1EgI2u01i8MoNkCGHFAB9HXyog3/MAjtXt
         iUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537702; x=1730142502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCY7CC5uqtWN2xKx/+j+AHnNJ5kqUQBiKRDyFgU/u1Q=;
        b=CSEe7AEHkVJx+DiLNyxWOlVZHb7tDE5V9lTYpGN+3W8JaZDkd44t6qXEGG/XzIUOHg
         L02io8nTwSLw+rUl9sC5ak5mCkcwwHVbDClXXlHlVgUL49+3MTcTGhDiabHpzDCwmWiQ
         Aid/lX2up0EBDE17n80U4AZUYN2MU3bLaA9AEA91HMxfpw4odFmZIBE4AuPy0CUi9qiN
         YbLbVexyVImTGKrbuCCAeDwTqzBp378iNH+ubKRpZ8p6BJjb3Fw8l15TpuOiMk0P9DAq
         XAmJzWto3FAetiDn1+0zbmPI7VoIpOyEzwFKwg7aEY5zlL3E4CeIAsfw7DUlyfeb2DWF
         XxrA==
X-Forwarded-Encrypted: i=1; AJvYcCXNyI93IuvuZfjmLCFj8qjnLRS2WACzYeeuaf2h4S3QesaPt3JcZ+hWuVXhf9rOJQz7P7Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YzPq9cAeTSqrekBofPGKZLpKecGUuBV/yVuIW1bWuPdIMncx85g
	EBmzimTtuXa42SbFwlFZjiQ8xRhvduz37aqtZDh3VPRhupj0qeLfunPBt4NCxv+9jHJPp+bagBS
	h9kQTckwql1c4Wm4aIS3gLRdvZQ7NFlZOPnX2Gw==
X-Google-Smtp-Source: AGHT+IHFU8Pn5gX0kQL7wtJOzrdyZswgcpEbGG35Kuj+A2arI7iVXM1AaAgp45keD8hhlALKRzLGOkdPu1upjbYcsx8=
X-Received: by 2002:a05:6512:3b94:b0:539:fc23:1497 with SMTP id
 2adb3069b0e04-53b139dc1e8mr41660e87.9.1729537701807; Mon, 21 Oct 2024
 12:08:21 -0700 (PDT)
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
 <db8b9660-3e68-4223-aa3e-e3d6a7d18906@gmail.com>
In-Reply-To: <db8b9660-3e68-4223-aa3e-e3d6a7d18906@gmail.com>
From: Jeremy Blum <jeremy@shapertools.com>
Date: Mon, 21 Oct 2024 12:08:03 -0700
Message-ID: <CAE+F7TGrbFG3A2KK1TZkwfiV6mi5p78_THi0w0nTC5OT0Q9Edw@mail.gmail.com>
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Denis Kenzior <denkenz@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, James Prestwood <prestwoj@gmail.com>, 
	Martin Petzold <martin.petzold@tavla.de>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Could try the SolidRun i.MX8M Mini SOM + Eval kit. It uses a 1MW
module (same as the Pi, and based on the CYW43455)
https://www.solid-run.com/embedded-industrial-iot/nxp-i-mx8-family/imx8m-mi=
ni-som/#evaluation-kits


On Mon, Oct 21, 2024 at 11:55=E2=80=AFAM Denis Kenzior <denkenz@gmail.com> =
wrote:
>
> Hi Arend,
> >
> > I have never seen any mention of OWE either. Regarding CMD_EXTERNAL_AUT=
H support
> > I recently posted patches on linux-wireless list as RFT. There has been=
 zero
> > feedback and so I assume also zero interest. In order to use CMD_EXTERN=
AL_AUTH
> > the firmware needs to advertise "sae_ext" in fwcap debugfs file. So if =
Martin
> > can check that, ie:
>
> Any suggestions for hardware I can buy that I can test the upstream kerne=
l on
> easily?  I don't have any brcmfmac devices besides the RPI5 and that uses=
 a
> totally different kernel.
>
> Regards,
> -Denis
>
