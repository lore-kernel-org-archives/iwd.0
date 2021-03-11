Content-Type: multipart/mixed; boundary="===============0857729622664425136=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: [PATCH 6/6] station: disable roaming logic for auto-roaming cards
Date: Thu, 11 Mar 2021 12:18:07 -0600
Message-ID: <CAG17S_NLxwqtJzLy8GmK+4EfqFuuC3Hktw3QLqBCqHW4oRsY5w@mail.gmail.com>
In-Reply-To: <8890bcc3b9f00a5441f1392f1a4005cb333330d9.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0857729622664425136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

James,

This is confusing to me as well. Since cypress took it over, they have
gone and renamed the driver cyfmac instead of brcmfmac. That is in
what is form cypress on their web pages:
https://community.cypress.com/gfawx74859/attachments/gfawx74859/resourcelib=
rary/1030/1/cypress-fmac-v5.4.18-2020_0925.zip
I was able to patch the kernel from this package and build it and it
builds the cyfmac* drivers. THese require the cyfmac firmware... IN
addiiton to building this patched kernel, I was also able to rename
them and make the firmware work with the (older) official brcmfmac
drivers. all in all confusing.

On Thu, Mar 11, 2021 at 11:32 AM James Prestwood <prestwoj@gmail.com> wro=
te:
>
> Hi Alvin,
>
> <snip>
>
> > So to answer your question, I don't know directly, but then I did
> > some
> > searching online and found this thread[1] where a guy does the same
> > grep:
> >
> > $ strings /lib/firmware/brcm/brcmfmac43455-sdio.bin | grep Version
> > 43455c0-roml/43455_sdio-pno-aoe-pktfilter-pktctx-wfds-mfp-dfsradar-
> > wowlpf-idsup-idauth-noclminc-clm_min-obss-obssdump-swdiv-gtkoe-
> > roamprof-txbf-ve-sae-sr-okc-bpd
> > Version: ...
> >
> > And there I can see 'sae', so there's a good chance that this
> > firmware
> > supports SAE offload. For WPA3 and FT offload I don't know what the
> > corresponding string is but I believe (firmware driven) FT is a
> > standard
> > feature so it might not have its own string. More on that later...
>
> As a side note here on SAE, would you mind just doing 'iw list' and
> seeing if SAE_OFFLOAD is listed in the extended feature list (for your
> card). I also see 'sae' when I grep the FW, but its still not included
> in ext features.
>
> I have trying this on a Raspberry Pi, which is the brcmfac43455-
> sdio.bin FW. I see you mentioned "cyfmac43455-sdio.bin", which I'm
> guessing is a non-released version or something? I got my FW from an
> official cypress release, Nov. 2020 I believe it was.
>
> Thanks,
> James
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
--===============0857729622664425136==--

