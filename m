Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C297479
	for <iwd@lists.linux.dev>; Tue, 26 Sep 2023 15:16:39 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-503065c4b25so14390188e87.1
        for <iwd@lists.linux.dev>; Tue, 26 Sep 2023 08:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695741397; x=1696346197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChaoI4KmMxYC59qE/db5nK7zz+R7guyC+IiwGsVZkuY=;
        b=C4TrnCBNzQf6AKjOQ+EnwOVWeki3X/NUMzr36BgZ8Hqu7HKo0XTigVxMMrIRcpcv8U
         pjXZcqw2fUtyy3iHNEhSWVOe8w/QJjFIucW2gekmRWrIHcBs7v+w4PjXcpLfiYv0ZF37
         jldPQkjoJJwLEOMPi7LkAN03O33REZ3bBBTM+p7izaDQBKayZK6/0Co7m/F5nNEOfCHI
         Q59Ac766FC+RzkMD7cM22mgxWQSVkQKQZbNbOQbJ7eESXe5bmtvQ0xCNTas5kpqeewQw
         xhDHYSsmTLZcWWWpufKw+l7ra1cmIrCkOLDL0eiNAym3EvY/y+/23EPkM7nJUa7E42NU
         OMiw==
X-Gm-Message-State: AOJu0YwA3gaV1yxcKFe9milPl2qgCwinB2pJky+luCapEMV2RglPZ9y2
	8qfHH34O6e48jwhta/LUBIGLhWKE8Yg=
X-Google-Smtp-Source: AGHT+IFkihZyqNY26tKliqPiHh1BZHeQbmYqh+VdvUrZsh2+Th9ytq3aLoZ2Pl3jgcpbq60Y2J5Fgw==
X-Received: by 2002:a19:6746:0:b0:503:35bb:1e74 with SMTP id e6-20020a196746000000b0050335bb1e74mr8405660lfj.61.1695741396624;
        Tue, 26 Sep 2023 08:16:36 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512096200b00502e2347ef0sm2219287lft.193.2023.09.26.08.16.35
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 08:16:35 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so152383291fa.2
        for <iwd@lists.linux.dev>; Tue, 26 Sep 2023 08:16:35 -0700 (PDT)
X-Received: by 2002:a2e:97c8:0:b0:2bc:e954:4203 with SMTP id
 m8-20020a2e97c8000000b002bce9544203mr8358423ljj.26.1695741395639; Tue, 26 Sep
 2023 08:16:35 -0700 (PDT)
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
 <1f4a9aaa-6e7f-4f07-9ee3-87599b47eb3e@gmail.com>
In-Reply-To: <1f4a9aaa-6e7f-4f07-9ee3-87599b47eb3e@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Tue, 26 Sep 2023 09:16:23 -0600
X-Gmail-Original-Message-ID: <CADXxVSJV88op2uJxpY1uW3ruoGvh290__EhXUJpH27DU=7g+ew@mail.gmail.com>
Message-ID: <CADXxVSJV88op2uJxpY1uW3ruoGvh290__EhXUJpH27DU=7g+ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] handshake: include additional sha256 AKMs for PMKID generation
To: James Prestwood <prestwoj@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>, "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James and all,
Switched to my gmail account that works with the mailing list better...

> >
> >> Yes without PMKSA support the client device/IWD will never "reassociat=
e"
> >> after being deauthenticated so your right checking for the auth alg =
=3D=3D 0
> >> is not correct.
> >>
> >> After being disconnected IWD will do a full initial association, which
> >> for SAE means auth alg =3D=3D 4.
> >
> > Just looking through the wireshark logs, just to double check you mean =
the Authentication Algorithm in the Authentication message (0x000b).  I am =
seeing that as Authentication Algorithm: Simultaneous Authentication of Equ=
als (SAE) (3)  (0x03 00).  So Auth Alg of 3?  Or am I referencing the wrong=
 thing?
>
> Yes sorry SAE is 3, I was mixing up what the kernel's enum value for SAE =
is.
>

Still having issues with wifi certification around the PMKSA caching.
After finally convincing the person at the wifi alliance support
person where the spec didn't say PMKSA caching disabled needed to be
in open mode I got this back:

"Thank you for sharing the PMKSA_caching information from the IEEE
Spec. It appears that it only describes the correct behavior of the
DUT with PMKSA caching but does not provide any information about
PMKSA caching for WPA3 SAE-H2E.

However, according to Security R3 MRD v1.3 (May 2020), PMKSA Caching
is mandatory for all devices, which means your device must have the
PMKSA caching function. You can find more details in section 6.3.1,
'SAE Hash-to-Element,' of the Security R3 MRD v1.3.pdf document, which
can be downloaded from the following link"

Those lines are here:
6.3.1 SAE Hash-to-Element
=E2=80=A2 Support for the SAE Hash-to-Element (H2E) technique defined in
802.11 REVmd D3.0, including support for Rejected Groups, and back
compatibility with the SAE Hunting-and-Pecking technique
=E2=96=AA H2E support is required for all mandatory and optional SAE-based
WPA3 features that are supported by the device
o Note: PMKSA Caching is mandatory for all devices; FT-SAE is optional
=E2=80=A2 Support for BSS Membership Selector indication for H2E-only SAE, =
as
defined in 802.11 REVmd D3.0
=E2=80=A2 New MAC/PHY/Bands shall only support the SAE H2E method.

I can provide a copy to the PDF if someone was interested.

Honestly the wifi alliance has been pretty frustrating to work with
and takes 1-3 days to get anything back from them.  Depending on the
followup response, for this product it looks like I might have to
revert back to wpa_supplicant and deal with some of the issues with
using that.  I got spoiled with IWD ease of use (and it seemed to work
better in some situations).

Products must be getting certificated using IWD right?  Did I just
come across the wrong support person?

Bryce
