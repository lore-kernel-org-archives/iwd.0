Content-Type: multipart/mixed; boundary="===============5019321814716544826=="
MIME-Version: 1.0
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Tue, 18 May 2021 13:32:38 -0300
Message-ID: <9c26382c-8053-d1b4-de45-48c0dce688f9@collabora.com>
In-Reply-To: <20210514064733.v3pqwzmxahsinmqq@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5019321814716544826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel, Marcel,

On 5/14/21 3:47 AM, Daniel Wagner wrote:
> Hi Marcel,
> =

> On Thu, May 13, 2021 at 09:01:05PM +0200, Marcel Holtmann wrote:
>>> I am not really into the WiFi topic anymore, so I am adding the iwd
>>> mailing list. Maybe we get some input for the new SAE Security
>>> property, e.g. how this could work with iwd.
>>
>> don=E2=80=99t change the Service API. Even WPA3 Personal is just PSK and=
 so there is
>> no need to add another security property entry.
> =

> I somehow expected PSK also covers WPA3. This means any code for
> enabling WPA3 for wpa_supplicant should go solely into plugins/wifi.c.
> Thanks for clarifying this point.

Thanks for discussing the implementations details.

So AFAIU from the above, the patchset is implementing wpa_supplicant
WPA3-SAE support in the right place: wifi plugin. Any change required? I
understand that documentation should be updated probably, anything else?

> =

>> Actually if you are using iwd, then the detail between WPA2 and WPA3
>> is never exposed to ConnMan.
> =

> Nice! I didn't know that iwd already supports WPA3.

I'm planning to extend the support to iwd in a follow-up patchset. I'd
like to get this approved/merged first.

Thanks,
Ariel
--===============5019321814716544826==--

