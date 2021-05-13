Content-Type: multipart/mixed; boundary="===============7136169836316584179=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Thu, 13 May 2021 21:01:05 +0200
Message-ID: <386E1CEB-785C-4B14-97E7-396819BBF5D7@holtmann.org>
In-Reply-To: <20210513105319.7sgih2sbhrdn4dgz@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7136169836316584179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

>>> Implement WPA3-SAE authentication on connman side.
>>> =

>>> Based on Tizen project:
>>> =

>>>  https://review.tizen.org/git/?p=3Dplatform/upstream/connman.git
>>> =

>>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> =

>> Based on my understanding how this should work, this looks reasonable to=
 me.
> =

> Same here, this looks pretty straightforward. Thanks for picking this
> up.
> =

> The patch should be spitted into one which adds the SAE to the Security
> property of the Service API (please also update the documentation). The
> second patch adds the plugins/wifi.c implementation.
> =

> I am not really into the WiFi topic anymore, so I am adding the iwd
> mailing list. Maybe we get some input for the new SAE Security
> property, e.g. how this could work with iwd.

don=E2=80=99t change the Service API. Even WPA3 Personal is just PSK and so=
 there is no need to add another security property entry. Actually if you a=
re using iwd, then the detail between WPA2 and WPA3 is never exposed to Con=
nMan.

Frankly, if you want good WiFi support, ditch wpa_supplicant and run iwd.

Regards

Marcel

--===============7136169836316584179==--

