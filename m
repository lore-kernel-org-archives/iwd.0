Content-Type: multipart/mixed; boundary="===============1590890952488229178=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4/4] scan: Separate cck rates attr creation into logical
 block
Date: Sat, 09 Nov 2019 04:21:35 +0100
Message-ID: <50E8BFFC-2EF8-4E46-A7A7-C8BCE2CA7512@holtmann.org>
In-Reply-To: <e0c2fe7e-ac8e-a987-0db0-e89735f8db02@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1590890952488229178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>>> +	if (L_WARN_ON(!(supported =3D wiphy_get_supported_rates(sc->wiphy,
>>> +							NL80211_BAND_2GHZ,
>>> +							&num_supported))))
>>> +		return;
>> these kind of =E2=80=9Cnested=E2=80=9D statements become really hard to =
read and check if they are correct.
>> 	supported =3D wiphy_get_supported_rates(sc->wiphy, ..);
>> 	if (L_WARN_ON(!supported))
>> 		return;
>> I realize that this code is the same as below, but lets improve readabil=
ity as well. It is fine to submit a cleanup patch to improve readability if=
 we find such places.
> =

> Actually, I explicitly requested that this be the way it is.  For L_WARN_=
ON, I want the resultant warning to carry as much info as possible.  Having=
 a message like "Warning: !supported" show up is pretty pointless.  Yes it =
carries the line number and filename, but it still requires an extra step. =
 And things can change between different versions of iwd, etc.
> =

> So while the readability is a little worse, I think the hit is worth it f=
or cases where L_WARN_ON is used.

ok then, fair point. Can we somehow improve these cases with a comment to e=
ase reading and understanding the code.

Regards

Marcel

--===============1590890952488229178==--

