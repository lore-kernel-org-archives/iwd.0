Content-Type: multipart/mixed; boundary="===============6693444712661853719=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] station: make autoconnect settable via debug interface
Date: Thu, 12 Aug 2021 16:59:32 -0500
Message-ID: <0660c88a-90b4-13da-d2cd-6cbae57bbc37@gmail.com>
In-Reply-To: <20210812203812.738060-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6693444712661853719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/12/21 3:38 PM, James Prestwood wrote:
> This adds the property "AutoConnect" to the station debug interface
> which can be read/written to disable or enable autoconnect globally.
> As one would expect this property is only going to be used for testing
> hence why it was put on the debug interface. Mosts tests disable
> autoconnect (or they should) because it leads to unexpected connections.
> ---
>   src/station.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============6693444712661853719==--

