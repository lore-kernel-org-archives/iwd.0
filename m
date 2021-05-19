Content-Type: multipart/mixed; boundary="===============5848321845340046805=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Wed, 19 May 2021 08:58:01 +0200
Message-ID: <D847F4C3-EB57-4426-B75A-F1395BE34CC6@holtmann.org>
In-Reply-To: <9c26382c-8053-d1b4-de45-48c0dce688f9@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5848321845340046805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ariel,

>>>> I am not really into the WiFi topic anymore, so I am adding the iwd
>>>> mailing list. Maybe we get some input for the new SAE Security
>>>> property, e.g. how this could work with iwd.
>>> =

>>> don=E2=80=99t change the Service API. Even WPA3 Personal is just PSK an=
d so there is
>>> no need to add another security property entry.
>> =

>> I somehow expected PSK also covers WPA3. This means any code for
>> enabling WPA3 for wpa_supplicant should go solely into plugins/wifi.c.
>> Thanks for clarifying this point.
> =

> Thanks for discussing the implementations details.
> =

> So AFAIU from the above, the patchset is implementing wpa_supplicant
> WPA3-SAE support in the right place: wifi plugin. Any change required? I
> understand that documentation should be updated probably, anything else?

if you need to update the Service API documentation, then you are doing som=
ething wrong.

>>> Actually if you are using iwd, then the detail between WPA2 and WPA3
>>> is never exposed to ConnMan.
>> =

>> Nice! I didn't know that iwd already supports WPA3.
> =

> I'm planning to extend the support to iwd in a follow-up patchset. I'd
> like to get this approved/merged first.

No idea what would be needed for iwd support. It already does support WPA3.=
 With iwd, no changes to ConnMan are needed for WPA3 support.

Regards

Marcel

--===============5848321845340046805==--

