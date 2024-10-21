Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092491E2839
	for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548108; cv=none; b=Q1dmkWpERXdiRN5e3CNF9v+vTd2/1dyAY7wcHdPpbwk6I7EIYtzgrwOTcM0L7iBW/r2dp5ohdcljv7O7BOGUmsi+mnCDgzevLnPk025Eyr9Au2i83gytXAmq9hlcGZesEdGAApA9oYwtE664dwQy2bRB1SX8RGGoQ0+vso+bbqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548108; c=relaxed/simple;
	bh=ZbYrbQ5eCvkzd2ogD/Q3SGeBkBIpYp1WeSTrS0Tgo+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gj1DC0MXqLW46DOhJlh2iBGp4TDMuJNVKAQH6qMovwwC4h/3acATqjf/7sQAQcdiW1WRjr1ZUMe+8QWi5OtQTu71yOYa/xALUBWnDTEjwFi296V1L1AuRs9i21NzC5BQ2V8lv6cV+2LgD1TDD/GyE1NoKxLzwVhtd7JhUxmmLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ7+Md6c; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ7+Md6c"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431695fa98bso24934485e9.3
        for <iwd@lists.linux.dev>; Mon, 21 Oct 2024 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729548105; x=1730152905; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMV8V/+ut0mUDk2Dp0om6xMqsQ0ff+fz/peW7zZMjLY=;
        b=RJ7+Md6cPg3ifzogprvNjbCS0LSLbjgEd3EmE+PsAhy83rHu2HlGPDMGuOtoFADWcG
         XSeS8yEWbr85Nk4dhTBnIzmzPhunPD2eoFpvX8Wz+p6KiAI8VipTY76ZhzogcW71CA1E
         z84bxdyS6ExxOB25wKrJfd+N7Te8zsuH9jZKuMploGhRPPwX5GGwn+9Fc5AFFtFCXrDH
         KmL8yfqdjpbPHTqTp9LafbWopvnZjmjN+ygtvV/x3tcdj7XT+89PyKI89TXs9ocggaq2
         Q66IRPxk+h9Sbkp98qDGpiatMr+cBWgXIUoLr7/9xsbVn2rB7rwnXwHbxXUsYy0GOEYc
         S8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729548105; x=1730152905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMV8V/+ut0mUDk2Dp0om6xMqsQ0ff+fz/peW7zZMjLY=;
        b=C1HCxBGzorYxcoaKalYcv8gMQeiolYmWL/9dUtzQdNsjo0TsR9BrdjFwnFaF7sSqO9
         xVm2zsT8jVtupGM66BO0ApsBQH2SF/cWQH8PFa0ykXxbOgSQWxsz/BHIF3Ej6YH92lxb
         bspEoWt6LkXFlXedVAc6+vbe+jt5qhDxtbWGhFpA2HL9t8KZDLEmgyv0XvmJknNXp/1T
         wJX2LAYNRY3x0yUQK8T7crasS/M2/Gz0xk0PwqhbubAFUVOui8OgC6e4r3s0OtbJY4K6
         bqk3aedzDDdJZNuwCF9/DataD3cJq0okda+Kjjgto+SxCRftLgALHBCEskcbRVK7hzru
         4NHg==
X-Forwarded-Encrypted: i=1; AJvYcCXpQgtrw2ThxCXksEy9uVQoNFs/ws46AgK0oySNNRLNld0UV81oUlNTNYh4eiLN89Vs6do=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2bZQ63mX2HXVDYSzmm5A2rP9zpvg/pmo/6sZ8+AbL8i2QYG4/
	/35X6cNodXz9+adz8Pm5v23EsWC2KhHM0w8GHiXDCmbI6SnLcr3SS4lhFtb35WCeRFbBfbQdgNQ
	5dHXGlgCE1dT/tDxmfrZd6D6swY2F7g==
X-Google-Smtp-Source: AGHT+IHyF6kjlrfxHBiGDPCPRgaCLOFhn0zVa+0rnsn7C+rS1vuQMx1kMJFYjc7l0ZLmYzaMf9Y6we0jhxVomPBttds=
X-Received: by 2002:a05:600c:4e53:b0:42f:7e87:3438 with SMTP id
 5b1f17b1804b1-4316159e08fmr101110555e9.0.1729548105227; Mon, 21 Oct 2024
 15:01:45 -0700 (PDT)
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
In-Reply-To: <c57706f6-2d5c-4e73-bc42-e2b7e4239a78@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 21 Oct 2024 17:01:33 -0500
Message-ID: <CAG17S_Nq1BjYSzSrqMne-6-sO3HK84XEbPf72oh-GM87kd2uJg@mail.gmail.com>
Subject: Re: IWD 1.27 with brcmfmac not working for roaming
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>, 
	Martin Petzold <martin.petzold@tavla.de>, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Arend,

If there is a patch for brcmfmac to use CMD_EXTERNAL_AUTH, I am
interested in testing. The last time we tried, it errored out and did
not work as expected.

If the patch can be applied to the current, RPi 6.6.x kernel, I can
test it on my Pis.

Keith

On Mon, Oct 21, 2024 at 1:26=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 10/21/2024 7:40 PM, Denis Kenzior wrote:
> > Hi Arend,
> >
> >>
> >> I have not seen patches for OWE in brcmfmac. Looking at the supported
> >> ciphers:
> >
> > OWE is an AKM.  It still uses CCMP/CMAC underneath.
>
> My bad. Always confused by those concepts.
>
> >>
> >> Supported Ciphers:
> >>   * WEP40 (00-0f-ac:1)
> >>   * WEP104 (00-0f-ac:5)
> >>   * TKIP (00-0f-ac:2)
> >>   * CCMP-128 (00-0f-ac:4)
> >>   * CMAC (00-0f-ac:6)
> >>
> >> The error message seems to match with the above.
> >
> > I've never seen support for OWE in brcmfmac mentioned.  OWE requires
> > CMD_AUTHENTICATE / CMD_ASSOCIATE (or CMD_EXTERNAL_AUTH) to derive the
> > PMK, so iwd can't support it on FullMAC.
>
> I have never seen any mention of OWE either. Regarding CMD_EXTERNAL_AUTH
> support I recently posted patches on linux-wireless list as RFT. There
> has been zero feedback and so I assume also zero interest. In order to
> use CMD_EXTERNAL_AUTH the firmware needs to advertise "sae_ext" in fwcap
> debugfs file. So if Martin can check that, ie:
>
> $ grep sae_ext /sys/kernel/debug/ieee80211/phy0/fwcap
>
> Regards,
> Arend
>
