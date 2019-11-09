Content-Type: multipart/mixed; boundary="===============2111096823318305941=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] scan: Separate cck rates attr creation into logical
 block
Date: Fri, 08 Nov 2019 20:40:48 -0600
Message-ID: <e0c2fe7e-ac8e-a987-0db0-e89735f8db02@gmail.com>
In-Reply-To: <6D926FBC-216A-4512-8040-B0CA569B0754@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2111096823318305941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>> +	if (L_WARN_ON(!(supported =3D wiphy_get_supported_rates(sc->wiphy,
>> +							NL80211_BAND_2GHZ,
>> +							&num_supported))))
>> +		return;
> =

> these kind of =E2=80=9Cnested=E2=80=9D statements become really hard to r=
ead and check if they are correct.
> =

> 	supported =3D wiphy_get_supported_rates(sc->wiphy, ..);
> 	if (L_WARN_ON(!supported))
> 		return;
> =

> I realize that this code is the same as below, but lets improve readabili=
ty as well. It is fine to submit a cleanup patch to improve readability if =
we find such places.

Actually, I explicitly requested that this be the way it is.  For =

L_WARN_ON, I want the resultant warning to carry as much info as =

possible.  Having a message like "Warning: !supported" show up is pretty =

pointless.  Yes it carries the line number and filename, but it still =

requires an extra step.  And things can change between different =

versions of iwd, etc.

So while the readability is a little worse, I think the hit is worth it =

for cases where L_WARN_ON is used.

Regards,
-Denis
--===============2111096823318305941==--

