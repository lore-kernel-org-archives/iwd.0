Content-Type: multipart/mixed; boundary="===============6234812341222274608=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] wscutil: Add wsc_build_beacon
Date: Thu, 27 Aug 2020 19:12:03 -0500
Message-ID: <d3beec71-07b0-edb6-1fdc-5ab560734b12@gmail.com>
In-Reply-To: <CAOq732KP+Zub=SAcCQPOB5zBiN96eh6hON4yPQvDQt__0GG70Q@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6234812341222274608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>> +     /* These two "should be provided" if dual-band */
>>> +     if (beacon->rf_bands & (beacon->rf_bands - 1)) {
>>
>> I probably missed this in the earlier review, but would it be more clear=
 to
>> check rf_bands & ~WSC_RF_BAND_2_4_GHZ here instead?
> =

> That might be falsely triggered on a 5GHz-only AP.  I was gonna try
> something like:
> =

>    (rf_bands & 2_4_AND_5_MASK) =3D=3D 2_4_AND_5_MASK
> =

> as the condition, but ended up copying this from
> wsc_build_probe_response, I can change it in both places.

So whats the intent here? Only including RF bands if multiple bits are set?=
  If =

so then

__builtin_popcount(rf_bands) > 1 is what you want.

Regards,
-Denis
--===============6234812341222274608==--

