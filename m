Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A38229B2
	for <iwd@lists.linux.dev>; Tue,  6 Dec 2022 12:39:16 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3cbdd6c00adso150045387b3.11
        for <iwd@lists.linux.dev>; Tue, 06 Dec 2022 04:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bS62eYFh/ACNOibMlacavrUsrz4M4veTPUSocR80YN8=;
        b=DO+bjrxsWWoKqIfvIMZbTE6x7XWKxnEuUJCRCDR50EE7/RC5Avm/KjtW3QtxDYZ9W7
         mku6HpA4H0eWhLbNxnjQn83ZOEwEXzgo50kytGz/4pXlaE/IZ3DQffT1xs3kxHGk+ZTz
         5HCitP6s5p7Zh4pRYL4ry9POx7QYdO8tR+7GN+UPiVRjCQlXl530Mruj+PIJn3zfB2NT
         3tFsIKLhQuTBRP2CypnC9V0OXV3CKPOe4prKf0ED4m7unHqDGvefgjt/WgIX6yLStG8y
         NBHuoveYWyUzjKLa8XTuE7Nu24+Y1iREw4EpoLgM70ivYW0UdZ2UsPXHhna7zF+MFamB
         Nj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bS62eYFh/ACNOibMlacavrUsrz4M4veTPUSocR80YN8=;
        b=doK+gklQ0+Cj8Y9MHh0kRkIuaqs9yfZAiRkC6bnvhav43wtotzxxwdmLfYEUpjfFgr
         I/c5c3kL/aqboXdZVHrOPTaWUcUCm8t89K07R6QjTjQTDC2bP3rLe4SgyKeh0akp7UGd
         ffYvzL7q9YWk11H02B4eZ+9WEY/9yjkB8AynRBBqusYInafJGqwwwTVy1q29nt4oQ3E3
         La5EmdQXabtV9n0Uz7Z7c9YdGy6yfCLWKrMsQ0jEPfJgt1omCk6Y3VUN1KaaT1BK5QvJ
         s/XkP/IB9BWehv+eDwdZ217JsKoAc+WlmrEN1fEp33tLD+E65V/gxhrWp2t6ttav9ZwT
         fkWA==
X-Gm-Message-State: ANoB5pljVAYGLg4h/jq4WJEhrydodXw7pA82J6+TcXrV2UT1bcWBWkSo
	w+FU2HgNbUEARKfiXJgwLzA5p6bSCKJNTDi8+LU5pQl4hWM=
X-Google-Smtp-Source: AA0mqf7sWJL2cOXgk2BiZ//IEsys3Bbrcra8ozfw6YOaRJHTK0XlZ4GPZp37T/Jo0tXINoq7E7k3G7hnGHv8iyo2sx8=
X-Received: by 2002:a81:65c1:0:b0:376:f7e2:4b12 with SMTP id
 z184-20020a8165c1000000b00376f7e24b12mr64355979ywb.0.1670330355109; Tue, 06
 Dec 2022 04:39:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACvgo51HZVDcmvHiaZK3XFJyp6LUGRFEM+G=5j1--av=XWni+w@mail.gmail.com>
 <d2df3b8c-2b0e-b587-bd04-4892e4e84f5c@gmail.com> <CACvgo53tii9sLJFcmsPymJ-8HBZjvwpuBR4DNKYLNVdoGFY3_Q@mail.gmail.com>
 <37ab408f-c9e6-7e9b-0088-d7e5fed08241@gmail.com>
In-Reply-To: <37ab408f-c9e6-7e9b-0088-d7e5fed08241@gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 6 Dec 2022 12:39:03 +0000
Message-ID: <CACvgo50MYLmr4HKH_Haue5b_k2-2eagDUhy=-bv_2hn6WciPZw@mail.gmail.com>
Subject: Re: WPA3 SAE passphrase limitation
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Greetings Denis,

On Mon, 5 Dec 2022 at 18:48, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Emil,

(snip)
>
> Right.  8-63 actually and it is mandated by 802.11.  The worst part is that for
> some reason they mandated ASCII only as well.
>
> In WPA2 the passphrase is only used to generate the PSK.  Hence 802.11 refers to
> it as passphrase -> psk 'mapping'.
>
> > On the other hand I can use a passphrase outside of that range with
> > WPA3 only routers.
>
> This doesn't apply for WPA3 since the passphrase is used directly.  No need to
> generate the PSK.
>
Thank you for the much needed crash course, it's deeply appreciated.

(snip)
> >
> > Whenever I try to use short passphrases ("testing", "foobar" or
> > "foo123") with a WPA3 only network, IWD fails to connect as mentioned
> > earlier. I don't have the spec to confirm, but this sounds like a bug.
>
> Just a design decision.  When we started WPA3 was still rather uncommon and
> hybrid networks were (and probably still are) typical.  Since you want to roam
> between WPA3/WPA2 access points, enforcing the same passphrase requirements made
> sense.
>
> >
> > Can IWD detect if the network is WPA2+WPA3 or WPA3 only?
>
> Not really.  You can have a network composed of WPA3-only, WPA2-only or
> WPA2/WPA3 hybrid APs.
>
> About the only thing we can do is 'assume' WPA3 when:
> 1. The user entered a non-conforming passphrase, and
> 2. The current connection candidate is a WPA3-only AP,
> 3. Connection succeeded
>
> We'd then need to make sure to set the WPA2 transition disabled flag and make
> sure we don't try to generate / or save a PSK.  The transition disabled
> indication would make sure we can't connect to WPA2 APs in the same network.
>
From my non-expert POV, the above heuristics look perfectly reasonable.

To distinguish WPA3 only connections, from transition WPA2/WPA3
connections, one could store the profile as "$BSSID.sae" files. Where
the usual "$BSSID.psk" ones are preserved for WPA2 compatible
connections. To preserve backwards compatibility IWD could:
 - if the AP is WPA3 capable (regardless if it also supports WPA2) -
try the sae profile
 - if the connection is unsuccessful and the AP is WPA1/WPA2 capable -
try the psk profile

The above have some obvious caveats, but overall would help with:
 - providing clear distinction for the user about the connection types
 - keep connection type specifics where applicable - no more
PreSharedKey in .sae files, no SAE-PT-GroupXX in .psk files...
 - roaming between WPA2/WPA3 AP and WPA3-only AP with the same BSSID,
yet different passphrase

Mind you, I'm not sure if the last point is allowed in the spec. So
please take all the above with a healthy pinch of salt.

> >
> > It so, would it make sense to omit the `passphrase_len < 8 ||
> > passphrase_len > 63` restriction in crypto_passphrase_is_valid() when
> > the network is in WPA3 only case?
> >
>
> See above.  It is not that simple, but can be done.
>
Makes sense - for the time being I'll stick to 8-63 character
passphrases even for WPA3 only networks.

As always, thank you for the helpful and enlightening reply \o/
-Emil
