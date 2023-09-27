Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F4111AB
	for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 15:56:57 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c1886777d9so14892931fa.0
        for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 08:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695830215; x=1696435015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnwjJvrL36nvKN1XQ9G8SuS+AcJwtvSMqsI/ILDxW3s=;
        b=FVROEPViCb24U/NN2ss4xNNaFcatcG8fg0my4628ixwtJe4Q+8qhdf6sboRi7pnbRD
         pUswOuvWZrJ0DRflKPqMSrDqaRQX4vQ4EaRcUrCIDCd/VEH2XNBkK+KkL4RTmPyDZ8g6
         B532ugdu1tSeNBzJXEZ2TvZkjmb10Z+SgYr/7er6hYtPI4OvH59O+2qZ1oVtvaT7Dmjv
         vXgjRTSaHJ8ZQWpsv+Ic6ayG5OtgndPqTU5aWzQIYJF0wzF8XTxI8nxHePFrEr7u88J6
         giMZqzM1I+J97J3wUPhXBlU4RoSGGT/fs1pVbrLEd1VMSwYBEp7Ve2gxIN1IMfAzSQVr
         GNLg==
X-Gm-Message-State: AOJu0YynbWkmbFoPZJ7B0jeXbO+HteQXHHIPrJ8o1FmqP655SrnVzX9T
	GLnXR5ty6GAQKcjI7oZyVet7ecAKBDNsrg==
X-Google-Smtp-Source: AGHT+IFo0WKVvnatjYqmk2tOcK/cKsjhdxqPdCMDjuzLf4NIX2Vos5GkgzFezGtAOcTLy4jw0+Ps9Q==
X-Received: by 2002:a2e:8808:0:b0:2c0:32a1:71dd with SMTP id x8-20020a2e8808000000b002c032a171ddmr2342984ljh.28.1695830214853;
        Wed, 27 Sep 2023 08:56:54 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id gs10-20020a170906f18a00b009ae40563b7csm9472448ejb.21.2023.09.27.08.56.54
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 08:56:54 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so12756868a12.2
        for <iwd@lists.linux.dev>; Wed, 27 Sep 2023 08:56:54 -0700 (PDT)
X-Received: by 2002:a50:ed87:0:b0:523:3754:a4e1 with SMTP id
 h7-20020a50ed87000000b005233754a4e1mr2378518edr.22.1695830213898; Wed, 27 Sep
 2023 08:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230404203823.384260-1-prestwoj@gmail.com> <1d8a1939-93fe-12b6-5007-e6621dffa7f1@gmail.com>
 <f3259b4c-e8e3-8542-247b-9d6bd0ad00af@gmail.com> <05e63c78-5373-520c-15db-aa42cecd95b0@gmail.com>
 <3855c8ce-c2de-d1f3-e5d8-8c93610e4b22@gmail.com> <5789f7e4-793e-8e42-29d1-1a92696ec2f4@gmail.com>
 <PAXPR01MB921752F18978A3F5A5E53C91F4E8A@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <82109cb9-3264-4b99-a6f7-e3d71da45270@gmail.com> <c69115a4-858b-4602-acf7-f968be707ea4@gmail.com>
 <PAXPR01MB9217D3D30DCE9AB01A000F5AF4EEA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <8ad9aec4-b72a-4838-aff4-cc52e6018dcf@gmail.com> <PAXPR01MB9217F29A004603E62CF9FA2AF4EDA@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
 <1f4a9aaa-6e7f-4f07-9ee3-87599b47eb3e@gmail.com> <CADXxVSJV88op2uJxpY1uW3ruoGvh290__EhXUJpH27DU=7g+ew@mail.gmail.com>
 <631dd09c-94e1-44bd-88a0-32ecd12f8221@gmail.com>
