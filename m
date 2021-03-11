Content-Type: multipart/mixed; boundary="===============7776765624110573757=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 6/6] station: disable roaming logic for auto-roaming cards
Date: Thu, 11 Mar 2021 09:32:00 -0800
Message-ID: <8890bcc3b9f00a5441f1392f1a4005cb333330d9.camel@gmail.com>
In-Reply-To: <bd8195e8-5a46-7443-1458-2cd175523d98@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7776765624110573757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

<snip>

> So to answer your question, I don't know directly, but then I did
> some =

> searching online and found this thread[1] where a guy does the same
> grep:
> =

> $ strings /lib/firmware/brcm/brcmfmac43455-sdio.bin | grep Version
> 43455c0-roml/43455_sdio-pno-aoe-pktfilter-pktctx-wfds-mfp-dfsradar-
> wowlpf-idsup-idauth-noclminc-clm_min-obss-obssdump-swdiv-gtkoe-
> roamprof-txbf-ve-sae-sr-okc-bpd =

> Version: ...
> =

> And there I can see 'sae', so there's a good chance that this
> firmware =

> supports SAE offload. For WPA3 and FT offload I don't know what the =

> corresponding string is but I believe (firmware driven) FT is a
> standard =

> feature so it might not have its own string. More on that later...

As a side note here on SAE, would you mind just doing 'iw list' and
seeing if SAE_OFFLOAD is listed in the extended feature list (for your
card). I also see 'sae' when I grep the FW, but its still not included
in ext features.

I have trying this on a Raspberry Pi, which is the brcmfac43455-
sdio.bin FW. I see you mentioned "cyfmac43455-sdio.bin", which I'm
guessing is a non-released version or something? I got my FW from an
official cypress release, Nov. 2020 I believe it was.

Thanks,
James

--===============7776765624110573757==--

