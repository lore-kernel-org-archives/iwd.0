Content-Type: multipart/mixed; boundary="===============1954043200589698359=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/2] station: tie diagnostic interface cleanup to
 DISCONNECTING
Date: Wed, 28 Apr 2021 14:32:04 -0500
Message-ID: <1e11c959-0f19-c5b4-da85-be684392225c@gmail.com>
In-Reply-To: <20210428192701.149044-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1954043200589698359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/28/21 2:27 PM, James Prestwood wrote:
> Prior to this the diagnostic interface was taken down when station
> transitioned to DISCONNECTED. This worked but once station is in
> a DISCONNECTING state it then calls netdev_disconnect(). Trying to
> get any diagnostic data during this time may not work as its
> unknown what state exactly the kernel is in. To be safe take the
> interface down when station is DISCONNECTING.
> ---
>   src/station.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> =

> v4:
>   * Added this patch since the diagnostic data really only is
>     relavant when station is connected.
> =


Applied, thanks.

Regards,
-Denis

--===============1954043200589698359==--

