Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A351A0BD0
	for <iwd@lists.linux.dev>; Sun, 26 Oct 2025 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761450073; cv=none; b=KYSzPm2h2bb8qZsir1Hy7rvz11uMXjanvKzgWHr/WOf3YIl2Y8EV8rPYEFGxA/b70RbQsy/HXtFb8ScCwJNUhpBsvXEjGZcVQ5b9bxGHWsELvXTY1INOqg+V62b13P3gqDtaq8wVfyPedfpwloIFnTSsJZxtUu1DOe3Vlrh+rPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761450073; c=relaxed/simple;
	bh=3WEaDI9OUzMI/kAiNWMirRBCVp+czARfNPqNvvPYYfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHk54BdSvj+27Q7OEW4R0mZWyc3elobF+eKjTUdYHC956/+n0Pc8vS9PDLKvNXjoA+zD5x5lRiEH9jx8X0dsxANUXWGv3r+cenwfHSkAaGe27u8pfnZDJQYmH/zfTTOyfCn+S79ifR/sb6V8Oe53a7Iv9PlC5KXdhUDdmwKOZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e06qyb/E; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e06qyb/E"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso615136366b.2
        for <iwd@lists.linux.dev>; Sat, 25 Oct 2025 20:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761450068; x=1762054868; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWY0WNv5wq1RQ80vcBtdtkE1QCNXkT/1n/Se+izBod4=;
        b=e06qyb/ExPjN4bxbgnW8KNcG7RMRLjPjKQx9ggcmgNibBNbS4lhJEuAF4smJhJCvdo
         ZWxaJ7NYP66tWtI7IHIhmI+NMXqSpabQF70mJwtBdjaSU3BDupnf/byI5SKJx7IoVuIe
         h5JPKImamX9OFu05KHXX+Jwhxv+XLRCw/dLvD0bPvY49LSwy+y+8UZF7IpYDFlg/J9Zj
         Li3o87JKVGeFxe8wWbnYttSbh9p247J9sN+ESzRF+TcYh5VYurgu5SIsac0bVRj8hzqq
         bZH+OsCrtL05j2XY64QwHTxQClORy7VIfoXOFe3uIOvkpIErMOIB0/jgA46pinf+Qil1
         JSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761450068; x=1762054868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWY0WNv5wq1RQ80vcBtdtkE1QCNXkT/1n/Se+izBod4=;
        b=TlRctunK+caZahpOwuW1HjsY77WcGDEulvScc+BfST0FBHrqigrwGW36NOxUKc7+ZI
         b5VD4/2HDQhniB1LUwOjaFsh4fmJUVEkP3D7bboJLTlhQ72RsXQieLN+nvUnjapmEk54
         J6pZ1xW9gY4vqp1h6g11kyvJArkPcO/LaKN1BFr3NgLL4i8g9JP1Ov7uFHHT78BdWx64
         gRAgm/6ufGeZeCK9+HxBDyAVxwqcfPDUg3aabDH5Nu9PvFuexW8x8HdIvrC/U7ubeUaq
         bdV2mwvSn1vDgtzyojpgm3YnKWG20J+ngrrF1Lp1mXnw6hMdTYJV9Cvh5dDpOiIsq7Aq
         wpJQ==
X-Gm-Message-State: AOJu0Yw/Icl+8ql9g2DPSjKUmlHIYjRt3IIvLWtOUYcgFthMFErp/4+v
	iHwhEuXICPOqkD9RI5HA/lG32oOo5/09neyJ3xglUGcQ4DuIUL4MGS9pPbG2YOC3bxB9O9ZfKw0
	Od6MSr+tUz2LDrfd0ZIDKEU+JmkBF3Js=
X-Gm-Gg: ASbGncvavtBtjjXVddbeI3k1IASjDj19oPe5KszWw6hjl9jrkyE+nA+6Vrd3nLaFb//
	oXTqdCzf+MMSbMIDYoQhi7c/zhtl7buCmJ+CzUAQWjQ0UYGo4hzr9uxpGVHjv+ixeqr9KoddV7g
	SNX6vct4Pmzx7pK5I5XBoG7uDONOVGRYv0ECgs0/Xq7EcCmG7t/xq37a5l46nefcFWuJVuPzy5Q
	V2Q6DmMzJeM/1awb1Haz9+0k5Gt6AXwxgfA2c0iMq4okcn3ZIjw3TYFEpFtteQxMJ5UDpFkuGwo
	NtUOCpnaNNC6UHVIudGcrns/Uv3gpA==
X-Google-Smtp-Source: AGHT+IH2ELTuYTbknZxJ+bUYW5WJ9oGaxFh5Wf8UNUNBE1MJ82b/S29QVKktuNCIkvJOMdgalWW5esaL9xZLYjbWqbk=
X-Received: by 2002:a17:907:3d87:b0:b3f:b7ca:26c5 with SMTP id
 a640c23a62f3a-b647570a3d9mr3788483966b.59.1761450068197; Sat, 25 Oct 2025
 20:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJNKUtceMPq+Yijythto5YW6a3k3B9oxApve4Pss=g2zAdEKhg@mail.gmail.com>
 <cccd50aa-6a4a-43e4-b0a4-98326d7f14fb@gmail.com>