In-Reply-To: <631dd09c-94e1-44bd-88a0-32ecd12f8221@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Wed, 27 Sep 2023 09:56:42 -0600
X-Gmail-Original-Message-ID: <CADXxVSJhjpBk_FcQn_rfK6xB0viR1rRXSiiwr1tSFxi0EYnY_g@mail.gmail.com>
Message-ID: <CADXxVSJhjpBk_FcQn_rfK6xB0viR1rRXSiiwr1tSFxi0EYnY_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID generation
To: Denis Kenzior <denkenz@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>, "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 1:18=E2=80=AFPM Denis Kenzior <denkenz@gmail.com> w=
rote:
>
> Hi Bryce,
>
> > Still having issues with wifi certification around the PMKSA caching.
> > After finally convincing the person at the wifi alliance support
> > person where the spec didn't say PMKSA caching disabled needed to be
> > in open mode I got this back:
>
> Which test spec is being used here?  I assume something like "Wi-Fi CERTI=
FIED
> WPA3 Test Plan v3.4.pdf"?
>

Yes, that was the exact test plan I was referencing as well.

> >
> > "Thank you for sharing the PMKSA_caching information from the IEEE
> > Spec. It appears that it only describes the correct behavior of the
> > DUT with PMKSA caching but does not provide any information about
> > PMKSA caching for WPA3 SAE-H2E.
> >
> > However, according to Security R3 MRD v1.3 (May 2020), PMKSA Caching
> > is mandatory for all devices, which means your device must have the
> > PMKSA caching function. You can find more details in section 6.3.1,
> > 'SAE Hash-to-Element,' of the Security R3 MRD v1.3.pdf document, which
> > can be downloaded from the following link"
> >
> > Those lines are here:
> > 6.3.1 SAE Hash-to-Element
> > =E2=80=A2 Support for the SAE Hash-to-Element (H2E) technique defined i=
n
> > 802.11 REVmd D3.0, including support for Rejected Groups, and back
> > compatibility with the SAE Hunting-and-Pecking technique
> > =E2=96=AA H2E support is required for all mandatory and optional SAE-ba=
sed
> > WPA3 features that are supported by the device
> > o Note: PMKSA Caching is mandatory for all devices; FT-SAE is optional
>
> Indeed.  Funny that the Test Plan above does consider PMKSA optional:
>
> "If the STAUT cannot support PMKSA
> caching when the disconnect is
> triggered on the STAUT, trigger the AP
> to deauthenticate the STAUT."
>
Yes, we went back and forth on that for a couple weeks with me point
that out and the WFA support guy saying it doesn't matter the Auth
Algorithm should be set to 0 in both cases. Then he agreed that it
might be unclear and said well this other spec "Security R3 MRD v1.3
(May 2020)" says it is required now.

> > =E2=80=A2 Support for BSS Membership Selector indication for H2E-only S=
AE, as
> > defined in 802.11 REVmd D3.0
> > =E2=80=A2 New MAC/PHY/Bands shall only support the SAE H2E method.
> >
> > I can provide a copy to the PDF if someone was interested.
> >
>
> I'm not quite sure what benefit there is in supporting PMKSA for WPA3-Per=
sonal.
> Maybe lessening the CPU load on the AP?  The number of messages exchanged=
 will
> be identical if I recall correctly.

I am just learning this now, so might be wrong.  But looks like it
would it then skip the 4 initial SAE initial handshake messages?

>
> > Honestly the wifi alliance has been pretty frustrating to work with
> > and takes 1-3 days to get anything back from them.  Depending on the
> > followup response, for this product it looks like I might have to
> > revert back to wpa_supplicant and deal with some of the issues with
> > using that.  I got spoiled with IWD ease of use (and it seemed to work
> > better in some situations).
> >
> > Products must be getting certificated using IWD right?  Did I just
> > come across the wrong support person?
>
> You're the first I've heard about.  If anyone else is going through the
> certification process, I'd certainly love to hear about it.
>

Me as well, I'd rather not switch back to wpa_supplicant so any
workarounds would be great!

> Regards,
> -Denis

Bryce
