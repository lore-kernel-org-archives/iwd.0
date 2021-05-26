Content-Type: multipart/mixed; boundary="===============0315664107475351776=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Wed, 26 May 2021 09:05:34 +0200
Message-ID: <20210526070534.vtewwjiftzfxwki3@beryllium.lan>
In-Reply-To: <fee08251-7837-b7bf-61b8-76257aaf30ca@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0315664107475351776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ariel,

On Tue, May 25, 2021 at 06:53:44PM -0300, Ariel D'Alessandro wrote:
> On 5/19/21 4:32 AM, Daniel Wagner wrote:
> > The only thing you need to do is to extend the wifi.c plugin to set to
> > SAE if it's available when PSK is selected via the D-Bus API. As Marcel
> > pointed out this should not be exposed to the user.
> =

> Sorry, I'm not sure how to address that. I might be missing something
> here, so quick questions:
> =

> * Which D-Bus API call would set the service security to PSK even if
> it's registered as SAE capable?

This can be done via the Service API property Security.

> * Why is this a requirement and why should that go in plugin/wifi.c?

There is no need to expose implementation details to the user API. SAE
belongs to the family of PSK, hence if the user selects PSK via the
Service API, the implementation should choose the right protocol. Since
wpa_supplicant does not do this on it's own the plugin has to do this.

If you compare this to the iwd setup, the plugins/iwd.c does not even
know that SAE is used, it doesn't care. iwd does the right thing.

Basically this means, if SAE is available just use it, there is no need
to bother the user.
x
Hope this helps.

Thanks,
Daniel
--===============0315664107475351776==--

