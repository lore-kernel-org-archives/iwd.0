Content-Type: multipart/mixed; boundary="===============1612836983949672683=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Fri, 14 May 2021 08:47:33 +0200
Message-ID: <20210514064733.v3pqwzmxahsinmqq@beryllium.lan>
In-Reply-To: <386E1CEB-785C-4B14-97E7-396819BBF5D7@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1612836983949672683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Thu, May 13, 2021 at 09:01:05PM +0200, Marcel Holtmann wrote:
> > I am not really into the WiFi topic anymore, so I am adding the iwd
> > mailing list. Maybe we get some input for the new SAE Security
> > property, e.g. how this could work with iwd.
>
> don=E2=80=99t change the Service API. Even WPA3 Personal is just PSK and =
so there is
> no need to add another security property entry.

I somehow expected PSK also covers WPA3. This means any code for
enabling WPA3 for wpa_supplicant should go solely into plugins/wifi.c.
Thanks for clarifying this point.

> Actually if you are using iwd, then the detail between WPA2 and WPA3
> is never exposed to ConnMan.

Nice! I didn't know that iwd already supports WPA3.

Thanks,
Daniel
--===============1612836983949672683==--

