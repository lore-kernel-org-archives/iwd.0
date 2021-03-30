Content-Type: multipart/mixed; boundary="===============8093567904820930564=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 6/7] doc: document new [General].4WayOffload
Date: Tue, 30 Mar 2021 15:49:19 -0500
Message-ID: <7e89ecfe-3485-ecac-6e1f-e5a865ed2c9d@gmail.com>
In-Reply-To: <20210330184808.744574-6-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8093567904820930564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/30/21 1:48 PM, James Prestwood wrote:
> This option will allow the 4-way handshake to be offloaded to
> firmware if it supports it.
> ---
>   src/iwd.config.rst | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> =

> diff --git a/src/iwd.config.rst b/src/iwd.config.rst
> index 478bd616..e2060312 100644
> --- a/src/iwd.config.rst
> +++ b/src/iwd.config.rst
> @@ -174,6 +174,20 @@ The group ``[General]`` contains general settings.
>          off by default.  If you want to easily utilize Hotspot 2.0 netwo=
rks,
>          then setting ``DisableANQP`` to ``false`` is recommended.
>   =

> +   * - 4WayOffload
> +     - Values: **false**, true
> +
> +       Enables the use of 4-way handshake offloading. Some drivers can o=
ffload
> +       the 4-way handshake to firmware which is needed for protocols whi=
ch
> +       act on Authenticate/Associate frames such as Fast Transition. This
> +       option is turned off by default as it is not widely tested.

Well, this isn't really true.  Handshake offload is just that, not needing =
to =

perform it in userspace.  You can in theory have a SoftMac driver with hand=
shake =

offloading capabilities for example.

FT is a bit orthogonal and really depends on whether the firmware can roam =
by =

itself...

> +
> +       Note: There seems to be a bug in the brcmfmac driver/firmware whe=
re once
> +       offloading is enabled (by turning on this option) it cannot be tu=
rned
> +       off in the firmware without a hard reboot (or some means of resta=
rting
> +       the firmware).
> +
> +
>   Network
>   ---------
>   =

> =


Regards,
-Denis
--===============8093567904820930564==--

