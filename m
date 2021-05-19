Content-Type: multipart/mixed; boundary="===============8515817844942534898=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Wed, 19 May 2021 09:32:39 +0200
Message-ID: <20210519073239.u43a27gc4r3wmivh@beryllium.lan>
In-Reply-To: <D847F4C3-EB57-4426-B75A-F1395BE34CC6@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8515817844942534898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 19, 2021 at 08:58:01AM +0200, Marcel Holtmann wrote:
> > So AFAIU from the above, the patchset is implementing wpa_supplicant
> > WPA3-SAE support in the right place: wifi plugin. Any change required? I
> > understand that documentation should be updated probably, anything else?
> =

> if you need to update the Service API documentation, then you are
> doing something wrong.

The only thing you need to do is to extend the wifi.c plugin to set to
SAE if it's available when PSK is selected via the D-Bus API. As Marcel
pointed out this should not be exposed to the user.

Thanks,
DAniel
--===============8515817844942534898==--