In-Reply-To: <cccd50aa-6a4a-43e4-b0a4-98326d7f14fb@gmail.com>
From: amit kumar <amit60700@gmail.com>
Date: Sun, 26 Oct 2025 09:10:57 +0530
X-Gm-Features: AWmQ_bmDL4cOCdSINZN8ixxF_9LOP_E_x-I4r5UfyJS4lJO9JL2cqd60jJFy_Dc
Message-ID: <CAJNKUtfMvV73QPGBmUBZGf_Gt_XZHq1wPrK9UXFhmH9Ev=Y4sw@mail.gmail.com>
Subject: Re: Inquiry: Is WPA3-FT Roaming Supported in iwd ver3.9
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev, amitkumar.karwar@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,
Thanks for the response!!

"Cisco Catalyst 9800-L Wireless Controller" router is used for
WPA2/WPA3 FT roaming scenario testing.
It works well with wpa_supplicant when configured with WPA2/WPA3 FT
only configuration.
IWD is also working okay with WPA2 FT only.

As checked in the spec, the IEEE 802.11-2020 standard defines SAE and
FT-SAE as valid AKM suites under RSN.
It allows APs to advertise only 00-0f-ac:9 in RSN IE if they intend to
support WPA3 with Fast Transition only.
Table 9-151=E2=80=94AKM suite selectors from IEEE 802.11-2020 spec doesn't
impose any restrictions on using it as the sole AKM suite in RSN IE.

The standard does not prohibit using 00-0f-ac:9 as the only AKM suite
in the RSN IE.
It allows APs to advertise any supported AKM suite(s), including
FT-SAE alone, provided the STA supports it.

In my opinion, as there is not restriction on WPA2-FT (00-0f-ac:4) to
have WPA2-PSK(00-0f-ac:2)for akm suite selection in wiphy_select_akm()
thus similar to it WPA3-FT (00-0f-ac:9) should be treated
independently.

Regards,
Amit Kumar
On Tue, Sep 23, 2025 at 3:21=E2=80=AFAM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> Hi Amit,
>
> On 9/22/25 2:23 PM, amit kumar wrote:
> > Dear iwd maintainers and community,
> >
> > I=E2=80=99m currently working with iwd version 3.9 and have been evalua=
ting
> > Fast Transition (FT) behavior across different security
> > configurations with standard Cisco AP (It supports FT roaming).
> >
> > In my testing:
> >
> > 1> With "WPA2-FT only" security configuration, connection and roaming
> > works flawlessly =E2=80=94 the device connects and roams as expected.
> > 2> WPA3-SAE also connects without an issue.
> > 3> However, when the AP is configured with "WPA3-FT only" (AKM suite
> > 00-0F-AC:9), iwd fails to connect, logging:
> >          iwd[440]: autoconnect: No suitable BSSes found.
> > 4> With the same AP's config, wpa_supplicant is able to connect and roa=
m.
> >
> > Upon reviewing the source code, I noticed that the AKM suite for FT
> > over SAE (IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256) is not included in the
> > logic that identifies WPA3-Personal networks. After adding the
> > following patch to ie.c, iwd successfully connects to the WPA3-FT AP:
> >
> > ----
> >
> > diff --git a/src/ie.c b/src/ie.c
> > --- a/src/ie.c
> > +++ b/src/ie.c
> > @@ -1338,7 +1338,8 @@ bool ie_rsne_is_wpa3_personal(const struct
> > ie_rsn_info *info)
> >           * 3. an AP should enable AKM suite selector: 00-0F-AC:6
> >           * 5. an AP shall set MFPC to 1, MFPR to 0
> >           */
> > -       if (!(info->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256))
> > +       if (!(info->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256) &&
> > +           !(info->akm_suites & IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256))
> >                  return false;
> >
> >          if (!info->mfpc)
> >
> > ----
> >
> > My query:
> > Does iwd officially support WPA3-FT roaming? If not, is there a
> > specific reason this AKM suite is excluded =E2=80=94 such as spec matur=
ity,
> > roaming logic limitations, or security concerns?
>
> IWD does support WPA3-FT, but based on the spec an AP should never
> advertise only this AKM. It should include plain SAE as well:
>
> 2.2 WPA3-Personal only mode
> 1. An AP shall enable at least AKM suite selector 00-0F-AC:8 in the BSS
>
> This is also in the comment above your diff. I would definitely file a
> bug report with Cisco if you're able to, or ask what the intention of
> this configuration is. It really makes no sense IMO to have _only_ FT,
> i.e. how would you associate initially?
>
> I'm unable to find anything online about "WAP3-FT only" and I also
> checked the settings for the AP vendor we use and there is no such
> "WPA3-FT only" option.
>
> Relaxing this requirement in IWD is of course an option but I suspect
> Cisco is going to have compatibility issues across the board due to this.
>
> Thanks,
>
> James
>
> >
> > Id appreciate any insights into the roadmap or design considerations
> > around WPA3-FT support. Happy to share logs or test results if
> > helpful.
> >
> > Best regards,
> > [Amit Kumar]
> >
