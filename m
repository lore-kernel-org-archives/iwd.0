Content-Type: multipart/mixed; boundary="===============4929528841472865008=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH 6/6] station: disable roaming logic for auto-roaming cards
Date: Thu, 11 Mar 2021 19:02:05 +0000
Message-ID: <4bc419fb-cfe3-ac16-63f2-f947246ab5f0@bang-olufsen.dk>
In-Reply-To: <8890bcc3b9f00a5441f1392f1a4005cb333330d9.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4929528841472865008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/11/21 6:32 PM, James Prestwood wrote:
> Hi Alvin,
> =

> <snip>
> =

>> So to answer your question, I don't know directly, but then I did
>> some
>> searching online and found this thread[1] where a guy does the same
>> grep:
>>
>> $ strings /lib/firmware/brcm/brcmfmac43455-sdio.bin | grep Version
>> 43455c0-roml/43455_sdio-pno-aoe-pktfilter-pktctx-wfds-mfp-dfsradar-
>> wowlpf-idsup-idauth-noclminc-clm_min-obss-obssdump-swdiv-gtkoe-
>> roamprof-txbf-ve-sae-sr-okc-bpd
>> Version: ...
>>
>> And there I can see 'sae', so there's a good chance that this
>> firmware
>> supports SAE offload. For WPA3 and FT offload I don't know what the
>> corresponding string is but I believe (firmware driven) FT is a
>> standard
>> feature so it might not have its own string. More on that later...
> =

> As a side note here on SAE, would you mind just doing 'iw list' and
> seeing if SAE_OFFLOAD is listed in the extended feature list (for your
> card). I also see 'sae' when I grep the FW, but its still not included
> in ext features.

Sure - I just checked and `iw list | grep SAE` doesn't show anything.

> =

> I have trying this on a Raspberry Pi, which is the brcmfac43455-
> sdio.bin FW. I see you mentioned "cyfmac43455-sdio.bin", which I'm
> guessing is a non-released version or something? I got my FW from an
> official cypress release, Nov. 2020 I believe it was.

Hmm ok, so maybe the 'sae' string doesn't mean anything after all... =

sorry for the noise.

Regarding the filename stuff: Cypress decided to change the FW filenames =

at some point last year, which is a bit maddening because I believe this =

stuff is also considered ABI. But the brcmfmac* and cyfmac* =

.bin/clm_blob/txt files are pretty much interchangeable AFAIK, so long =

as the numerical part of the chipsets matche, regardless of the BCM or =

CYW prefix. If you use a mainline kernel, I think it expects brcmfmac* =

files. If you use the Cypress release (see link in my last reply), then =

it will want the cyfmac* files.

If you search the internet you will find RPi users also confused by =

this, and that it seems like both Broadcom and Cypress claim to be =

vendors of the RPi wireless chipset. KeithG seems to have the same =

experience. But renaming the files to whatever your driver is expecting =

is all you have to do.

The cyw*.bin files I grepped are from the Cypress FMAC/FW release I =

linked in my last mail. It's the same thing KeithG linked too - just =

that he linked the .zip directly. Another source of firmwares is from =

muRata, who make SoMs based on the Cypress chipsets. They have a =

separate release repository for firmwares[1] and maybe one of those =

might have SAE support. Otherwise I'm out of ideas...

Kind regards,
Alvin
--===============4929528841472865008==--

