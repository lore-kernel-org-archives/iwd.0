Content-Type: multipart/mixed; boundary="===============0678433709180212880=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 2/2] station: remove diagnostic interface on
 station_free
Date: Wed, 28 Apr 2021 14:46:40 -0500
Message-ID: <b4e14669-5834-ab8e-43a9-47d7d90be6ef@gmail.com>
In-Reply-To: <20210428194012.149913-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0678433709180212880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/28/21 2:40 PM, James Prestwood wrote:
> If station gets removed ungracefully (e.g. rfkill/hotplug) it
> may not have a chance to disconnect, meaning the diagnostic
> interface would remain up.
> ---
>   src/station.c | 4 ++++
>   1 file changed, 4 insertions(+)
> =

> v5:
>   * called remove_interface directly as this is all we needed with
>     the state transition anyways.
> =


Applied, thanks.

Regards,
-Denis

--===============0678433709180212880==--

